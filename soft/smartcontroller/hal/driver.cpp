// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <queue>
#include <vector>
#include <chrono>
#include <thread>
#include <atomic>
#include <cstdlib>
#include <iostream>
#include <functional>
#include <condition_variable>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/driver.h"
#include "hal/log.h"
#include "hal/errors.h"
#include "hal/dev/w1/sensor.h"
#include "hal/dev/i2c_ext/factory.h"


namespace Hal
{

//=============================================================================
// TDriver::TTimer
//=============================================================================


/**
 * @brief A simple timer that works along with system sleep functions
 */
class TDriver::TTimer
{
public:
    typedef ::std::shared_ptr< TTimer > TPtr;
    typedef ::std::weak_ptr< TTimer > TWPtr;
    typedef ::std::function< void() > TCallback;

private:
    friend class TTimersManager;
    TTimer(const ::std::shared_ptr< TTimersManager >& manager,
            const TCallback& callback)
        : m_manager(manager),
          m_callback(callback),
          m_interval(0) // stopped
      {}

public:
    virtual ~TTimer() { Stop(); }

    void Start(int interval) noexcept;
    inline bool IsStarted() const noexcept { return m_interval > 0; }
    inline void Stop() noexcept;

private:
    const ::std::weak_ptr< TTimersManager > m_manager;
    const TCallback m_callback;

    int m_interval;
    int m_elapsed;    
}; // class TDriver::TTimer


//=============================================================================
// TDriver::TTimersManager
//=============================================================================


/**
 * @brief It creates and drives the timers.
 * @note Timers are not optimized for frequent creating/deleting.
 */
class TDriver::TTimersManager : public ::std::enable_shared_from_this< TTimersManager >
{
public:
    typedef ::std::shared_ptr< TTimersManager > TPtr;

    TTimersManager()
        : m_run(true),
          m_thread(&TTimersManager::Loop, this)
      {}

    virtual ~TTimersManager() { Stop(); }
    void Stop();

    TTimer::TPtr CreateTimer(const TTimer::TCallback& callback);

private:
    friend class TTimer;
    ::std::mutex m_mutex;
    ::std::vector< TTimer::TWPtr > m_timers;

    void Process(int& wait_interval);
    void PostProcess(int interval);

    ::std::atomic< bool > m_run;
    ::std::thread m_thread;
    void Loop();
}; // class TDriver::TTimersManager

//-----------------------------------------------------------------------------
void TDriver::TTimersManager::Stop()
{
    m_run.store(false, ::std::memory_order_relaxed);
    m_thread.join();
}

//-----------------------------------------------------------------------------
TDriver::TTimer::TPtr TDriver::TTimersManager::CreateTimer(
    const TTimer::TCallback& callback)
{
    TLockGuard lock(m_mutex);

    TTimer::TPtr timer(new TTimer(shared_from_this(), callback));
    m_timers.push_back(timer);
    return ::std::move(timer);
}

//-----------------------------------------------------------------------------
void TDriver::TTimersManager::Process(int& wait_interval)
{
    for(::std::size_t i = 0; i < m_timers.size(); i++)
    {
        TTimer::TPtr timer;
        TTimer::TCallback callback;
        {
            ::std::unique_lock< ::std::mutex > lock(m_mutex);

            timer = m_timers[i].lock();
            if (!(timer && timer->IsStarted()))
            {
                continue;
            }
            assert(timer.use_count() > 1);

            const int diff = timer->m_interval - timer->m_elapsed;
            if (diff <= 0)
            {
                timer->m_elapsed = 0;
                callback = timer->m_callback;
            }
            else if (diff < wait_interval)
            {
                wait_interval = diff;
            }
        }

        if (callback)
        {
            try
            {
                callback();
            }
            catch(...)
            {
                LOG_ERROR(g_log_section, "unknown error");
            }
        }
    }
}

//-----------------------------------------------------------------------------
void TDriver::TTimersManager::PostProcess(int passed_time_interval)
{
    TLockGuard lock(m_mutex);

    for(auto itr = m_timers.begin(); itr != m_timers.end(); ++itr)
    {
        TTimer::TPtr timer = itr->lock();
        while (!timer)
        {
            itr = m_timers.erase(itr);
            if (m_timers.end() == itr)
            {
                return;
            }
            timer = itr->lock();
        }

        assert(timer);
        if (timer->IsStarted())
        {
            timer->m_elapsed += passed_time_interval;
        }
    }
}

//-----------------------------------------------------------------------------
void TDriver::TTimersManager::Loop()
{
    while(m_run.load(::std::memory_order_relaxed))
    {
        static const int RESOLUTION = 1000; // ms
        int wait_interval = RESOLUTION;

        Process(wait_interval);
        ::std::this_thread::sleep_for(::std::chrono::milliseconds(wait_interval));
        PostProcess(wait_interval);
    }
}


//=============================================================================
// TDriver::TTimer
//=============================================================================


//-----------------------------------------------------------------------------
void TDriver::TTimer::Start(int interval) noexcept
{
    TTimersManager::TPtr manager = m_manager.lock();
    assert(manager);

    TLockGuard lock(manager->m_mutex);
    m_elapsed = 0;
    m_interval = interval;
}

//-----------------------------------------------------------------------------
void TDriver::TTimer::Stop() noexcept
{
    TTimersManager::TPtr manager = m_manager.lock();
    assert(manager);

    TLockGuard lock(manager->m_mutex);
    m_interval = 0;
}


//=============================================================================
// TDriver::TDebouncer
//=============================================================================


/**
 * @brief It filters out interrupt bouncing.
 */
class TDriver::TInterruptDebouncer
{
public:
    /// Every status needs to be stable at least for the specified
    /// amount of time
    static const int MIN_STABLE_INTERVAL = 100; // ms

