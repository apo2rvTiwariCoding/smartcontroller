#include <sstream>
#include "Database.h"
#include "AlarmsRetrosave.h"

CAlarmsRetrosave* CAlarmsRetrosave::mInstance = NULL;
CAlarmsRetrosave::CAlarmsRetrosave()
{
}

CAlarmsRetrosave::~CAlarmsRetrosave()
{
}

CAlarmsRetrosave* CAlarmsRetrosave::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CAlarmsRetrosave();
	}
	return mInstance;
}

int CAlarmsRetrosave::insert(int type, int severity)
{
	char query[1000];

	std::string str;

	str.append("INSERT INTO alarms_retrosave(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("severity)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\')");

	sprintf(query,str.c_str(), type, severity);
   
	return CDatabase::getInstance()->execute(query);
}


