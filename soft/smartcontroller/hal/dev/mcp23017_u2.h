#ifndef FILE_HAL_DEV_MCP23017_U2_H
#define FILE_HAL_DEV_MCP23017_U2_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>
#include <cassert>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/device.h"
#include "hal/dev/mcp23017.h"
#include "hal/dev/keys.h"
#include "hal/hal.h"


namespace Hal
{
namespace Dev
{

/**
 * @brief MPC23017 IC (U2, see the schematics).
 * 
 * It drives relays, LEDs, etc.
 */
class TMcp23017_U2 : public TDevice
{
public:
    typedef ::std::shared_ptr< TMcp23017_U2 > TPtr;
    typedef TMcp23017::TPort TPort;
    typedef TMcp23017::TPin TPin;

    /**
     * @throw TException
     */
    static TPtr Instance();

private:
    TMcp23017_U2();

    typedef ::std::weak_ptr< TMcp23017_U2 > TWPtr;
    static TWPtr s_instance;

public:
    virtual ~TMcp23017_U2() noexcept;


public:
    /// The IC default address.
    static const int DEFAULT_ADDRESS = 0x20;

private:
    const TMcp23017::TPtr m_mcp23017;

    struct TMax4821;
    const ::std::unique_ptr< TMax4821 > m_u1;
    const ::std::unique_ptr< TMax4821 > m_u3;
    const ::std::unique_ptr< TMax4821 > m_u5;

private: // TDevice
    virtual void OnConfigure();


public: // Relays
    /**
     * @brief It switches the specific relay on/off.
     * @throw TException
     */
    void Relay(TRelayId id, bool on);

    /**
     * @brief It switches off all the relays. This is much faster than 
     *        switching them individually.
     * @throw TException
     */
    void RelaysReset();


public: // LEDs
    /**
     * @brief It turns the specific LED on/off.
     * @throw TException
     */
    void Led(TLedId id, bool on);


public: // ADC
    /**
     * @brief It starts/stops ADC conversion
     * @throw TException
     */
    void AdcConv(const TAd7993Key&, bool on);


public: // Audio
    /**
     * @brief It shout down the audio.
     * @throw TException
     */
    void AudioShdn(bool on);
}; // class TMcp23017_U2

} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_MCP23017_U2_H
