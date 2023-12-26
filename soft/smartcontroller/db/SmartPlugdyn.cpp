#include "Database.h"
#include "SmartPlugdyn.h"
#include "util/log/log.h"

CSmartPlugdyn* CSmartPlugdyn::mInstance = NULL;
CSmartPlugdyn::CSmartPlugdyn()
{
}

CSmartPlugdyn::~CSmartPlugdyn()
{
}

CSmartPlugdyn* CSmartPlugdyn::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CSmartPlugdyn();
	}
	return mInstance;
}

int CSmartPlugdyn::retrieve(int deviceId, CSmartPlugdyn& smartPlugDyn)		//int id deleted from parameter, maybe needed later
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT state FROM smartplugsdyn WHERE id = \'%d\'", deviceId);
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
                     				
				smartPlugDyn.mState=atoi(row[0].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CSmartPlugdyn::update(int deviceId, int current)
{
	char query[1000];
	std::string str;

	str.append("UPDATE smartplugsdyn SET");
	str.append("current=");
	str.append("\'%d\'");
	str.append(" WHERE device_id = \'%d\'");

	sprintf(query,str.c_str(), current, deviceId);

	return CDatabase::getInstance()->execute(query);
}
