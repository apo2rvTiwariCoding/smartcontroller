#include <sstream>
#include "Database.h"
#include "RemoteControl.h"
#include "util/log/log.h"

CRemoteControl::CRemoteControl()
{
}

CRemoteControl::~CRemoteControl()
{
}

int CRemoteControl::retrieveLouver(int deviceId, CRemoteControl& remoteControl)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT louver_pos, remote_ack FROM remotecontrol WHERE device_id = \'%d\'", deviceId);
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
                     				
				remoteControl.mLouverPos = atoi(row[0].c_str());
				remoteControl.mRemoteAck = atoi(row[1].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CRemoteControl::retrieveACEnable(int deviceId, CRemoteControl& remoteControl)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT ac_enable, remote_ack FROM remotecontrol WHERE device_id = \'%d\'", deviceId);
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
                     				
				remoteControl.mAcEnable = atoi(row[0].c_str());
				remoteControl.mRemoteAck = atoi(row[1].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CRemoteControl::retrieveDimmer(int deviceId, CRemoteControl& remoteControl)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT dimmer, remote_ack FROM remotecontrol WHERE device_id = \'%d\'", deviceId);
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
                     				
				remoteControl.mDimmer= atoi(row[0].c_str());
				remoteControl.mRemoteAck = atoi(row[1].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CRemoteControl::retrieveEnableTime(int deviceId, CRemoteControl& remoteControl)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT time_enable, remote_ack FROM remotecontrol WHERE device_id = \'%d\'", deviceId);
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
                     				
				remoteControl.mEnableTime = atoi(row[0].c_str());
				remoteControl.mRemoteAck = atoi(row[1].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

