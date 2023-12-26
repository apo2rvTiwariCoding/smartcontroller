#include "Database.h"
#include "ZedDev.h"
#include "util/log/log.h"

CZedDev::CZedDev()
{
}

CZedDev::~CZedDev()
{
}

int CZedDev::retrieve(int id, CZedDev& zegDev)		
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb != NULL)
	{		
		VRECORD record;
		sprintf(query, "SELECT devices.xbee_addr64,devicesdyn.online FROM devices LEFT JOIN devicesdyn ON devicesdyn.device_id = devices.id  WHERE devices.id = %d", id);
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
				zegDev.mAddr64 = row[0].c_str();                   
				zegDev.mOnline = atoi(row[1].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

