#ifndef _ZIGBEE_DEVICES_H
#define _ZIGBEE_DEVICES_H

class CZigbeeDevice
{
public:
	CZigbeeDevice();
	~CZigbeeDevice();
	
  
public:
	static int retrieve(int deviceId, CZigbeeDevice zigbeeDevice);
	static int retrieveAddr64(int deviceId, CZigbeeDevice zigbeeDevice);

	int getZoneId(){return mZoneId;}
	int getDeviceType(){return mDeviceType;}
	std::string getXbeeAddr64(){return mXbeeAddr64.c_str();}
	int getASEMP(){return mASEMP;}

private:
	int mId;
	int mZoneId;
	int mHardwareType;
	int mDeviceType;
	std::string mDescription;
	std::string mXbeeAddr64;
  	int mASEMP; 
	std::string mSerial;
};

#endif