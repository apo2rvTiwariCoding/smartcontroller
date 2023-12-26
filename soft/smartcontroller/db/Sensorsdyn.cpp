#include "Database.h"
#include "Sensorsdyn.h"

CSensorsdyn* CSensorsdyn::mInstance = NULL;
CSensorsdyn::CSensorsdyn()
{
}

CSensorsdyn::~CSensorsdyn()
{
}

CSensorsdyn* CSensorsdyn::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CSensorsdyn();
	}
	return mInstance;
}

int CSensorsdyn::insert(int reportType, int deviceId, float tempMax, float humMax, int luxMax, int coMax, int co2Max, int pirCount, int rssi, int battery, int acCurrent)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO sensorsdyn(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("device_id,");
	str.append("temp_max,");
	str.append("humid_max,");
	str.append("lux_max,");
	str.append("co_max,");
	str.append("co2_max,");
	str.append("pir_count,");
	str.append("rssi,");
	str.append("battery,");
	str.append("ac_current)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%f\',");
	str.append("\'%f\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), reportType, deviceId, tempMax, humMax, luxMax, coMax, co2Max, pirCount, rssi, battery, acCurrent);
   
	return CDatabase::getInstance()->execute(query);
}
