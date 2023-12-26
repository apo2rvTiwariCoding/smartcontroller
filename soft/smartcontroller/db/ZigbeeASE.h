#ifndef _DEVICE_ASE_H
#define _DEVICE_ASE_H

class CZigbeeASE
{
public:
	static CZigbeeASE* getInstance();
	CZigbeeASE();
	~CZigbeeASE();
	
  
public:
	static int insert(int deviceType, std::string addr64, int addr16, int zigbee_hw, int zigbee_fw, int device_fw);

	static int retrieveState(int deviceId, CZigbeeASE& zigbeeASE);
	static int retrieveDevId(std::string addr64, CZigbeeASE& zigbeeASE);
	static int retrieve(int deviceId, CZigbeeASE& zigbeeASE);

	int removeASE(std::string addr64);

	int getZigbeeShort(){return mZigbeeShort;}
	int getState(){return mDeviceState;}
	int getDeviceId(){return mDeviceId;}
	int getDeviceType(){return mDeviceType;}
	int getProfileId(){return mProfileId;}
	std::string getZigbeeAddr64(){return mZigbeeAddr64.c_str();}

private:
	static CZigbeeASE* mInstance;

	int mId;
	std::string mUpdated;
	std::string mJoined;
	int mDeviceId;
	int mProfileId;
	int mDeviceType;
	int mDeviceStatus;
	int mDeviceState;
  	int mZigbeeShort; 
	std::string mZigbeeAddr64;
	int mZigbeeHW;
	int mZigbeeFW;
	int mDeviceFW;
};
#endif
