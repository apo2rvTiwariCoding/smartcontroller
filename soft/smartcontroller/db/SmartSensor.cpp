#include "Database.h"
#include "SmartSensor.h"

CSmartSensor* CSmartSensor::mInstance = NULL;
CSmartSensor::CSmartSensor()
{
}

CSmartSensor::~CSmartSensor()
{
}

CSmartSensor* CSmartSensor::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CSmartSensor();
	}
	return mInstance;
}

int CSmartSensor::insert(int type, float temperature)
{
	char query[1000];
	std::string str;
	str.append("INSERT INTO smartsensors(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("t_supply_duct)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%f\')");


	sprintf(query,str.c_str(), type, temperature);
   
	return CDatabase::getInstance()->execute(query);
}

int CSmartSensor::insertCO2(int type, int co2)
{
	char query[1000];
	std::string str;
	str.append("INSERT INTO smartsensors(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("co2)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), type, co2);
   
	return CDatabase::getInstance()->execute(query);
}

int CSmartSensor::insertHum(int type, int hum)
{
	char query[1000];
	std::string str;
	str.append("INSERT INTO smartsensors(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("h_supply_duct)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), type, hum);
   
	return CDatabase::getInstance()->execute(query);
}

int CSmartSensor::insert(int type,unsigned int colevel)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO smartsensors(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("co)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), type, colevel);
   
	return CDatabase::getInstance()->execute(query);
}

int CSmartSensor::insertTHV(int type, float temperature, int humidity, int velocity)
{
	char query[1000];
	std::string str;

	str.append("INSERT INTO smartsensors(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("froom_t,");
	str.append("froom_h,");
	str.append("air_vel)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%f\',");
	str.append("\'%d\',");
	str.append("\'%d\')");

	sprintf(query,str.c_str(), type, temperature, humidity, velocity);

	return CDatabase::getInstance()->execute(query);
}

int CSmartSensor::insertTHC(int type, float temperature, int humidity, int co2level)
{
	char query[1000];
	std::string str;

	str.append("INSERT INTO smartsensors(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("co2,");
	str.append("t_return_duct,");
	str.append("h_return_duct)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%f\',");
	str.append("\'%d\',");
	str.append("\'%d\')");

	sprintf(query,str.c_str(), type, co2level, temperature, humidity);
	return CDatabase::getInstance()->execute(query);
}

