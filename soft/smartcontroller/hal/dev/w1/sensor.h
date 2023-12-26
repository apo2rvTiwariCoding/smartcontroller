#ifndef FILE_HAL_DEV_W1_SENSOR_H
#define FILE_HAL_DEV_W1_SENSOR_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/device.h"
#include "hal/hal.h"
#include "hal/dev/fwd.h"


namespace Hal
{
namespace Dev
{
namespace W1
{

/**
 * @brief A 1-Wire sensor device base class.
 */
class TSensor : public TDevice
{
public:
    typedef ::std::unique_ptr< TSensor > TUPtr;

protected:
    TSensor(TBus& bus, const TW1DeviceInfo& info)
        : m_bus(bus),
          m_info(info)
      {}

public:
    inline const TW1DeviceInfo& Info() const noexcept { return m_info; }

    /**
     * @throw TException
     */
    inline float ReadValue() { return OnReadValue(); }

protected:
    TBus& m_bus;
    const TW1DeviceInfo m_info;

private:    
    virtual float OnReadValue() = 0;
}; // class TSensor

} // namespace W1
} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_W1_SENSOR_H
