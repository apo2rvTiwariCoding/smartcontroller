#ifndef FILE_HAL_DEV_AD7993_H
#define FILE_HAL_DEV_AD7993_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/bus.h"
#include "hal/dev/device.h"
#include "hal/dev/fwd.h"
#include "hal/hal.h"


namespace Hal
{
namespace Dev
{

/**
 * @brief 10-bit ADC IC (AD7993).
 */
class TAd7993 : public TDevice
{
public:
    typedef ::std::shared_ptr< TAd7993 > TPtr;

    /**
     * @throw TException
     */
    static TPtr Instance();

private:
    TAd7993();

    typedef ::std::weak_ptr< TAd7993 > TWPtr;
    static TWPtr s_instance;

public:
    virtual ~TAd7993() noexcept;


public:
    /// The IC default address.
    static const int DEFAULT_ADDRESS = 0x22;

    /// Inputs
    enum TInputId
    {
        VIN1,
        VIN2,
        VIN3,
        VIN4
    };
    static const unsigned INPUTS_COUNT = VIN4 + 1;
    static_assert(ADC_CHANNELS_COUNT == INPUTS_COUNT, "mismatch");

    /**
     * @brief It sets the low limit on the requested input.
     */
    void WriteLowLimit(TInputId input_id, unsigned threshold);

    /**
     * @brief It sets the high limit on the requested input.
     */
    void WriteHighLimit(TInputId input_id, unsigned threshold);


    static const unsigned RESOLUTION = 10; // bits
    static const float REFERENCE;
    static const float QUANT;
    static const unsigned RANGE = (1 << RESOLUTION);   

    /**
     * @brief It performs analog to digital converions on the requested input.
     */
    unsigned Convert(TInputId input_id);


    /**
     * @brief It reads particular input limit violations that are being
     *        active.
     */
    void ReadAlerts(TInputId input_id, bool& low, bool& high);

    /**
     * @brief It clears the alert status on all the inputs.
     */
    void ClearAlert();

private:
    const TBus::TPtr m_bus;
    const ::std::shared_ptr< TMcp23017_U2 > m_u2;

    /// Registers
    enum TRegister
    {
        CONVERSION_RESULT = 0,
        ALERT_STATUS,
        CONFIGURATION,
        CYCLE_TIMER,
        DATA_LOW_CH1,
        DATA_HIGH_CH1,
        HYSTERESIS_CH1,
        DATA_LOW_CH2,
        DATA_HIGH_CH2,
        HYSTERESIS_CH2,
        DATA_LOW_CH3,
        DATA_HIGH_CH3,
        HYSTERESIS_CH3,
        DATA_LOW_CH4,
        DATA_HIGH_CH4,
        HYSTERESIS_CH4
    };

    void WriteRegister8(TBus::THandle& bus_handle, TRegister reg, unsigned value);
    unsigned ReadRegister8(TBus::THandle& bus_handle, TRegister reg);
    void WriteRegister16(TBus::THandle& bus_handle, TRegister reg, unsigned value);


    /// The configuration register bits
    enum TConfigurationRegister
    {
        POLARITY = 0x01,
        BUSY = 0x02,
        ALERT_EN = 0x04,
        FLTR = 0x08,
        CH1 = 0x10,
        CH2 = 0x20,
        CH3 = 0x40,
        CH4 = 0x80,

        CH_MASK = CH1 | CH2 | CH3 | CH4
    };

    static const unsigned DEFAULT_CONFIGURATION_REG;
    unsigned m_configuration_reg;

    void SelectChannel(TBus::THandle& bus_handle, TInputId input_id);
    void TriggerConversion();
    unsigned ReadConversionResult(TBus::THandle& bus_handle,
            TInputId& input_id, bool& alert);

    void StartPeriodicSampling(TBus::THandle& bus_handle);
    void StopPeriodicSampling(TBus::THandle& bus_handle);

private: // TDevice
    virtual void OnConfigure();
}; // class TAd7993

} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_AD7993_H
