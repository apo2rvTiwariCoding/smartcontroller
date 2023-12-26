STEPS TO MAKE:

1.	Goto project directory (smartcontroller) -> execute "make HOST=linux"


STEPS TO INSTALL UDF:

1.	Goto smartcontroller/upgrade directory -> execute ./installmysqludf ARG1 ARG2 ARG3

	ARG1 = user (root)
	
	ARG2 = password (0hASE)

	ARG3 = db name (smart2014)


STEPS TO INSTALL LOG LIB:

1.	Goto smartcontroller/upgrade directory -> execute sudo ./setuplog


STEPS TO UPDATE WEBUI:

1.	Goto smartcontroller/upgrade directory -> execute ./updatewebui 

	(The latest webui files MUST be present in ../../webui/ directory)


STEPS TO EXECUTE (UDF-MUXDEMUX-SIMULATOR):
	
    Terminal 1 : goto (smartcontroller/mux_demux/test/obj) dir, --run = ./test ARG1 ARG2 ARG3

    	ARG 1: MYSQL Username 

	ARG 2: MYSQL Password 
	
	ARG 3: Database Name


    Terminal 2: goto simulator/test/obj

    run = ./testsimulatorz ../config/CSimulator ../config/UnSoli.ini 
	
	ARG1 = Path of device ini file 

	ARG2 = Path of Unsolicited ini file


NOTE 1: You MUST restart mysql before starting server for the second or consecutive time. This bug will be resolved soon.


WORKING FOR SIMULATOR (ZED):

1.Run : ./testsimulatorz ../config/CSimulator ../config/UnSoli.ini

        CSimulator.ini - provides device type and other H/W F/W details

        UnSoli.ini - provides sensor data details (currently all fields in same file)

2.Press 1 -> then enter . to send registration request from simulator side .

3.waits from registration response from "web"(accepts/rejects the registration) to muxdemux-server to simulator

4.On receiving Registration Response - Unsolicited Request is called periodically based on received variable - min_rep_wait in ASEMPMessage

-- NOTE : ZED can be enabled / Disabled through Webui now

5.RemoteDeviceStatus request send from Muxdemux server to simulator to ENABLE/DISABLE the device.

--in ENABLE MODE - Simulator will respond back to all the requests

--in DISABLE MODE - Simulator will not respond untill an device enable request is received .

6.Simulator responds back to Central command request , Update profile Request & Remote_Ping_request .

7.To disable the device from ZED side press 2 and then enter .

-- NOTE : currently ZED will accept inputs 1 and 2 alternatively .

    Device can be unregisterd from Webui side also , by calling unregister remote device Command code.

		
	