    TInterruptDebouncer()
        : m_unstable_statuses(0x0000)
      {}

    void Init(unsigned statuses) noexcept { m_last_statuses = statuses; }
    void OnInterrupt(unsigned statuses) noexcept;
    unsigned Run() noexcept;
    inline unsigned LastStatuses() const noexcept { return m_last_statuses; }

private:
    typedef ::std::chrono::system_clock TClock;

    unsigned m_last_statuses; //<! Last interrupts statuses

    /// The statuses that have just been changed.
    unsigned m_unstable_statuses;
    ::std::array< TClock::time_point, INTERRUPTS_COUNT > m_times;
};

const int TDriver::TInterruptDebouncer::MIN_STABLE_INTERVAL;

//-----------------------------------------------------------------------------
void TDriver::TInterruptDebouncer::OnInterrupt(unsigned statuses) noexcept
{
    const unsigned changes = statuses ^ m_last_statuses;

    const TClock::time_point now = TClock::now();
    const TClock::time_point t =
        now + ::std::chrono::milliseconds(MIN_STABLE_INTERVAL);
    unsigned mask = 0x0001;
    for(unsigned i = 0; i < INTERRUPTS_COUNT; i++)
    {
        if (changes & mask)
        {
            m_times[i] = t;
            m_unstable_statuses ^= mask;
        }

        mask <<= 1;
    }

    m_last_statuses = statuses;
}

//-----------------------------------------------------------------------------
unsigned TDriver::TInterruptDebouncer::Run() noexcept
{
    unsigned stable_statuses = 0x0000;
        
    unsigned mask = 0x0001;
    const TClock::time_point now = TClock::now();
    for(unsigned i = 0; i < INTERRUPTS_COUNT; i++)
    {
        if (m_unstable_statuses & mask)
        {
            if (m_times[i] < now)
            {
                stable_statuses |= mask;
            }
        }

        mask <<= 1;
    }
    m_unstable_statuses &= ~stable_statuses;

    /*if (stable_statuses)
    {
        ::std::cout << "stable statuses: " << stable_statuses
                    << ", status: " << m_last_status << '\n';
    }*/

    return stable_statuses;
}


//=============================================================================
// TDriver::TInterruptsDispatcher
//=============================================================================


/**
 * @brief It queues and dispatches queued interrupts to upper layers from
 *        its own thread. Hence, it prevents blocking interrupt listener thread
 *        due to possible long callback processing times.
 */
class TDriver::TInterruptsDispatcher
{
public:
    TInterruptsDispatcher(TDriver& driver)
        : m_driver(driver)
      {}

    ~TInterruptsDispatcher();

    void Start();
    void Post(unsigned changed, unsigned statuses, int error);

private:
    TDriver& m_driver;

    ::std::atomic< bool > m_run;
    ::std::thread m_thread;
    void Loop();

    ::std::mutex m_mutex;
    ::std::condition_variable m_event;

    struct TInterrupt
    {
        TInterrupt() = default;
        TInterrupt(unsigned changed, unsigned statuses, int error)
            : m_changed(changed),
              m_statuses(statuses),
              m_error(error)
          {}

