#ifndef FILE_HAL_DEV_DETAILS_DEVICE_H
#define FILE_HAL_DEV_DETAILS_DEVICE_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <endian.h>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------


namespace Hal
{
namespace Dev
{

/**
 * @brief A device base class.
 */
class TDevice
{
public:
    virtual ~TDevice() {}

    /**
     * @brief It configures the HW part of the device
     */
    inline void Configure() { OnConfigure(); }

private:
    virtual void OnConfigure() = 0;
}; // class TDevice

} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_DETAILS_DEVICE_H
