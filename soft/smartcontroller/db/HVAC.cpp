#include "Database.h"
#include "HVAC.h"
#include "util/log/log.h"

CHVAC::CHVAC()
{
}

CHVAC::~CHVAC()
{
}

int CHVAC::retrieve(CHVAC& hvac)
{
	int recCount =0;
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
 		int result = pdb->query("SELECT W1, W2, Y1, Y2, G, OB, Aux, Rc, Rh FROM relays GROUP BY id DESC LIMIT 1", record);
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
                     				
				hvac.W1=atoi(row[0].c_str());                                                                                                             
				hvac.W2=atoi(row[1].c_str());                                                                                                             
				hvac.Y1=atoi(row[2].c_str());                                                                                                             
				hvac.Y2=atoi(row[3].c_str());                                                                                                             
				hvac.G=atoi(row[4].c_str());                                                                                                             
				hvac.OB=atoi(row[5].c_str());                                                                                                             
				hvac.Aux=atoi(row[6].c_str());                                                                                                             
				hvac.RcRh=atoi(row[7].c_str());                                                                                                             
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
	return recCount;
}
