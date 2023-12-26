// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <cassert>
#include <iostream>
#include <future>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "mux_demux/zigbee_cb.h"
#include "mux_demux/zigbee.h"
#include "mux_demux/asemp.h"
#include "zigbee/zigbee_sync.h"
#include "zigbee/zigbee.h"
#include "util/log/log.h"
#include "util/comm/buffer.h"
#include "db/Commands.h"


//=============================================================================
// Private functions
//=============================================================================


using Asemp::operator >>;
using Asemp::operator <<;

#undef TESTING

#ifdef TESTING
//-----------------------------------------------------------------------------
static void SendDummyResponse(unsigned long long address)
{
    ::std::cout << "********** sending\n";
    ::sleep(1);
    ::std::cout << "********** sending2\n";
    char message[38];
    message[0] = 'R';
    message[37] = 'A';
    SendGenRespPkt(address, sizeof(message), message);
}
#endif

//-----------------------------------------------------------------------------
static void AddAseDevice(const device_info_t& device_info)
{
    TZigbeeAttributes attributes;
    if (ZigbeeSyncReadBasicCluster(device_info.ieee_addr, attributes))
    {
        LOG_WARN_FMT("server", "Failed to obtain device "
                "(ieee address = %llX) information.", device_info.ieee_addr);
    }
    else
    {
        // TODO: parse attributes
    }

#if 0
    ZigbeeAddAseDevice(device_info);
#else
    int profile_id = 0; // TODO: get it from basic cluster

    if (ZigbeeAddAseDevice(device_info))
    {
        LOG_ERROR_FMT("server", "Failed to register the device "
                "(ieee address = %llX).", device_info.ieee_addr);
        return;
    }

    RegistrationResponse res;
    res.ASEMPMobj.protocolID = REGISTRATION_RESPONSE_ID;
    if (ZigbeeGetRegistrationResponse(profile_id, res.ASEMProObj))
    {
        LOG_ERROR_FMT("server", "Failed to obtain the device "
                "(ieee address = %llX) profile.", device_info.ieee_addr);
        return;
    }


    Asemp::TOutBuffer buffer;
    buffer << res;
    if (buffer.Overflow())
    {
        LOG_ERROR_FMT("server", "Failed to serialize registration response "
                "(ieee address = %llX).", device_info.ieee_addr);
        return;
    }

    if (ZigbeeSyncSendGenericResp(device_info.ieee_addr, buffer.Index(),
            buffer.Data()))
    {
        LOG_ERROR_FMT("server", "Failed to send registration response "
                "(ieee address = %llX).", device_info.ieee_addr);
    }
#endif
}

//-----------------------------------------------------------------------------
static void OnAddDevice(const device_info_t& device_info)
{
    // Supported manufacturers
    static const unsigned ASE_MANUFACTURE_ID = 0xFFED;
    static const unsigned SMARTENIT_MANUFACTURE_ID = 0x1075;
    static const unsigned TI_MANUFACTURE_ID = 0x0007;


    if (0 == device_info.num_endpoints)
    {
        LOG_ERROR_FMT("server", "The device (ieee address = %llX, "
                "manufacturer id = %u) has to have at least one endpoint.",
                device_info.ieee_addr, device_info.manufacturer_id);
        return;
    }

    const endpoint_info_t& endpoint = device_info.ep_list[0];

    if (ASE_MANUFACTURE_ID == device_info.manufacturer_id &&
        0x0104 == endpoint.profile_id &&
        0xC001 == endpoint.device_id)
    {
        // ASE device

        AddAseDevice(device_info);
    }
    else if (SMARTENIT_MANUFACTURE_ID == device_info.manufacturer_id &&
        0x0104 == endpoint.profile_id &&
        0x0009 == endpoint.device_id)
    {
        // ZBMPlug15 (Model #5010Q) Metering Smart Plug from SmartenIt

        ZigbeeAddHaDevice(device_info);
    }
    else if (TI_MANUFACTURE_ID == device_info.manufacturer_id &&
             0x0104 == endpoint.profile_id &&
             0x0007 == endpoint.device_id)
    {
        // TI USB dongle
    }
#if 1 // testing
    else if (0 == device_info.manufacturer_id &&
             0x0104 == endpoint.profile_id &&
             0x0100 == endpoint.device_id)
    {
        // Evolution board - light switch test
#ifdef TESTING
        ::std::future< void > future = ::std::async(::std::launch::async,
                SendDummyResponse, device_info.ieee_addr);
#endif
    }
#endif
    else
    {
        LOG_WARN_FMT("server", "Unsupported zigbee device "
                "(ieee address = %llX, manufacturer id = %u). "
                "It will be removed.", device_info.ieee_addr,
                device_info.manufacturer_id);

        ZigbeeSyncRemoveDevice(device_info.ieee_addr);
    }
}

