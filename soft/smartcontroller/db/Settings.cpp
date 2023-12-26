#include "Database.h"
#include "Settings.h"
#include "util/log/log.h"

CSettings::CSettings()
{
}

CSettings::~CSettings()
{
}

int CSettings::retrieve(CSettings& settings)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb != NULL)
	{		
		VRECORD record;
		sprintf(query, "SELECT value_ FROM hvac WHERE option_ = 'system.regmode'");
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
				settings.mValue=atoi(row[0].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
	return recCount;
}