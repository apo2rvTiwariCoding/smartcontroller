#ifndef _DEVICE_REGISTRATION_H
#define _DEVICE_REGISTRATION_H

class CDeviceRegistration
{
public:
	static CDeviceRegistration* getInstance();
	CDeviceRegistration();
	~CDeviceRegistration();
	
  
public:
	static int insertAddr(int eventType, int deviceType, int zigbee_hw, int zigbee_fw, int device_hw, int device_fw, int rssi, int status, std::string srcAddr);
	static int insert(int eventType, int deviceType, int zigbee_hw, int zigbee_fw, int rssi, int status);

	static int retrieve(int registrationId, CDeviceRegistration& registration);
	static int retrieveStatus(std::string deviceAddr, CDeviceRegistration& registration);

	int getZigbeeShort(){return mZigbeeShort;}
	int getStatus(){return mStatus;}
	int getType(){return mDeviceType;}
	std::string getZigbeeAddr64(){return mZigbeeAddr64.c_str();}

private:
	static CDeviceRegistration* mInstance;

	int mId;
	std::string mUpdated;
	int mEventType;
	int mDeviceType;
  	int mZigbeeShort; 
	std::string mZigbeeAddr64;
	int mZigbeeMode;
	int mPanId;
	int mChannel;
	int mRSSI;
	int mDeviceId;
	std::string mDeviceDesc;
	int mZoneId;
	std::string mZoneDesc;
	int mSource;
	int mZigbeeHW;
	int mZigbeeFW;
	int mDeviceHW;
	int mDeviceFW;
	int mStatus;
  	int mASEMPId; 
	std::string mSerial;
};
#endif
