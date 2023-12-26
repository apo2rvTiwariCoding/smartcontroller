#ifndef _ZIGBEE_ALARMS_H
#define _ZIGBEE_ALARMS_H

class CZigbeeAlarm
{
public:
	static CZigbeeAlarm* getInstance();
	~CZigbeeAlarm();
	
public:
	static int insert(int deviceId, int alarmType, int severity, int commandCode, std::string desc);
	static int insertAck(int deviceId, int alarmType, int severity, int commandCode, std::string desc, int ack);
	static int insertAddr16(int deviceId, int addr16, int alarmType, int severity, int commandCode, std::string desc);
	static int insertAddr64(int deviceId,  std::string addr64, int alarmType, int severity, int commandCode, std::string desc);
	static int insertAll(int deviceId, int addr16, std::string addr64, int alarmType, int severity, int panid, int channel, int commandCode, std::string desc);
	static int insertPanId(int deviceId, int alarmType, int severity, int commandCode, std::string desc, int panID);
	static int insertChannel(int deviceId, int alarmType, int severity, int commandCode, std::string desc, int channel);
	static int insertRoute(std::string addr64, int addr16, int rssi, int alarmType, int severity, int commandCode, std::string desc, std::string route);

private:
	static CZigbeeAlarm* mInstance;
	CZigbeeAlarm();

	int mId;
	int mZoneId;
	int mDeviceId;
	std::string mUpdated;
  	int mPanId; 
	std::string mAddr64;
	int mAddress;
	int mRSSI;
	int mChannel;
	int mType;
	int mSeverity;
	std::string mDescription;
};
#endif
