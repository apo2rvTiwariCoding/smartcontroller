#ifndef FILE_MUX_DEMUX_ASEMP_H
#define FILE_MUX_DEMUX_ASEMP_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "inc/ASEMPImpl.h"
#include "util/comm/buffer.h"

class TCommand;

namespace Asemp
{

/// Messages common buffer.
typedef ::Util::Comm::TBuffer< ASEMP_MAX_LENGTH > TOutBuffer;
typedef ::Util::Comm::TConstCBuffer TInBuffer;


/**
 * @brief It deserializes data into the given object.
 */
TInBuffer& operator>>(TInBuffer& buffer, ASEMPMessage& header);

/**
 * @brief It serializes the given object.
 */
TOutBuffer& operator<<(TOutBuffer& buffer, const ASEMProfile& profile);

/**
 * @brief It serializes the given object.
 */
TOutBuffer& operator<<(TOutBuffer& buffer, const CCommands& command);

/**
 * @brief It serializes the given object.
 */
TOutBuffer& operator<<(TOutBuffer& buffer, const RegistrationResponse& res);

/**
 * @brief It serializes the given object.
 */
TOutBuffer& operator<<(TOutBuffer& buffer,
        const UnsolicitedSensorInfoResponse& res);

/**
 * @brief It deserializes data into the given object.
 */
TInBuffer& operator>>(TInBuffer& buffer, UnsolicitedSensorInfoRequest& req);

} // namespace Asemp

#endif // #ifndef FILE_MUX_DEMUX_ASEMP_H
