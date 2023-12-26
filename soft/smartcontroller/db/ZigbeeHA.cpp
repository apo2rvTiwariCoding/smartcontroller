#include "Database.h"
#include "ZigbeeHA.h"
#include "util/log/log.h"

CZigbeeHA* CZigbeeHA::mInstance = NULL;
CZigbeeHA::CZigbeeHA()
{
}

CZigbeeHA::~CZigbeeHA()
{
}

CZigbeeHA* CZigbeeHA::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CZigbeeHA();
	}
	return mInstance;
}

int CZigbeeHA::insert(int clusterId, std::string addr64, int addr16)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO zigbee_ha(");
	str.append("id,");
	str.append("joined,");
	str.append("cluster_id,");
	str.append("addr64,");
	str.append("addr16)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%s\',");
	str.append("\'%d\')");

	sprintf(query,str.c_str(), clusterId, addr64.c_str(), addr16);
   
	return CDatabase::getInstance()->execute(query);
}

int CZigbeeHA::retrieveAddr(int deviceId, CZigbeeHA& zigbeeHA)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT addr64 FROM zigbee_ha WHERE device_id = \'%d\'", deviceId);
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
                     				
				zigbeeHA.mDeviceId = atoi(row[0].c_str());
				zigbeeHA.mClusterId = atoi(row[1].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CZigbeeHA::retrieve(std::string addr64, CZigbeeHA& zigbeeHA)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT device_id, cluster_id FROM zigbee_ha WHERE addr64 = \'%s\'", addr64.c_str());
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
                     				
				zigbeeHA.mDeviceId = atoi(row[0].c_str());
				zigbeeHA.mClusterId = atoi(row[1].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CZigbeeHA::removeHA(std::string addr64)
{
	char query[255];
	sprintf(query,"DELETE FROM zigbee_ha WHERE addr64=\'%s\'",addr64.c_str());
	return CDatabase::getInstance()->execute(query);
}
