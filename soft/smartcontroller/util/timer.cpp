// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <cassert>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "util/timer.h"


namespace Util
{

//-----------------------------------------------------------------------------
TTimer::TTimer(const TCallback& callback)
    : m_callback(callback),
      m_id(0)
{
    assert(static_cast< bool >(callback));

    ::sigevent sev = {{0}};
	sev.sigev_notify = SIGEV_THREAD;
	sev.sigev_notify_function = Handler; //this function will be called when timer expires
	sev.sigev_value.sival_ptr = this;
	timer_create(CLOCK_MONOTONIC, &sev, &m_id);
}

//-----------------------------------------------------------------------------
TTimer::~TTimer() noexcept
{
    timer_delete(m_id);
}

//-----------------------------------------------------------------------------
void TTimer::Start(int timeMs) noexcept
{
    ::itimerspec value;
    
	value.it_value.tv_sec = timeMs/1000;
	value.it_value.tv_nsec = (timeMs%1000) * 1000000;
	value.it_interval.tv_sec = 0;
	value.it_interval.tv_nsec = 0;

    timer_settime(m_id, 0, &value, NULL);
}

//-----------------------------------------------------------------------------
void TTimer::StartRepeat(int hours, int mins, int seconds) noexcept
{
    ::itimerspec value;

    int timeSecs = hours * 3600 + mins * 60 + seconds;
    int timeMs = timeSecs * 1000;

	value.it_value.tv_sec = timeSecs;
	value.it_value.tv_nsec = (timeMs%1000) * 1000000;
    value.it_interval = value.it_value;

    timer_settime(m_id, 0, &value, NULL);
}

//-----------------------------------------------------------------------------
void TTimer::Stop() noexcept
{    
    ::itimerspec value = {{0}};
	timer_settime(m_id, 0, &value, NULL);
}

//-----------------------------------------------------------------------------
void TTimer::Handler(::sigval sigval) 
{
    TTimer *const tt = reinterpret_cast< TTimer* >(sigval.sival_ptr); 
    tt->m_callback();  
}

} // namespace Util