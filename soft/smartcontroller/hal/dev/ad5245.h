#ifndef FILE_HAL_DEV_AD5245_H
#define FILE_HAL_DEV_AD5245_H

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

/**
 * @brief Digital potentiometer IC (AD5245).
 */
class TAd5245 : public TDevice
{
public:
    typedef ::std::shared_ptr< TAd5245 > TPtr;

    /**
     * @throw TException
     */
    static TPtr Instance();

private:
    TAd5245();

    typedef ::std::weak_ptr< TAd5245 > TWPtr;
    static TWPtr s_instance;

public:
    virtual ~TAd5245() noexcept;


public:
    /// The IC default address.
    static const int DEFAULT_ADDRESS = 0x2C;


    static const unsigned RANGE = 256;

    /**
     * @brief It sets the wiper position.
     * @throw TException
     * @param pos
     * Valid range is 0 - 255
     */
    void Position(unsigned pos);

private:
    const TBus::TPtr m_bus;

private: // TDevice
    virtual void OnConfigure();
}; // class TAd5245

} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_AD5245_H
