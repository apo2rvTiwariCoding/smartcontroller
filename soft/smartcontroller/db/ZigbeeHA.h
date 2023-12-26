#ifndef _DEVICE_HA_H
#define _DEVICE_HA_H

class CZigbeeHA
{
public:
	static CZigbeeHA* getInstance();
	CZigbeeHA();
	~CZigbeeHA();
	
  
public:
	static int insert(int clusterId, std::string addr64, int addr16);

	static int retrieveAddr(int deviceId, CZigbeeHA& zigbeeHA);
	static int retrieve(std::string addr64, CZigbeeHA& zigbeeHA);
	static int removeHA(std::string addr64);

	int getZigbeeShort(){return mZigbeeShort;}
	std::string getZigbeeAddr64(){return mZigbeeAddr64.c_str();}

private:
	static CZigbeeHA* mInstance;

	int mId;
	std::string mUpdated;
	std::string mJoined;
	int mDeviceId;
	int mClusterId;
	int mEndPoint;
	int mProfileId;
  	int mZigbeeShort; 
	std::string mZigbeeAddr64;
	int mZigbeeMode;
	int mDeviceStatus;
};
#endif
