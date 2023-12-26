#include "Database.h"
#include "Commands.h"
#include "util/log/log.h"

CCommands::CCommands()
{
}

CCommands::~CCommands()
{
}

int CCommands::retrieve(int id, CCommands& command)
{
	int recCount =0;
	char query[1000];

	CDatabase* pdb = CDatabase::getInstance();
	if(pdb != NULL)
	{		
		VRECORD record;
		sprintf(query, "SELECT id, command, priority, flags, device_id, type_, parameters FROM commands WHERE id = '%d'", id);
 		int result = pdb->query(query, record);
		if(result == DB_FAIL) 
		{
			LOG_ERROR("database", "Query not executed");
		}
		else
		{
			recCount = record.size();
			for(unsigned int i=0;i<record.size();i++)
			{
				VROW row = record[i];
				command.mId=atoi(row[0].c_str());
				command.mCommand=atoi(row[1].c_str());
				command.mPriority=atoi(row[2].c_str());
				command.mFlags=atoi(row[3].c_str());
				command.mDeviceId=atoi(row[4].c_str());
				command.mType=static_cast< CCommands::TType >(atoi(row[5].c_str()));
				command.mParameter=row[6].c_str();
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
		//fprintf(stderr,"\n CCommands::retrieve(): CDatabase instance is null.");
	}
	return recCount;
}