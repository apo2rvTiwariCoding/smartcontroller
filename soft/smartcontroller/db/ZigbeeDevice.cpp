#include <sstream>
#include "Database.h"
#include "ZigbeeDevice.h"
#include "util/log/log.h"

CZigbeeDevice::CZigbeeDevice()
{
}

CZigbeeDevice::~CZigbeeDevice()
{
}

int CZigbeeDevice::retrieve(int deviceId, CZigbeeDevice zigbeeDevice)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT xbee_addr64, asemp, zone_id, device_type FROM devices WHERE id = \'%d\'", deviceId);
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
                     				
				zigbeeDevice.mXbeeAddr64= row[0].c_str();                                                                                     
				zigbeeDevice.mASEMP=atoi(row[1].c_str());                                                                                                             
				zigbeeDevice.mZoneId=atoi(row[2].c_str());
				zigbeeDevice.mDeviceType=atoi(row[3].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CZigbeeDevice::retrieveAddr64(int deviceId, CZigbeeDevice zigbeeDevice)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT xbee_addr64 FROM devices WHERE id = \'%d\'", deviceId);
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
				zigbeeDevice.mXbeeAddr64= row[0].c_str();                                                                                     
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}
