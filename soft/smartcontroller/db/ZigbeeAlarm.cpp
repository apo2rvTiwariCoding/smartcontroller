#include <sstream>
#include "Database.h"
#include "ZigbeeAlarm.h"

CZigbeeAlarm* CZigbeeAlarm::mInstance = NULL;
CZigbeeAlarm::CZigbeeAlarm()
{
}

CZigbeeAlarm::~CZigbeeAlarm()
{
}

CZigbeeAlarm* CZigbeeAlarm::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CZigbeeAlarm();
	}
	return mInstance;
}

int CZigbeeAlarm::insert(int deviceId, int alarmType, int severity, int commandCode, std::string desc)
{
	char query[1000];

	std::string des;
	des.append("0x");
	std::stringstream ss;
	ss << std::hex << commandCode;
	des.append(ss.str());
	des.append(" ");
	des.append(desc);

	std::string str;
	str.append("INSERT INTO alarms_zigbee(");
	str.append("id,");
	str.append("device_id,");
	str.append("updated,");
	str.append("type_,");
	str.append("severity,");
	str.append("description)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("\'%d\',");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), deviceId, alarmType, severity, des.c_str());
   
	return CDatabase::getInstance()->execute(query);
}

int CZigbeeAlarm::insertAck(int deviceId, int alarmType, int severity, int commandCode, std::string desc, int ack)
{
	char query[1000];

	std::string des;
	des.append("0x");
	std::stringstream ss;
	ss << std::hex << commandCode;
	des.append(ss.str());
	des.append(" ");
	des.append(desc);
	des.append(": ");
	des.append(std::to_string(ack));

	std::string str;
	str.append("INSERT INTO alarms_zigbee(");
	str.append("id,");
	str.append("device_id,");
	str.append("updated,");
	str.append("type_,");
	str.append("severity,");
	str.append("description)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("\'%d\',");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), deviceId, alarmType, severity, des.c_str());
   
	return CDatabase::getInstance()->execute(query);
}

int CZigbeeAlarm::insertAddr16(int deviceId, int addr16, int alarmType, int severity, int commandCode, std::string desc)
{
	char query[1000];

	std::string des;
	des.append("0x");
	std::stringstream ss;
	ss << std::hex << commandCode;
	des.append(ss.str());
	des.append(" ");
	des.append(desc);

	std::string str;
	str.append("INSERT INTO alarms_zigbee(");
	str.append("id,");
	str.append("device_id,");
	str.append("updated,");
	str.append("address,");
	str.append("type_,");
	str.append("severity,");
	str.append("description)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("\'%d\',");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), deviceId, addr16, alarmType, severity, des.c_str());
   
	return CDatabase::getInstance()->execute(query);
}


int CZigbeeAlarm::insertAddr64(int deviceId,  std::string addr64, int alarmType, int severity, int commandCode, std::string desc)
{
	char query[1000];

	std::string des;
	des.append("0x");
	std::stringstream ss;
	ss << std::hex << commandCode;
	des.append(ss.str());
	des.append(" ");
	des.append(desc);

	std::string str;
	str.append("INSERT INTO alarms_zigbee(");
	str.append("id,");
	str.append("device_id,");
	str.append("updated,");
	str.append("addr64,");
	str.append("type_,");
	str.append("severity,");
	str.append("description)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("\'%d\',");
	str.append("NOW(),");
	str.append("\'%s\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), deviceId, addr64.c_str(), alarmType, severity, des.c_str());
   
	return CDatabase::getInstance()->execute(query);
}

int CZigbeeAlarm::insertAll(int deviceId, int addr16, std::string addr64, int alarmType, int severity, int panid, int channel, int commandCode, std::string desc)
{
	char query[1000];

	std::string des;
	des.append("0x");
	std::stringstream ss;
	ss << std::hex << commandCode;
	des.append(ss.str());
	des.append(" ");
	des.append(desc);

	std::string str;
	str.append("INSERT INTO alarms_zigbee(");
	str.append("id,");
	str.append("zone_id,");
	str.append("device_id,");
	str.append("updated,");
	str.append("panid,");
	str.append("addr64,");
	str.append("address,");
	str.append("channel,");
	str.append("type_,");
	str.append("severity,");
	str.append("description)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NULL,");
	str.append("\'%d\',");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%s\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), deviceId, panid, addr64.c_str(), addr16, channel, alarmType, severity, des.c_str());
   
	return CDatabase::getInstance()->execute(query);
}

int CZigbeeAlarm::insertPanId(int deviceId, int alarmType, int severity, int commandCode, std::string desc, int panID)
{
	char query[1000];

	std::string des;
	des.append("0x");
	std::stringstream ss;
	ss << std::hex << commandCode;
	des.append(ss.str());
	des.append(" ");
	des.append(desc);

	std::string str;
	str.append("INSERT INTO alarms_zigbee(");
	str.append("id,");
	str.append("device_id,");
	str.append("updated,");
	str.append("panid,");
	str.append("type_,");
	str.append("severity,");
	str.append("description)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("\'%d\',");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), deviceId, panID, alarmType, severity, des.c_str());
   
	return CDatabase::getInstance()->execute(query);
}

int CZigbeeAlarm::insertChannel(int deviceId, int alarmType, int severity, int commandCode, std::string desc, int channel)
{
	char query[1000];

	std::string des;
	des.append("0x");
	std::stringstream ss;
	ss << std::hex << commandCode;
	des.append(ss.str());
	des.append(" ");
	des.append(desc);

	std::string str;
	str.append("INSERT INTO alarms_zigbee(");
	str.append("id,");
	str.append("device_id,");
	str.append("updated,");
	str.append("channel,");
	str.append("type_,");
	str.append("severity,");
	str.append("description)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("\'%d\',");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), deviceId, channel, alarmType, severity, des.c_str());
   
	return CDatabase::getInstance()->execute(query);
}

int CZigbeeAlarm::insertRoute(std::string addr64, int addr16, int rssi, int alarmType, int severity, int commandCode, std::string desc, std::string route)
{
	char query[1000];

	std::string des;
	des.append("0x");
	std::stringstream ss;
	ss << std::hex << commandCode;
	des.append(ss.str());
	des.append(" ");
	des.append(desc);
	des.append(" ");
	des.append(route);

	std::string str;
	str.append("INSERT INTO alarms_zigbee(");
	str.append("id,");
	str.append("updated,");
	str.append("addr64,");
	str.append("address,");
	str.append("rssi,");
	str.append("type_,");
	str.append("severity,");
	str.append("description)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%s\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), addr64.c_str(), addr16, rssi, alarmType, severity, des.c_str());
   
	return CDatabase::getInstance()->execute(query);
}
