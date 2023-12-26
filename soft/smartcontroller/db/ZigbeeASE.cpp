#include "Database.h"
#include "ZigbeeASE.h"
#include "util/log/log.h"

CZigbeeASE* CZigbeeASE::mInstance = NULL;
CZigbeeASE::CZigbeeASE()
{
}

CZigbeeASE::~CZigbeeASE()
{
}

CZigbeeASE* CZigbeeASE::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CZigbeeASE();
	}
	return mInstance;
}

int CZigbeeASE::insert(int deviceType, std::string addr64, int addr16, int zigbee_hw, int zigbee_fw, int device_fw)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO zigbee_ase(");
	str.append("id,");
	str.append("joined,");
	str.append("device_type,");
	str.append("addr64,");
	str.append("addr16,");
	str.append("zigbee_hw,");
	str.append("zigbee_fw,");
	str.append("device_fw)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%s\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\')");

	sprintf(query,str.c_str(), deviceType, addr64.c_str(), addr16, zigbee_hw, zigbee_fw, device_fw);
   
	return CDatabase::getInstance()->execute(query);
}

int CZigbeeASE::retrieveState(int deviceId, CZigbeeASE& zigbeeASE)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT addr64, device_state FROM zigbee_ase WHERE id = \'%d\'", deviceId);
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
                     				
				zigbeeASE.mZigbeeAddr64 = row[0].c_str();
                zigbeeASE.mDeviceState = atoi(row[1].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
	return recCount;
}

int CZigbeeASE::retrieve(int deviceId, CZigbeeASE& zigbeeASE)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT addr64, profile_id, device_type FROM zigbee_ase WHERE id = \'%d\'", deviceId);
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
                     				
				zigbeeASE.mZigbeeAddr64 = row[0].c_str();
                zigbeeASE.mProfileId = atoi(row[1].c_str());
                zigbeeASE.mDeviceType = atoi(row[2].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
	return recCount;
}

int CZigbeeASE::retrieveDevId(std::string addr64, CZigbeeASE& zigbeeASE)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT device_id, device_type FROM zigbee_ase WHERE addr64 = \'%s\'", addr64.c_str());
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
                     				
				zigbeeASE.mZigbeeAddr64 = row[0].c_str();
                zigbeeASE.mProfileId = atoi(row[1].c_str());
                zigbeeASE.mDeviceType = atoi(row[2].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
	return recCount;
}

int CZigbeeASE::removeASE(std::string addr64)
{
	char query[255];
	sprintf(query,"DELETE FROM zigbee_ase WHERE addr64=\'%s\'",addr64.c_str());
	return CDatabase::getInstance()->execute(query);
}

