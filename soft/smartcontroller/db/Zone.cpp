#include <sstream>
#include "Database.h"
#include "Zone.h"
#include "util/log/log.h"

CZone::CZone()
{
}

CZone::~CZone()
{
}

int CZone::retrieve(int deviceId, CZone& zone)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT zonesdyn.occupation FROM zonesdyn, devices WHERE zonesdyn.zone_id = devices.zone_id AND devices.id =  \'%d\'", deviceId);
 		int result = pdb->query(query, record);
		if(result == DB_FAIL) 
		{
			LOG_ERROR("database", "Query Not executed");
		}
		else
		{
			recCount = record.size();
			for(unsigned  int i=0;i<record.size();i++)
			{
				VROW row = record[i];
                     				
				zone.mOccupation= atoi(row[0].c_str());                                                                                     
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}
