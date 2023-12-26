#ifndef FILE_HAL_DEV_KEYS_H
#define FILE_HAL_DEV_KEYS_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/fwd.h"


namespace Hal
{
namespace Dev
{

namespace W1
{

/// Access key
struct TSensorKey
{
private:
    TSensorKey() = default;
    friend class TBus;
};

} // namespace W1


namespace I2cExt
{

/// Access key
struct TSensorKey
{
private:
    TSensorKey() = default;
    friend class TBus;
};

} // namespace I2cExt


/// Access key
struct TAd7993Key
{
private:
    TAd7993Key() = default;
    friend class TAd7993;
};

} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_KEYS_H
