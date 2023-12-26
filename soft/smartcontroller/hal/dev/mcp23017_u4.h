#ifndef FILE_HAL_DEV_MCP23017_U4_H
#define FILE_HAL_DEV_MCP23017_U4_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>
#include <poll.h>
#include <functional>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/device.h"
#include "hal/dev/mcp23017.h"
#include "hal/dev/details/gpio.h"


namespace Hal
{
namespace Dev
{

/**
 * @brief MPC23017 IC (U4, see the schematics).
 * 
 * It handles IO interrupts.
 */
class TMcp23017_U4 : public TDevice
{
public:
    typedef ::std::shared_ptr< TMcp23017_U4 > TPtr;
    typedef Details::TGpio TGpio;
    typedef TMcp23017::TPort TPort;


    /**
     * @throw ::std::system_error
     */
    static TPtr Instance();

private:
    TMcp23017_U4();

    typedef ::std::weak_ptr< TMcp23017_U4 > TWPtr;
    static TWPtr s_instance;

public:
    virtual ~TMcp23017_U4() noexcept;


public:
    /// The IC default address.
    static const int DEFAULT_ADDRESS = 0x21;

    /**
     * @brief It waits for an interrupt.
     * @throw TException
     */
    bool WaitForInterrupt(int timeout);


public:
    /**
     * @brief It reads interrupts statuses captured at the time of the
     *        last interrupt.
     * @note The interrupt gets acknowledged by this call as well.
     * @throw TException
     */
    unsigned ReadCapturedInterrupts();

    /**
     * @brief It reads interrupts statuses.
     * @throw TException
     */
    unsigned ReadInterrupts();

private:
    /// Some of the bits need to be negated and filtered out.
    static unsigned PreProcessInterruptStatuses(unsigned statuses);


public:
    /**
     * @brief It reads CO state.
     * @throw TException
     */
    bool ReadCoState();

private:
    const TMcp23017::TPtr m_mcp23017;

    const ::std::array< TGpio::TUPtr, TMcp23017::PORTS_COUNT > m_gpios;
    ::std::array< ::pollfd, TMcp23017::PORTS_COUNT > m_fds;

private: // TDevice
    virtual void OnConfigure();
}; // class TMcp23017_U4

} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_MCP23017_U4_H