        unsigned m_changed; ///< Changed statuses
        unsigned m_statuses; ///< Actual statuses
        int m_error;
    };
    static const ::std::size_t QUEUE_MAX_SIZE = 32;
    ::std::queue< TInterrupt > m_queue;
}; // class TDriver::TInterruptsDispatcher

//-----------------------------------------------------------------------------
TDriver::TInterruptsDispatcher::~TInterruptsDispatcher()
{
    bool expected = true;
    if (m_run.compare_exchange_strong(expected, false))
    {
        m_event.notify_one();
        m_thread.join();
    }
}

//-----------------------------------------------------------------------------
void TDriver::TInterruptsDispatcher::Start()
{
    m_run.store(true, ::std::memory_order_relaxed);
    try
    {
        m_thread = ::std::thread(&TInterruptsDispatcher::Loop, this);
    }
    catch(...)
    {
        m_run.store(false, ::std::memory_order_relaxed);
        throw;
    }
}

//-----------------------------------------------------------------------------
void TDriver::TInterruptsDispatcher::Post(
        unsigned changed, unsigned statuses, int error)
{
    TLockGuard lock(m_mutex);
    if (m_queue.size() < QUEUE_MAX_SIZE)
    {
        m_queue.push(TInterrupt(changed, statuses, error));
        m_event.notify_one();
    }
    else
    {
        LOG_ERROR(g_log_section, "the queue is full, interrupt skipped");
    }
}

//-----------------------------------------------------------------------------
void TDriver::TInterruptsDispatcher::Loop()
{
    while(m_run.load(::std::memory_order_relaxed))
    {
        ::std::unique_lock< ::std::mutex > lock(m_mutex);

        if (m_queue.empty())
        {
            m_event.wait(lock);
        }

        while(m_queue.size())
        {
            const TInterrupt interrupt = m_queue.front();
            m_queue.pop();

            lock.unlock();
            try
            {
                m_driver.OnInterrupt(interrupt.m_changed, interrupt.m_statuses,
                        interrupt.m_error);
            }
            catch(...)
            {
                LOG_ERROR(g_log_section, "unknown error, continuing");
            }
            lock.lock();
        }
    } // while
}


//=============================================================================
// TDriver::TInterruptsListener
//=============================================================================


/**
 * @brief It listens to GPIO interrupts
 */
class TDriver::TInterruptsListener
{
public:
    TInterruptsListener(TDriver& driver)
        : m_driver(driver),
          m_dispatcher(driver),
          m_run(false)
      {}

    ~TInterruptsListener();

    void Start();

private:
    TDriver& m_driver;
    TInterruptDebouncer m_debouncer;
    TInterruptsDispatcher m_dispatcher;

