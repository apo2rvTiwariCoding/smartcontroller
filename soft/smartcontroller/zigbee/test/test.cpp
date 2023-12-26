// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <map>
#include <mutex>
#include <thread>
#include <chrono>
#include <cassert>
#include <iostream>
#include <condition_variable>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "mux_demux/zigbee.h"
#include "util/log/log.h"
#include "zigbee/zigbee_sync.h"

//-----------------------------------------------------------------------------
int main(int argc, char* argv[])
{
    ZigbeeSyncInitialize(0, 0, 0);

    unsigned channels = 0x00000800; // 11
    //unsigned channels = 0x00618800;
    //unsigned channels = 0x01000000; // 24
    unsigned pan_id = 0xFEED;
    TGwDeviceInfo device_info;
    ZigbeeSyncCreateNetwork(channels, pan_id, device_info);


    TZigbeeDevices devices;
    ZigbeeSyncGetDevicesList(devices);
    for(const device_info_t& device : devices)
    {
        ::std::cout << device.ieee_addr << '\n';
    }
    sleep(1);
    {
        ZigbeeSyncSendOnOffReq(0x000B52000000595E, true);
        {
            bool on = false;
            ZigbeeSyncReadOnOffAttrib(0x000B52000000595E, on);
            assert(true == on);
        }
        ::std::this_thread::sleep_for(::std::chrono::seconds(1));

        {
            unsigned value;
            ZigbeeSyncReadSmartMeter(0x000B52000000595E, value);
            ::std::cout << "Meter status: " << value << '\n';
        }

        ZigbeeSyncSendOnOffReq(0x000B52000000595E, false);
        {
            bool on = true;
            ZigbeeSyncReadOnOffAttrib(0x000B52000000595E, on);
            assert(false == on);
        }
    }
    return 0;

    for(int i = 0; /*i < 2*/; i++)
    {
        ZigbeeSyncSendOnOffReq(0x000B520000005EC9, i % 2);
        ::std::this_thread::sleep_for(::std::chrono::seconds(10));
    }


    for(;;) ::sleep(1);
    return 0;
}
