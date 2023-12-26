ZED Simulator :

Zed simulator is a replica of zed hardware which is to be used in Retrosave project. Any extreme condition can be checked using this Simulator which original hardware cannot provide so frequently.

How To Make Simulator exe .

	Goto base directory - smartcontroller

	enter into simulator

	do :

	$make

	this make shal make simulator lib and exe in simulator/test/obj dir

	Executable name : testsimulatorz

How to run Simulator

	goto simulator/test/obj

	place configurations file there : for example i have copied config directory to the path where executable is kept
				
						CSimulator Config  File - Provides the basic info of the devive which is making registration request to Server
						EX :
						[Register]
						deviceType = 18
						zigbeeHardwareVersion = 1
						zigbeeFirmwareVersion = 6
						ASEFirmwareVersion = 3
						ASEHardwareVersion = 4
						Remote_RSSI = 5

						DeviceType Defines what type of device it is : eg louver ,outdoor sensor etc

						Unsoli Config File : unsolicited information is the dummy information provided by the simulator to server so that server shall detect what values are send by the remote device(simulator)
						Ex :
						[unsolicited]
						deviceType = 17
						pir = 1
						cause = 4
						min_temp = 2
						avg_temp = 3
						max_temp = 4
						min_hum = 5
						avg_hum = 6
						max_hum = 7
						min_lux = 8
						max_lux = 9
						battery = 10
						Remote_RSSI = 11
						ac_current = 12
						coMax = 16
						coAvg = 15
						coMin = 14
						co2Max = 19
						co2Avg = 18
						co2Min = 17
						remoteAck = 1

now run :
./testsimulatorz ./config/CSimulator./config/UnSoli.ini 

--------------------------------------------------------------------------------------------------------------------------------------------

For running the simulator - we have a push button :
	
	Which sends "1" as an input a to send  registration request to the server

		NOTE: When a registration request is already sent from simulator to server another same request can not be initiated.

			  New registration Request can only be sent only and only when simulator is disabled from server or by own side .

	Send "2" to the running simulator, it will bydefault send a shutdown signal to the simulator and connection between server and simulator will break

After sending Registration Request Simulator waits for registration response from "web"(accepts/rejects the registration) - muxdemux-server to simulator

On receiving Registration Response - Unsolicited Request is called periodically based on received variable - min_rep_wait in ASEMPMessage 

	-- NOTE : ZED can be enabled / Disabled through Webui now

RemoteDeviceStatus request send from Muxdemux server to simulator to ENABLE/DISABLE the device.

	--in ENABLE MODE - Simulator will respond back to all the requests 

	--in DISABLE MODE - Simulator will not respond untill an device enable request is received .

Simulator responds back to Central command request , Update profile Request & Remote_Ping_request .

To disable the device from ZED side press 2 and then enter .

Device can be unregisterd from Webui side also , by calling unregister remote device Command code. 