    ::std::atomic< bool > m_run;
    ::std::thread m_thread;
    void Loop();
}; // class TDriver::TInterruptsListener

//-----------------------------------------------------------------------------
TDriver::TInterruptsListener::~TInterruptsListener()
{
    bool expected = true;
    if (m_run.compare_exchange_strong(expected, false))
    {
        m_thread.join();
    }
}

//-----------------------------------------------------------------------------
void TDriver::TInterruptsListener::Start()
{
    assert(!m_run.load(::std::memory_order_relaxed));

    m_debouncer.Init(m_driver.InterruptsGetStatuses());

    m_run.store(true, ::std::memory_order_relaxed);
    try
    {
        m_thread = ::std::thread(&TInterruptsListener::Loop, this);
    }
    catch(...)
    {
        m_run.store(false, ::std::memory_order_relaxed);
        throw;
    }

    m_dispatcher.Start();
}

//-----------------------------------------------------------------------------
void TDriver::TInterruptsListener::Loop()
{
    while(m_run.load(::std::memory_order_relaxed))
    {
        TErrorCode error = EC_NO_ERROR;
        try
        {

            while(m_run.load(::std::memory_order_relaxed))
            {
                if (m_driver.WaitForInterrupt(
                    TInterruptDebouncer::MIN_STABLE_INTERVAL))
                {
                    // Interrupt

                    const unsigned status = m_driver.InterruptsGetStatuses();
                    m_debouncer.OnInterrupt(status);
                }
                else
                {
                    // Time out
                }

                const unsigned interrupts = m_debouncer.Run();
                if (interrupts)
                {
                    m_dispatcher.Post(interrupts, m_debouncer.LastStatuses(), error);
                }
            } // while

        }
        catch(const TException& e)
        {
            LOG_ERROR(g_log_section, e.ToString());
            error = e.m_error;
        }
        catch(...)
        {
            LOG_ERROR(g_log_section, "unknown error, continuing");
            error = EC_UNKNOWN;
        }
        if (EC_NO_ERROR != error)
        {
            m_dispatcher.Post(0, 0, error);
        }

        ::std::this_thread::sleep_for(
            ::std::chrono::milliseconds(TInterruptDebouncer::MIN_STABLE_INTERVAL));
    } // while
}


//=============================================================================
// TDriver
//=============================================================================


//-----------------------------------------------------------------------------
TDriver::TDriver()
    : m_timers_manager(new TTimersManager()),
      m_mcp23017_u2(Dev::TMcp23017_U2::Instance()),
      m_mcp23017_u4(Dev::TMcp23017_U4::Instance()),
      m_ad5245(Dev::TAd5245::Instance()),
      m_htu21d(Dev::THtu21D::Instance()),
      m_ds1338(Dev::TDs1338::Instance()),
      m_ad7993(Dev::TAd7993::Instance()),
      m_w1_bus(Dev::W1::TBus::Instance()),
      m_devices({{
          m_mcp23017_u2.get(),  m_mcp23017_u4.get(),  m_ad5245.get(),
          m_htu21d.get(), m_ds1338.get(), m_ad7993.get(), m_w1_bus.get()
        }}),
      m_humidity_timer(m_timers_manager->CreateTimer(
            [this]()->void { OnReadHumidity(); })),
      m_temperature_timer(m_timers_manager->CreateTimer(
            [this]()->void { OnReadTemperature(); })),
      m_adc_channels_periodic_update({{
          TAdcChannelPeriodicUpdate(*this, *m_timers_manager, ADC_CH1),
          TAdcChannelPeriodicUpdate(*this, *m_timers_manager, ADC_CH2),
          TAdcChannelPeriodicUpdate(*this, *m_timers_manager, ADC_CH3),
          TAdcChannelPeriodicUpdate(*this, *m_timers_manager, ADC_CH4)
          }}),
      m_co_timer(m_timers_manager->CreateTimer([this]()->void { OnReadCo(); })),
      m_co2_timer(m_timers_manager->CreateTimer([this]()->void { OnReadCo2(); })),
      m_interrupts_listener(new TInterruptsListener(*this))
{
}

//-----------------------------------------------------------------------------
TDriver::~TDriver()
{
}

//-----------------------------------------------------------------------------
void TDriver::Configure()
{
    {
        TLockGuard lock(m_mutex);

        for(::std::size_t i = 0; i < m_devices.size(); i++)
        {
            //try
            //{
                m_devices[i]->Configure();
            //}
            //catch(const TException& e)
            //{
            //    ::std::cout << i << '\n';
            //}
        }
    }

    m_interrupts_listener->Start();
}

//-----------------------------------------------------------------------------
unsigned TDriver::InterruptsGetStatuses()
{
    TLockGuard lock(m_mutex);

    const unsigned mask = m_mcp23017_u4->ReadInterrupts();
    return mask;
}

//-----------------------------------------------------------------------------
void TDriver::InterruptsRegisterHandler(const TInterruptsHandler& handler)
{
    TLockGuard lock(m_mutex);
    m_interrupts_handler = handler;
}

//-----------------------------------------------------------------------------
bool TDriver::WaitForInterrupt(int timeout)
{
    return m_mcp23017_u4->WaitForInterrupt(timeout);
}

//-----------------------------------------------------------------------------
void TDriver::OnInterrupt(unsigned changed, unsigned statuses, int error)
{
    TInterruptsHandler handler;
    {
        TLockGuard lock(m_mutex);
        if (!m_interrupts_handler)
        {
            return;
        }
        handler = m_interrupts_handler;
    }
    handler(changed, statuses, error);
}

//-----------------------------------------------------------------------------
void TDriver::RelaySetPosition(TRelayId id, bool position)
{
    TLockGuard lock(m_mutex);
    m_mcp23017_u2->Relay(id, position);
}

//-----------------------------------------------------------------------------
void TDriver::RelaysReset()
{
    TLockGuard lock(m_mutex);
    m_mcp23017_u2->RelaysReset();
}

//-----------------------------------------------------------------------------
void TDriver::LedSetState(TLedId id, bool on)
{
    TLockGuard lock(m_mutex);
    m_mcp23017_u2->Led(id, on);
}

//-----------------------------------------------------------------------------
void TDriver::RtcSet(const TRtcTime& time)
{
    TLockGuard lock(m_mutex);
    m_ds1338->WriteTime(time);
}

//-----------------------------------------------------------------------------
bool TDriver::RtcGet(TRtcTime& time)
{
    TLockGuard lock(m_mutex);
    const bool running = m_ds1338->ReadTime(time);
    return running;
}

//-----------------------------------------------------------------------------
float TDriver::HumidityGetValue()
{
    TLockGuard lock(m_mutex);
    return m_htu21d->ReadHumidity();
}

//-----------------------------------------------------------------------------
void TDriver::HumidityPeriodicUpdateStart(int interval,
    const THumidityCallback& callback)
{
    assert(static_cast< bool >(callback));

    TLockGuard lock(m_mutex);
    m_humidity_callback = callback;
    m_humidity_timer->Start(interval);
}

//-----------------------------------------------------------------------------
void TDriver::HumidityPeriodicUpdateStop() noexcept
{
    TLockGuard lock(m_mutex);
    m_humidity_timer->Stop();
}

//-----------------------------------------------------------------------------
void TDriver::OnReadHumidity() noexcept
{
    float value;
    TErrorCode error = EC_NO_ERROR;
    THumidityCallback callback;
    {
        TLockGuard lock(m_mutex);

        try
        {
            value = m_htu21d->ReadHumidity();
        }
        catch(const TException& e)
        {
            LOG_ERROR(g_log_section, e.ToString());
            error = e.m_error;
        }
        catch(...)
        {
            LOG_ERROR(g_log_section, "unknown error");
            error = EC_UNKNOWN;
        }

        callback = m_humidity_callback;
    }
    callback(value, error);
}

//-----------------------------------------------------------------------------
float TDriver::TemperatureGetValue()
{
    TLockGuard lock(m_mutex);
    return m_htu21d->ReadTemperature();
}

//-----------------------------------------------------------------------------
void TDriver::TemperaturePeriodicUpdateStart(int interval,
    const TTemperatureCallback& callback)
{
    assert(static_cast< bool >(callback));

    TLockGuard lock(m_mutex);
    m_temperature_callback = callback;
    m_temperature_timer->Start(interval);
}

//-----------------------------------------------------------------------------
void TDriver::TemperaturePeriodicUpdateStop() noexcept
{
    TLockGuard lock(m_mutex);
    m_temperature_timer->Stop();
}

//-----------------------------------------------------------------------------
void TDriver::OnReadTemperature() noexcept
{
    float value;
    TErrorCode error = EC_NO_ERROR;
    TTemperatureCallback callback;
    {
        TLockGuard lock(m_mutex);

        try
        {
            value = m_htu21d->ReadTemperature();
        }
        catch(const TException& e)
        {
            LOG_ERROR(g_log_section, e.ToString());
            error = e.m_error;
        }
        catch(...)
        {
            LOG_ERROR(g_log_section, "unknown error");
            error = EC_UNKNOWN;
        }

        callback = m_temperature_callback;
    }
    callback(value, error);
}

//-----------------------------------------------------------------------------
Dev::TAd7993::TInputId TDriver::AdcChannelToInputId(TAdcChannelId channel_id)
{
    switch(channel_id)
    {
    case ADC_CH1: return Dev::TAd7993::VIN1;
    case ADC_CH2: return Dev::TAd7993::VIN4;
    case ADC_CH3: return Dev::TAd7993::VIN3;
    case ADC_CH4: return Dev::TAd7993::VIN2;
    }
    assert(!"invalid channel id");
    return Dev::TAd7993::VIN1;
}

//-----------------------------------------------------------------------------
unsigned TDriver::AdcGetRawValue(TAdcChannelId channel_id)
{
    TLockGuard lock(m_mutex);
    const Dev::TAd7993::TInputId input_id = AdcChannelToInputId(channel_id);
    return m_ad7993->Convert(input_id);
}

//-----------------------------------------------------------------------------
void TDriver::AdcSetLowLimit(TAdcChannelId channel_id, unsigned threshold)
{
    TLockGuard lock(m_mutex);
    const Dev::TAd7993::TInputId input_id = AdcChannelToInputId(channel_id);
    m_ad7993->WriteLowLimit(input_id, threshold);
}

//-----------------------------------------------------------------------------
void TDriver::AdcSetHighLimit(TAdcChannelId channel_id, unsigned threshold)
{
    TLockGuard lock(m_mutex);
    const Dev::TAd7993::TInputId input_id = AdcChannelToInputId(channel_id);
    m_ad7993->WriteHighLimit(input_id, threshold);
}

//-----------------------------------------------------------------------------
void TDriver::AdcGetAlerts(TAdcChannelId channel_id, bool& low, bool& high)
{
    TLockGuard lock(m_mutex);
    const Dev::TAd7993::TInputId input_id = AdcChannelToInputId(channel_id);
    m_ad7993->ReadAlerts(input_id, low, high);
}

//-----------------------------------------------------------------------------
void TDriver::AdcPeriodicUpdateStart(TAdcChannelId channel_id, int interval,
                                     const TAdcCallback& callback)
{
    assert(channel_id < ADC_CHANNELS_COUNT);

    TLockGuard lock(m_mutex);
    m_adc_channels_periodic_update[channel_id].Start(interval, callback);
}

//-----------------------------------------------------------------------------
void TDriver::AdcPeriodicUpdateStop(TAdcChannelId channel_id) noexcept
{
    assert(channel_id < ADC_CHANNELS_COUNT);

    TLockGuard lock(m_mutex);
    m_adc_channels_periodic_update[channel_id].Stop();
}

//-----------------------------------------------------------------------------
TDriver::TAdcChannelPeriodicUpdate::TAdcChannelPeriodicUpdate(TDriver& parent,
    TTimersManager& timers_manager, TAdcChannelId channel_id)
    : m_parent(parent),
      m_channel_id(channel_id),
      m_timer(timers_manager.CreateTimer([this]()->void { OnRead(); }))
{
}

//-----------------------------------------------------------------------------
void TDriver::TAdcChannelPeriodicUpdate::Start(int interval,
                                               const TAdcCallback& callback)
{
    assert(static_cast< bool >(callback));

    m_callback = callback;
    m_timer->Start(interval);
}

//-----------------------------------------------------------------------------
void TDriver::TAdcChannelPeriodicUpdate::Stop()
{
    m_timer->Stop();
}

//-----------------------------------------------------------------------------
void TDriver::TAdcChannelPeriodicUpdate::OnRead() noexcept
{
    unsigned value;
    TErrorCode error = EC_NO_ERROR;
    TAdcCallback callback;
    {
        TLockGuard lock(m_parent.m_mutex);

        try
        {
            const Dev::TAd7993::TInputId input_id = AdcChannelToInputId(m_channel_id);
            value = m_parent.m_ad7993->Convert(input_id);
        }
        catch(const TException& e)
        {
            LOG_ERROR(g_log_section, e.ToString());
            error = e.m_error;
        }
        catch(...)
        {
            LOG_ERROR(g_log_section, "unknown error");
            error = EC_UNKNOWN;
        }

        callback = m_callback;
    }
    callback(m_channel_id, value, error);
}

//-----------------------------------------------------------------------------
unsigned TDriver::CoGetValue()
{
    unsigned raw_value;
    {
        TLockGuard lock(m_mutex);
        raw_value = m_ad7993->Convert(Dev::TAd7993::VIN1);
    }
    return CoScaleValue(raw_value);
}

//-----------------------------------------------------------------------------
unsigned TDriver::CoScaleValue(unsigned raw_value)
{
    static const float MAX_VOLTAGE = 3.3;
    static const float RANGE = 10000;
    static const float QUANT = RANGE / MAX_VOLTAGE;
    const unsigned value =
            (static_cast< float >(raw_value) * Dev::TAd7993::QUANT) * QUANT;
    return value;
}

//-----------------------------------------------------------------------------
bool TDriver::CoGetState()
{
    TLockGuard lock(m_mutex);
    return m_mcp23017_u4->ReadCoState();
}

//-----------------------------------------------------------------------------
void TDriver::CoSetThreshold(unsigned threshold)
{
    static const unsigned RANGE = 10000;
    static const float QUANT = RANGE / Dev::TAd5245::RANGE;
    if (threshold > RANGE - QUANT)
    {
        threshold = RANGE - QUANT;
    }

    const unsigned position = (static_cast< float >(threshold) / QUANT);
    {
        TLockGuard lock(m_mutex);
        m_ad5245->Position(position);
    }
}

//-----------------------------------------------------------------------------
void TDriver::CoPeriodicUpdateStart(int interval, const TCoCallback& callback)
{
    assert(static_cast< bool >(callback));

    TLockGuard lock(m_mutex);
    m_co_callback = callback;
    m_co_timer->Start(interval);
}

//-----------------------------------------------------------------------------
void TDriver::CoPeriodicUpdateStop()
{
    TLockGuard lock(m_mutex);
    m_co_timer->Stop();
}

//-----------------------------------------------------------------------------
void TDriver::OnReadCo() noexcept
{
    unsigned value;
    TErrorCode error = EC_NO_ERROR;
    TCoCallback callback;
    {
        TLockGuard lock(m_mutex);

        try
        {
            const unsigned raw_value = m_ad7993->Convert(Dev::TAd7993::VIN1);
            value = CoScaleValue(raw_value);
        }
        catch(const TException& e)
        {
            LOG_ERROR(g_log_section, e.ToString());
            error = e.m_error;
        }
        catch(...)
        {
            LOG_ERROR(g_log_section, "unknown error");
            error = EC_UNKNOWN;
        }

        callback = m_co_callback;
    }
    callback(value, error);
}

//-----------------------------------------------------------------------------
float TDriver::Co2GetValue()
{
#ifndef SIM
    TLockGuard lock(m_mutex);
    // TODO:
    return 0;
#else
    return (::std::rand() % 10) + 1000;
#endif
}

//-----------------------------------------------------------------------------
void TDriver::Co2PeriodicUpdateStart(int interval, const TCo2Callback& callback)
{
    assert(static_cast< bool >(callback));

    TLockGuard lock(m_mutex);
    m_co2_callback = callback;
    m_co2_timer->Start(interval);
}

//-----------------------------------------------------------------------------
void TDriver::Co2PeriodicUpdateStop()
{
    TLockGuard lock(m_mutex);
    m_co2_timer->Stop();
}

//-----------------------------------------------------------------------------
void TDriver::OnReadCo2() noexcept
{
    float value;
    TErrorCode error = EC_NO_ERROR;
    TCo2Callback callback;
    {
        TLockGuard lock(m_mutex);

        try
        {
            value = 0;
    #ifndef SIM // TODO: remove me
            error = EC_UNKNOWN;
    #endif
        }
        catch(const TException& e)
        {
            LOG_ERROR(g_log_section, e.ToString());
            error = e.m_error;
        }
        catch(...)
        {
            LOG_ERROR(g_log_section, "unknown error");
            error = EC_UNKNOWN;
        }

        callback = m_co2_callback;
    }
    callback(value, error);
}

//-----------------------------------------------------------------------------
void TDriver::W1Enumerate(TW1DevicesInfo& devices_info)
{
    TLockGuard lock(m_mutex);

    m_w1_devices_periodic_update.clear();
    devices_info.clear();

    m_w1_bus->Enumerate();

    for(::std::size_t i = 0; i < m_w1_bus->Sensors().size(); i++)
    {
        const Dev::W1::TSensor& sensor = *m_w1_bus->Sensors()[i];

        devices_info.push_back(sensor.Info());
        m_w1_devices_periodic_update.emplace_back(
            new TW1DevicePeriodicUpdate(*this, *m_timers_manager, sensor.Info()));
    }
}

//-----------------------------------------------------------------------------
float TDriver::W1GetValue(const TW1DeviceAddress& address, const TLockGuard&)
{
    const unsigned device_id = W1AddressToDeviceId(address);
    const Dev::W1::TBus::TSensors& sensors = m_w1_bus->Sensors();
    return sensors[device_id]->ReadValue();
}

//-----------------------------------------------------------------------------
float TDriver::W1GetValue(const TW1DeviceAddress& address, TW1DeviceType& type)
{
    TLockGuard lock(m_mutex);

    const unsigned device_id = W1AddressToDeviceId(address);
    const Dev::W1::TBus::TSensors& sensors = m_w1_bus->Sensors();
    type = sensors[device_id]->Info().m_type;
    return sensors[device_id]->ReadValue();
}

//-----------------------------------------------------------------------------
void TDriver::W1PeriodicUpdateStart(const TW1DeviceAddress& address,
                                    int interval, const TW1Callback& callback)
{
    TLockGuard lock(m_mutex);
    const unsigned device_id = W1AddressToDeviceId(address);
    m_w1_devices_periodic_update[device_id]->Start(interval, callback);
}

//-----------------------------------------------------------------------------
void TDriver::W1PeriodicUpdateStop(const TW1DeviceAddress& address)
{
    TLockGuard lock(m_mutex);
    const unsigned device_id = W1AddressToDeviceId(address);
    m_w1_devices_periodic_update[device_id]->Stop();
}

//-----------------------------------------------------------------------------
unsigned TDriver::W1AddressToDeviceId(const TW1DeviceAddress& address) const
{
    // Since there are not many W1 devices, linear search will do.
    using namespace Dev::W1;

    const TBus::TSensors& sensors = m_w1_bus->Sensors();
    for(unsigned id = 0; id < sensors.size(); id++)
    {
        if (sensors[id]->Info().m_address == address)
        {
            return id;
        }
    }
    THROW_EXCEPTION(TInvalidArgumentError("address"));
    return -1; // To get rid of the compiler warning
}

//-----------------------------------------------------------------------------
TDriver::TW1DevicePeriodicUpdate::TW1DevicePeriodicUpdate(TDriver& parent,
    TTimersManager& timers_manager, const TW1DeviceInfo& device_info)
    : m_parent(parent),
      m_device_info(device_info),
      m_timer(timers_manager.CreateTimer([this]()->void { OnRead(); }))
{
}

//-----------------------------------------------------------------------------
void TDriver::TW1DevicePeriodicUpdate::Start(int interval,
                                             const TW1Callback& callback)
{
    assert(static_cast< bool >(callback));

    m_callback = callback;
    m_timer->Start(interval);
}

//-----------------------------------------------------------------------------
void TDriver::TW1DevicePeriodicUpdate::Stop()
{
    m_timer->Stop();
}


//-----------------------------------------------------------------------------
void TDriver::TW1DevicePeriodicUpdate::OnRead() noexcept
{
    // Enumeration might delete the object so just in case we hold a reference until
    // the handler exits.
    const TPtr me = shared_from_this();

    float value;
    TErrorCode error = EC_NO_ERROR;
    try
    {
        TLockGuard lock(m_parent.m_mutex);
        value = m_parent.W1GetValue(m_device_info.m_address, lock);
    }
    catch(const TException& e)
    {
        LOG_ERROR(g_log_section, e.ToString());
        error = e.m_error;
    }
    catch(...)
    {
        LOG_ERROR(g_log_section, "unknown error");
        error = EC_UNKNOWN;
    }
    m_callback(m_device_info, value, error);
}

//-----------------------------------------------------------------------------
void TDriver::I2cDeviceEnable(TI2cDeviceType type)
{
    assert(type < I2C_DEVICE_TYPES_COUNT);

    TLockGuard lock(m_mutex);

    TI2cDevicePeriodicUpdate::TPtr& device_update =
            m_i2c_devices_periodic_update[type];
    if (device_update)
    {
        // already enabled
        return;
    }


    using namespace Dev::I2cExt;

    TFactory factory;
    TSensor::TUPtr sensor(factory.Create(type));
    sensor->Configure();

    device_update.reset(new TI2cDevicePeriodicUpdate(*this, ::std::move(sensor)));
}

//-----------------------------------------------------------------------------
void TDriver::I2cDeviceDisable(TI2cDeviceType type)
{
    assert(type < I2C_DEVICE_TYPES_COUNT);

    TLockGuard lock(m_mutex);
    m_i2c_devices_periodic_update[type].reset();
}

//-----------------------------------------------------------------------------
float TDriver::I2cGetValue(TI2cDeviceType type)
{
    assert(type < I2C_DEVICE_TYPES_COUNT);

    TLockGuard lock(m_mutex);

    TI2cDevicePeriodicUpdate::TPtr& device_update =
            m_i2c_devices_periodic_update[type];
    if (device_update)
    {
        return device_update->m_device->ReadValue();
    }
    else
    {
        THROW_EXCEPTION(TResourceNotAvailableError());
    }
    return 0;
}

//-----------------------------------------------------------------------------
void TDriver::I2cPeriodicUpdateStart(TI2cDeviceType type, int interval,
        const TI2cCallback& callback)
{
    assert(type < I2C_DEVICE_TYPES_COUNT);
    assert(callback);

    TLockGuard lock(m_mutex);

    TI2cDevicePeriodicUpdate::TPtr& device_update =
            m_i2c_devices_periodic_update[type];
    if (device_update)
    {
        device_update->m_callback = callback;
        device_update->m_timer->Start(interval);
    }
    else
    {
        THROW_EXCEPTION(TResourceNotAvailableError());
    }
}

//-----------------------------------------------------------------------------
void TDriver::I2cPeriodicUpdateStop(TI2cDeviceType type) noexcept
{
    TLockGuard lock(m_mutex);

    assert(type < I2C_DEVICE_TYPES_COUNT);
    m_i2c_devices_periodic_update[type]->m_timer->Stop();
}

//-----------------------------------------------------------------------------
TDriver::TI2cDevicePeriodicUpdate::TI2cDevicePeriodicUpdate(TDriver& parent,
    Dev::I2cExt::TSensor::TUPtr device)
    : m_parent(parent),
      m_device(::std::move(device)),
      m_timer(parent.m_timers_manager->CreateTimer([this]()->void { OnRead(); }))
{
}

//-----------------------------------------------------------------------------
void TDriver::TI2cDevicePeriodicUpdate::OnRead() noexcept
{
    // Disabling might delete the object so just in case we hold a reference until
    // the handler exits.
    const TPtr me = shared_from_this();

    float value;
    TErrorCode error = EC_NO_ERROR;
    try
    {
        TLockGuard lock(m_parent.m_mutex);
        value = m_device->ReadValue();
    }
    catch(const TException& e)
    {
        LOG_ERROR(g_log_section, e.ToString());
        error = e.m_error;
    }
    catch(...)
    {
        LOG_ERROR(g_log_section, "unknown error");
        error = EC_UNKNOWN;
    }
    m_callback(m_device->Type(), value, error);
}

} // namespace Hal
