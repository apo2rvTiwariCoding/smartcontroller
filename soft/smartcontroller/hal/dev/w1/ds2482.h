#ifndef FILE_HAL_DEV_W1_DS2482_H
#define FILE_HAL_DEV_W1_DS2482_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/bus.h"
#include "hal/dev/device.h"
#include "hal/dev/fwd.h"


namespace Hal
{
namespace Dev
{
namespace W1
{

/**
 * @brief I2C to 1-wire master IC (DS2482).
 * @note The timeouts values are according to the IC documentation.
 */
class TDs2482 : public TDevice
{
public:
    typedef ::std::shared_ptr< TDs2482 > TPtr;
    typedef Dev::TBus TI2cBus;

    /**
     * @throw TException
     */
    static TPtr Instance();

private:
    TDs2482();

    typedef ::std::weak_ptr< TDs2482 > TWPtr;
    static TWPtr s_instance;

public:
    virtual ~TDs2482() noexcept;

public:
    /// The device default address.
    static const int DEFAULT_ADDRESS = 0x18;

    /**
     * @brief It performs a global reset of device state machine logic.
     *        Terminates any ongoing 1-Wire communication.
     * @throw TException
     * @return The device status.
     */
    unsigned Reset();


    /// Configuration register bits
    enum TConfiguration
    {
        APU = 0x01,
        SPU = 0x04,
        OWS = 0x08 ///< 1-wire speed
    };

    /**
     * @brief It writes the current configuration from the device.
     * @throw TException
     */
    unsigned ReadConfiguration();

    /**
     * @brief It writes the given configuration to the device.
     * @throw TException
     */
    void WriteConfiguration(unsigned configuration);


    /// Status register bits
    enum TStatus
    {
        W1B = 0x01, ///< 1-wire busy
        PPD = 0x02,
        SD = 0x04,
        LL = 0x08,
        RST = 0x10,
        SBR = 0x20,
        TSB = 0x40,
        DIR = 0x80
    };

    /**
     * @brief It reads the device status.
     * @throw TException
     */
    unsigned ReadStatus();


    /**
     * @brief It writes a single data byte to the 1-Wire line.
     * @throw TException
     * @return The device status.
     */
    unsigned W1Reset();
   
    /**
     * @brief It genertes three time slot (search ROM sequence). A full search
     *        sequence requires this function to be called consecutively 64 times
     *        to identify one device.
     * @throw TException
     * @return The device status.
     */
    unsigned W1GenerateSearchRomSequence(bool direction);

    /**
     * @brief It writes a single data byte to the 1-Wire line.
     * @throw TException
     */
    void W1WriteByte(unsigned data);

    /**
     * @brief It writes the given data to the 1-Wire line.
     * @throw TException
     */
    void W1WriteData(const void* data, ::std::size_t size);

    /**
     * @brief It reads a single data byte from the 1-Wire line.
     * @throw TException
     */
    unsigned W1ReadByte();

    /**
     * @brief It reads a stream of data from the 1-Wire line.
     * @throw TException
     */
    void W1ReadData(void* data, ::std::size_t size);

private:
    const TI2cBus::TPtr m_bus;

    // Device registers (pointer codes)
    enum TRegister
    {
        STATUS = 0xF0,
        DATA = 0xE1,
        CONFIGURATION = 0xC3
    };

    /// @throw TException
    unsigned ReadRegister(TI2cBus::THandle& bus_handle, TRegister reg);

    /// Device commands
    enum TCommand
    {
        DEVICE_RESET = 0xF0,
        SET_READ_POINTER = 0xE1,
        WRITE_CONFIGURATION = 0xD2,
        W1_RESET = 0xB4,
        W1_SINGLE_BIT = 0x87,
        W1_WRITE_BYTE = 0xA5,
        W1_READ_BYTE = 0x96,
        W1_TRIPLET = 0x78
    };

    /// @throw TException
    unsigned ExecCommand(TI2cBus::THandle& bus_handle, TCommand command,
        int timeout);
    /// @throw TException
    unsigned ExecCommand(TI2cBus::THandle& bus_handle, TCommand command,
        unsigned arg, int timeout);

    /// It waits the command that has been just executed to complete.
    /// @param timeout Milliseconds
    /// @throw TException
    /// @return The status register.
    unsigned WaitCommandToComplete(TI2cBus::THandle& bus_handle, int timeout);

private: // TDevice
    virtual void OnConfigure();
}; // class TDs2482

} // namespace W1
} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_W1_DS2482_H
