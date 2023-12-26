#include "Database.h"
#include "DeviceRegistration.h"
#include "util/log/log.h"

CDeviceRegistration* CDeviceRegistration::mInstance = NULL;
CDeviceRegistration::CDeviceRegistration()
{
}

CDeviceRegistration::~CDeviceRegistration()
{
}

CDeviceRegistration* CDeviceRegistration::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CDeviceRegistration();
	}
	return mInstance;
}

int CDeviceRegistration::insertAddr(int eventType, int deviceType, int zigbee_hw, int zigbee_fw, int device_hw, int device_fw, int rssi, int status, std::string srcAddr)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO registrations(");
	str.append("id,");
	str.append("updated,");
	str.append("event_type,");
	str.append("device_type,");
	str.append("zigbee_addr64,");
	str.append("rssi,");
	str.append("zigbee_hw,");
	str.append("zigbee_fw,");
	str.append("device_hw,");
	str.append("device_fw,");
	str.append("status)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\')");

	sprintf(query,str.c_str(), eventType, deviceType, srcAddr.c_str(), rssi, zigbee_hw, zigbee_fw, device_hw, device_fw, status);
   
	return CDatabase::getInstance()->execute(query);
}

int CDeviceRegistration::insert(int eventType, int deviceType, int zigbee_hw, int zigbee_fw, int rssi, int status)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO registrations(");
	str.append("id,");
	str.append("updated,");
	str.append("event_type,");
	str.append("device_type,");
	str.append("rssi,");
	str.append("zigbee_hw,");
	str.append("zigbee_fw,");
	str.append("status)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\')");

	sprintf(query,str.c_str(), eventType, deviceType, rssi, zigbee_hw, zigbee_fw, status);
   
	return CDatabase::getInstance()->execute(query);
}


int CDeviceRegistration::retrieve(int registrationId, CDeviceRegistration& registration)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT zigbee_short, zigbee_addr64, device_type FROM registrations WHERE id = \'%d\'", registrationId);
 		int result = pdb->query(query, record);
		if(result == DB_FAIL) 
		{
			LOG_ERROR("database", "Query Not executed");
		}
		else
		{
			recCount = record.size();
			for(unsigned int i=0;i<record.size();i++)
			{
				VROW row = record[i];
                     				
  				registration.mZigbeeShort = atoi(row[0].c_str()); 
				registration.mZigbeeAddr64 = row[1].c_str();
                registration.mDeviceType = atoi(row[2].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CDeviceRegistration::retrieveStatus(std::string deviceAddr, CDeviceRegistration& registration)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT status FROM registrations WHERE zigbee_addr64 = \'%s\'", deviceAddr.c_str());
 		int result = pdb->query(query, record);
		if(result == DB_FAIL) 
		{
			LOG_ERROR("database", "Query Not executed");
		}
		else
		{
			recCount = record.size();
			for(unsigned int i=0;i<record.size();i++)
			{
				VROW row = record[i];
  				registration.mStatus = atoi(row[0].c_str()); 
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}