//-----------------------------------------------------------------------------
static void SendUnsolicitedSensorResponse(unsigned long long ieee_address,
        int device_id)
{
    ASEMProfile profile;
    ZigbeeGetProfile(device_id, profile);


    UnsolicitedSensorInfoResponse res;
    res.ASEMPMobj.protocolID = UNSOLICITED_SENSOR_INFO_RESPONSE_ID;
    res.short_payload = 1;
    res.zone_occupancy_state = profile.zone_occu;

    Asemp::TOutBuffer buffer;
    CCommands cmd;
    if (ZigbeeGetPendingCommand(device_id, cmd))
    {
        // Serialize the first part of the command
        res.command_type = cmd.getType();
        buffer << res;

        // Serialize the second part of the command
        if (CCommands::TType::PROFILE == res.command_type)
        {
            buffer << profile;
        }
        else
        {
            buffer << cmd;
        }
    }
    else
    {
        // No pending command for this device.

        res.command_type = CCommands::TType::ACK;
        buffer << res;
    }

    if (buffer.Overflow())
    {
        LOG_ERROR_FMT("server", "Failed to serialize unsolicited response "
                "(ieee address = %llX).", ieee_address);
        ZigbeeConfirmPendingCommand(device_id, true, 0);
        return;
    }

    if (ZigbeeSyncSendGenericResp(ieee_address, buffer.Index(), buffer.Data()))
    {
        LOG_ERROR_FMT("server", "Failed to send unsolicited response "
                "(ieee address = %llX).", ieee_address);
        ZigbeeConfirmPendingCommand(device_id, true, 0);
        return;
    }

    // TODO: check if response acknowledge is received.

    // No error
    ZigbeeConfirmPendingCommand(device_id, false, 0);
}

//-----------------------------------------------------------------------------
static void OnUnsolicitedSensorInfoRequest(unsigned long long ieee_addr,
        const ASEMPMessage& header, Asemp::TInBuffer& buffer)
{
    buffer.Reset();
    UnsolicitedSensorInfoRequest req;
    buffer >> req;
    if (buffer.Overflow())
    {
        LOG_ERROR_FMT("server", "Failed to deserialize request "
                "(id = %u) from the device (ieee address = %llX).",
                header.protocolID, ieee_addr);
        return;
    }

    int device_id;
    if (ZigbeeIeeeAddressToDeviceId(ieee_addr, device_id))
    {
        LOG_ERROR_FMT("server", "Failed to obtain device (ieee address = %llX) "
                "id.", ieee_addr);
        return;
    }

    ZigbeeStoreUnsolicitedInfo(device_id, req);


    SendUnsolicitedSensorResponse(ieee_addr, device_id);
}


//=============================================================================
// Public functions
//=============================================================================


//-----------------------------------------------------------------------------
void OnJoinLeaveDeviceInd(const device_info_t* device_info)
{
    assert(device_info);

    switch(device_info->device_status)
    {
    case 0: // device off line (non responding to service discovery)
        LOG_DEBUG_FMT("server", "Zigbee device (ieee address = %llX) "
                "is off line.", device_info->ieee_addr);
        break;

    case 1: // device on-line
        LOG_INFO_FMT("server", "Zigbee device (ieee address = %llX) "
                "has joined the network.", device_info->ieee_addr);

        OnAddDevice(*device_info);
        break;

    case 2: // device removed
        LOG_INFO_FMT("server", "Zigbee device (ieee address = %llX) "
                "has left the network.", device_info->ieee_addr);
        break;

    case 255: // not applicable (this value is returned when the gateway
              // application request information about the local gateway
              // device)
        LOG_DEBUG_FMT("server", "Local GW (ieee address = %llX) "
                "information provided.", device_info->ieee_addr);
        break;
    } // switch
}

//-----------------------------------------------------------------------------
void OnDisallowJoin()
{
    // TODO:
}

//-----------------------------------------------------------------------------
int OnAseDataReceived(unsigned short nwk_addr,
        unsigned short end_point, unsigned short device_id,
        unsigned short cluster_id, unsigned char is_req_flag,
        const char *message, unsigned char message_len,
        unsigned long long ieee_addr)
{
    Asemp::TInBuffer buffer(message, message_len);

    if (SEND_GEN_REQ_PKT == is_req_flag)
    {
        ASEMPMessage header;
        buffer >> header;
        if (buffer.Overflow())
        {
            LOG_ERROR_FMT("server", "Failed to deserialize request header from "
                    "the device (ieee address = %llX).", ieee_addr);
            return -1;
        }

        switch(header.protocolID)
        {
        case UNSOLICITED_SENSOR_INFO_REQUEST_ID:
            OnUnsolicitedSensorInfoRequest(ieee_addr, header, buffer);
            break;

        default:
            LOG_WARN_FMT("server", "Unhandled request (id = %u) from the device "
                    "(ieee address = %llX).", header.protocolID, ieee_addr);
            break;
        }
    }
    else if (SEND_GEN_RESP_PKT == is_req_flag)
    {
        // TODO:
    }

    return 0; // all good
}
