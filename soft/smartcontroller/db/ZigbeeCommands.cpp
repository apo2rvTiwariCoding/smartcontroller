#include "Database.h"
#include "ZigbeeCommands.h"
#include "inc/SensorTypes.h"
#include "util/log/log.h"

CZigbeeCommands* CZigbeeCommands::mInstance = NULL;
CZigbeeCommands::CZigbeeCommands()
{
}

CZigbeeCommands::~CZigbeeCommands()
{
}

CZigbeeCommands* CZigbeeCommands::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CZigbeeCommands();
	}
	return mInstance;
}

int CZigbeeCommands::insert(int returnCode, std::string returnString, int returnValue)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO zigbee_commands(");
	str.append("id,");
	str.append("updated,");
	str.append("return_code,");
	str.append("result_string,");
	str.append("return_value)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%s\',");
	str.append("\'%d\')");

	sprintf(query,str.c_str(), returnCode, returnString.c_str(), returnValue);
   
	return CDatabase::getInstance()->execute(query);
}

int CZigbeeCommands::insert(int returnCode)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO zigbee_commands(");
	str.append("id,");
	str.append("updated,");
	str.append("return_code)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\')");

	sprintf(query,str.c_str(), returnCode);
   
	return CDatabase::getInstance()->execute(query);
}

int CZigbeeCommands::retrieve(int deviceId, CZigbeeCommands& zigbeeCommand)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT command, return_code FROM zigbee_commands WHERE device_id = \'%d\'", deviceId);
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
                     				
				zigbeeCommand.mCommand = atoi(row[0].c_str());
				zigbeeCommand.mReturnedCode = atoi(row[1].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
	return recCount;
}

int CZigbeeCommands::remove()
{
	char query[255];
	sprintf(query,"DELETE FROM zigbee_commands WHERE updated < NOW() - \'%d\'",ASE_ZC_STALE_TIME);
	return CDatabase::getInstance()->execute(query);
}
