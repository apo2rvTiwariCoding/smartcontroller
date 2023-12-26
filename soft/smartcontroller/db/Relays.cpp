#include "Database.h"
#include "Relays.h"
#include "util/log/log.h"

CRelays::CRelays()
{
}

CRelays::~CRelays()
{
}

int CRelays::retrieve(CRelays& relays)		//int id deleted from parameter, maybe needed later
{
	int recCount =0;
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb != NULL)
	{		
		VRECORD record;
 		int result = pdb->query("SELECT * FROM relays GROUP BY id DESC LIMIT 1", record);
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
				relays.mId=atoi(row[0].c_str());
				relays.mUpdated = row[1].c_str();                   
				relays.R1=atoi(row[2].c_str());   
				relays.R2=atoi(row[3].c_str());                     
				relays.R3=atoi(row[4].c_str());     
				relays.R4=atoi(row[5].c_str());     
				relays.R5=atoi(row[6].c_str());     
				relays.R6=atoi(row[7].c_str());     
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}