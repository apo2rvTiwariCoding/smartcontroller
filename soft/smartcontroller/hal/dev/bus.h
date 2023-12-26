#ifndef FILE_HAL_DEV_BUS_H
#define FILE_HAL_DEV_BUS_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>
#include <cassert>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------


namespace Hal
{
namespace Dev
{

/**
 * @brief I2C kernel device wrapper.
 */
class TBus
{
public:
    typedef ::std::shared_ptr< TBus > TPtr;

    /**
     * @throw TException
     */
    static TPtr Instance();

private:
    TBus();

    typedef ::std::weak_ptr< TBus > TWPtr;
    static TWPtr s_instance;

public:
    virtual ~TBus() noexcept;


    /// Number of times a device address should be polled when not acknowledging
    static const int RETRIES_COUNT = 3;
    /// Timeout in ms
    static const int DEFAULT_TIMEOUT = 100;

    inline bool IsOpen() const noexcept { return INVALID_FD != m_fd; }
    inline bool IsBusy() const noexcept { return m_busy; }


    /// It automatically relinquishes the control.
    class THandle
    {
    public:
        THandle(const THandle& ) = delete;
        THandle(THandle&& handle) noexcept;
        ~THandle() noexcept;

        inline int Get() const noexcept { return m_bus->m_fd; }
        /// @throw TException
        inline void WriteRead(const void* tx, ::std::size_t tx_len,
            void* rx, ::std::size_t rx_len)
          {
              m_bus->WriteRead(tx, tx_len, rx, rx_len);
          }

    private:
        friend class TBus;
        THandle(TBus *const bus) : m_bus(bus) { assert(m_bus); }
        TBus* m_bus;
    }; // class THandle

    /**
     * @brief It takes the control over the bus.
     * @throw TException
     */
    THandle TakeControl(int device_address);

private:
    static const int INVALID_FD = -1;
    int m_fd;
    void Close() noexcept;

    static const int INVALID_ADDRESS = -1;
    int m_address; ///< Current device address

    bool m_busy;
    inline void ReleaseControl() noexcept { m_busy = false; }

    /// It writes and reads a stream of bytes.
    void WriteRead(const void* tx, ::std::size_t tx_len,
        void* rx, ::std::size_t rx_len);
}; // class TBus

} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_BUS_H
