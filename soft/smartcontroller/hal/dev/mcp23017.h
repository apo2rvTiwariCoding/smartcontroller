#ifndef FILE_HAL_DEV_MCP23017_H
#define FILE_HAL_DEV_MCP23017_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <array>
#include <memory>
#include <cassert>
#include <cstdint>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/bus.h"
#include "hal/dev/device.h"


namespace Hal
{
namespace Dev
{

/**
 * @brief MPC23017 IC base class.
 */
class TMcp23017 : public TDevice
{
public:
    typedef ::std::shared_ptr< TMcp23017 > TPtr;

    /// @throw TException
    TMcp23017(unsigned address);
    virtual ~TMcp23017();


private:
    const TBus::TPtr m_bus;
    const unsigned m_address;

    /// The registers identifiers
    enum TRegister
    {
        IODIRA = 0x00,
        IODIRB = 0x01,
        IPOLA = 0x02,
        IPOLB = 0x03,
        GPINTENA = 0x04,
        GPINTENB = 0x05,
        DEFVALA = 0x06,
        DEFVALB = 0x07,
        INTCONA = 0x08,
        INTCONB = 0x09,
        IOCONA = 0x0A,
        IOCONB = 0x0B,
        GPPUA = 0x0C,
        GPPUB = 0x0D,
        INTFA = 0x0E,
        INTFB = 0x0F,
        INTCAPA = 0x10,
        INTCAPB = 0x11,
        GPIOA = 0x12,
        GPIOB = 0x13,
        OLATA = 0x14,
        OLATB = 0x15,

        INVALID = -1
    };

    /// @throw TException
    unsigned ReadRegister(TRegister reg);
    /// @throw TException
    void WriteRegister(TRegister reg, unsigned value);


public:
    /// The ports
    enum TPort
    {
        A,
        B
    };
    static const unsigned PORTS_COUNT = static_cast< unsigned >(TPort::B) + 1;
    static const unsigned PINS_PER_PORT_COUNT = 8;

    /// It designates a specific output pin
    struct TPin
    {
        TPin(TPort port, unsigned num)
            : m_port(port),
              m_mask(1 << num)
          {
              assert(num < PINS_PER_PORT_COUNT);
          }

        TPort m_port;
        unsigned m_mask;
    };


    /**
     * @throw TException
     */
    void SetInterruptOnChange(TPort port, unsigned mask);

    /**
     * @throw TException
     */
    unsigned ReadInterruptFlags(TPort port);

    /**
     * @throw TException
     */
    unsigned ReadInterruptCapturedValue(TPort port);


    /**
     * @throw TException
     */
    void SetDirection(TPort port, unsigned outputs_mask, unsigned inputs_mask);

    /**
     * @throw TException
     */
    unsigned ReadInputs(TPort port);

    /**
     * @note The method returns the cached output state.
     */
    inline unsigned GetOutputs(TPort port) const
      {
          assert(port < PORTS_COUNT);
          return m_outputs_cache[port];
      }

    /**
     * @throw TException
     */
    unsigned ReadOutputs(TPort port);

    /**
     * @throw TException
     */
    void WriteOutputs(TPort port, unsigned mask);

    /**
     * @throw TException
     * @note The order of applying masks is clear and set.
     */
    void WriteOutputs(TPort port, unsigned clear_mask, unsigned set_mask);

private:
    ::std::array< ::std::uint8_t, PORTS_COUNT > m_outputs_cache;

private: // TDevice
    virtual void OnConfigure();
}; // class TMcp23017

} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_MCP23017_H
