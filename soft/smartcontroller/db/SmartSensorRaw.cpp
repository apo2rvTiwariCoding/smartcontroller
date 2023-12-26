#include "Database.h"
#include "SmartSensorRaw.h"

CSmartSensorRaw* CSmartSensorRaw::mInstance = NULL;
CSmartSensorRaw::CSmartSensorRaw()
{
}

CSmartSensorRaw::~CSmartSensorRaw()
{
}

CSmartSensorRaw* CSmartSensorRaw::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CSmartSensorRaw();
	}
	return mInstance;
}

int CSmartSensorRaw::insert(int source, int dataTypes, std::string address, std::string rawValue)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO smartsensorsraw(");
	str.append("id,");
	str.append("updated,");
	str.append("source,");
	str.append("type_,");
	str.append("address,");
	str.append("value_)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\',");
	str.append("\'%s\')");


	sprintf(query,str.c_str(), source, dataTypes, address.c_str(), rawValue.c_str());
   
	return CDatabase::getInstance()->execute(query);
}
