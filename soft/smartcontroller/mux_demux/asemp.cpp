// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <cstdint>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include <string>
#include "db/Commands.h"
#include "mux_demux/asemp.h"


namespace Asemp
{

using namespace ::std;

//-----------------------------------------------------------------------------
TInBuffer& operator>>(TInBuffer& buffer, ASEMPMessage& header)
{
    header.protocolID = buffer.PopAs< uint8_t >();
    header.msgCount = buffer.PopAs< uint8_t >();
    return buffer;
}

//-----------------------------------------------------------------------------
TOutBuffer& operator<<(TOutBuffer& buffer, const ASEMProfile& profile)
{
    buffer.PushAs< uint8_t >(profile.zone_occu);
    buffer.PushAs< uint8_t >(profile.occu_rep);
    buffer.PushAs< uint8_t >(profile.unoccu_rep);
    buffer.PushAs< uint8_t >(profile.occu_pir);
    buffer.PushAs< uint8_t >(profile.unoccu_pir);
    buffer.PushAs< uint8_t >(profile.max_retry);
    buffer.PushAs< uint8_t >(profile.max_wait);
    buffer.PushAs< uint8_t >(profile.min_rep_wait);
    buffer.PushAs< uint8_t >(profile.bat_stat_thr);
    //buffer.PushAs< uint8_t >(profile.mcu_sleep);
    buffer.PushAs< uint8_t >(profile.up_temp_tr);
    buffer.PushAs< uint8_t >(profile.lo_temp_tr);
    buffer.PushAs< uint8_t >(profile.up_hum_tr);
    buffer.PushAs< uint8_t >(profile.lo_hum_tr);
    buffer.PushAs< uint8_t >(profile.lux_sl_tr);
    buffer.PushAs< uint8_t >(profile.up_co_tr);
    buffer.PushAs< uint8_t >(profile.up_co2_tr);
    buffer.PushAs< uint8_t >(profile.aud_alarm);
    buffer.PushAs< uint8_t >(profile.led_alarm);
    buffer.PushAs< float >(profile.temp_sl_alarm);
    //buffer.PushAs< float >(profile.ac_curr_thr);

    return buffer;
}

//-----------------------------------------------------------------------------
TOutBuffer& operator<<(TOutBuffer& buffer, const CCommands& command)
{
/*
    switch(command.getType())
    {
    case CCommands::TType::LOUVER_POSITION_CHANGE:
    case CCommands::TType::DIMMER_CONTROL:
    case CCommands::TType::MODIFY_REPORT_INTERVAL:
    case CCommands::TType::RELAY_SET:
    case CCommands::TType::RELAY_RESET:
    case CCommands::TType::IR_TX_CMD:
        buffer.PushAs< uint8_t >(command.getParametersAs< int >());
        break;

    case CCommands::TType::AC_DEVICE_ENABLE:
    case CCommands::TType::AC_DEVICE_DISABLE:
    case CCommands::TType::TRANSMIT_UNSOLICITED_INFO:
    case CCommands::TType::LED_ALARM_ENABLE:
    case CCommands::TType::LED_ALARM_DISABLE:
    case CCommands::TType::AUDIBLE_ALARM_ENABLE:
    case CCommands::TType::AUDIBLE_ALARM_DISABLE:
        buffer.PushAs< uint8_t >(0);
        break;

    case CCommands::TType::PROFILE:
    case CCommands::TType::ACK:
        break;
    }

    return buffer;
*/
}

//-----------------------------------------------------------------------------
TOutBuffer& operator<<(TOutBuffer& buffer, const RegistrationResponse& res)
{
    // header
    buffer.PushAs< uint8_t >(res.ASEMPMobj.protocolID);
    buffer.PushAs< uint8_t >(res.ASEMPMobj.msgCount);
    // body
    buffer << res.ASEMProObj;

    return buffer;
}

//-----------------------------------------------------------------------------
TOutBuffer& operator<<(TOutBuffer& buffer, const UnsolicitedSensorInfoResponse& res)
{
    // header
    buffer.PushAs< uint8_t >(res.ASEMPMobj.protocolID);
    buffer.PushAs< uint8_t >(res.ASEMPMobj.msgCount);
    // body
    buffer.PushAs< uint8_t >(res.short_payload);
    buffer.PushAs< uint8_t >(res.zone_occupancy_state);
    buffer.PushAs< uint8_t >(res.command_type);

    return buffer;
}

//-----------------------------------------------------------------------------
TInBuffer& operator>>(TInBuffer& buffer, UnsolicitedSensorInfoRequest& req)
{
    // header
    req.ASEMPMobj.protocolID = buffer.PopAs< uint8_t >();
    req.ASEMPMobj.msgCount = buffer.PopAs< uint8_t >();
    // body
    req.pir = buffer.PopAs< uint8_t >();
    req.min_temp = buffer.PopAs< float >();
    req.avg_temp = buffer.PopAs< float >();
    req.max_temp = buffer.PopAs< float >();
    req.min_hum = buffer.PopAs< float >();
    req.avg_hum = buffer.PopAs< float >();
    req.max_hum = buffer.PopAs< float >();
    req.min_lux = buffer.PopAs< float >();
    req.max_lux = buffer.PopAs< float >();
    req.parent_lqi = buffer.PopAs< int32_t >();
    req.co2 = buffer.PopAs< float >();
    req.co = buffer.PopAs< float >();
    req.ac_current = buffer.PopAs< float >();
    req.louver_pos = buffer.PopAs< int32_t >();
    req.min_battery_status = buffer.PopAs< float >();
    req.cause = buffer.PopAs< uint8_t >();

    return buffer;
}

} // namespace Asemp
