#include "Database.h"
#include "Humidifier.h"
#include "util/log/log.h"

CHumidifier::CHumidifier()
{
}

CHumidifier::~CHumidifier()
{
}

int CHumidifier::retrieve(CHumidifier& humidifier)
{
	int recCount =0;
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
 		int result = pdb->query("SELECT Humidifier FROM relays GROUP BY id DESC LIMIT 1", record);
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
                     				
				humidifier.mHumidifier=atoi(row[0].c_str());                                                                                                             
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}
