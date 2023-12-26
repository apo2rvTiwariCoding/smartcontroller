#include <sstream>
#include "Database.h"
#include "AlarmSystem.h"

CAlarmSystem* CAlarmSystem::mInstance = NULL;
CAlarmSystem::CAlarmSystem()
{
}

CAlarmSystem::~CAlarmSystem()
{
}

CAlarmSystem* CAlarmSystem::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CAlarmSystem();
	}
	return mInstance;
}

int CAlarmSystem::insert(int type, int severity, std::string val)
{
	char query[1000];
	std::string str;

	str.append("INSERT INTO alarms_system(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("severity,");
	str.append("description)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), type, severity, val.c_str());

   
	return CDatabase::getInstance()->execute(query);
}

int CAlarmSystem::insert(int type, int severity, int commandCode, std::string desc)
{
	char query[1000];

	std::string str;

	std::string des;
	des.append("0x");
	std::stringstream ss;
	ss << std::hex << commandCode;
	des.append(ss.str());
	des.append(" ");
	des.append(desc);

	str.append("INSERT INTO alarms_system(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("severity,");
	str.append("description)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), type, severity, des.c_str());

   
	return CDatabase::getInstance()->execute(query);
}


