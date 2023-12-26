#include "Database.h"
#include "Zigbee.h"
#include "util/log/log.h"

CZigbee* CZigbee::mInstance = NULL;
CZigbee::CZigbee()
{
}

CZigbee::~CZigbee()
{
}

CZigbee* CZigbee::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CZigbee();
	}
	return mInstance;
}

int CZigbee::retrieve(int zigbeeId, CZigbee zigbee)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT channel, panid FROM zigbee WHERE id = \'%d\'", zigbeeId);
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
                     				
				zigbee.mChannel=atoi(row[0].c_str());                                                                         
				zigbee.mPanId=atoi(row[1].c_str());                                                                             
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CZigbee::retrievePanId(int zigbeeId, CZigbee zigbee)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT panid_sel, panid FROM zigbee WHERE id = \'%d\'", zigbeeId);
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
                     				
				zigbee.mPanIdSel=atoi(row[0].c_str());                                                                         
				zigbee.mPanId=atoi(row[1].c_str());                                                                             
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CZigbee::retrieveChannel(int zigbeeId, CZigbee zigbee)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT channel FROM zigbee WHERE id = \'%d\'", zigbeeId);
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
                     				
				zigbee.mChannel=atoi(row[0].c_str());                                                                         
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CZigbee::retrieveEncryption(int zigbeeId, CZigbee zigbee)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT encryption, sec_key FROM zigbee WHERE id =  \'%d\'", zigbeeId);
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
                     				
				zigbee.mEncryption=atoi(row[0].c_str());
				zigbee.mSecKey = row[1].c_str();                                                                                     
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}


int CZigbee::update(int zigbeeId, int channel, int panId, std::string addr64, std::string addr16, std::string mfcId, std::string hwVersion, std::string swVersion)
{
	char query[1000];
	std::string str;
	//time_t  timestamp = time(0);

	str.append("UPDATE zigbee SET");
	str.append(" channel=");
	str.append("\'%d\',");
	str.append(" panid=");
	str.append("\'%d\',");
	str.append(" addr64=");
	str.append("\'%s\',");
	str.append(" addr16=");
	str.append("\'%s\',");
	str.append(" mfc_id=");
	str.append("\'%s\',");
	str.append(" hw_version=");
	str.append("\'%s\',");
	str.append(" sw_version=");
	str.append("\'%s\'");
	str.append(" WHERE id = \'%d\'");

	sprintf(query,str.c_str(), channel, panId, addr64.c_str(), addr16.c_str(), mfcId.c_str(), hwVersion.c_str(), swVersion.c_str(), zigbeeId);

	return CDatabase::getInstance()->execute(query);
}

int CZigbee::updatePanId(int zigbeeId, int panId)
{
	char query[1000];
	std::string str;
	//time_t  timestamp = time(0);

	str.append("UPDATE zigbee SET");
	str.append(" panid=");
	str.append("\'%d\'");
	str.append(" WHERE id = \'%d\'");

	sprintf(query,str.c_str(), panId, zigbeeId);

	return CDatabase::getInstance()->execute(query);
}


int CZigbee::updateChannel(int zigbeeId, int channel)
{
	char query[1000];
	std::string str;

	str.append("UPDATE zigbee SET");
	str.append(" channel=");
	str.append("\'%d\'");
	str.append(" WHERE id = \'%d\'");

	sprintf(query,str.c_str(), channel, zigbeeId);

	return CDatabase::getInstance()->execute(query);
}
