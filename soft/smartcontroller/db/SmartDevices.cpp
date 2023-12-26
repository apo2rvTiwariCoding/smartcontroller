#include <iostream>
#include <sstream>
#include <string.h>
#include "Database.h"
#include "SmartDevices.h"
#include "util/log/log.h"

CSmartDevices* CSmartDevices::mInstance = NULL;
CSmartDevices::CSmartDevices()
{
}

CSmartDevices::~CSmartDevices()
{
}

CSmartDevices* CSmartDevices::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CSmartDevices();
	}
	return mInstance;
}

int CSmartDevices::retrieve1WDev(Hal::TW1DevicesInfo& devices)
{
	int recCount =0;
	char query[1000];

	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT type_, address FROM smartdevices WHERE interface = 2");
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
                Hal::TW1DeviceType type = (Hal::TW1DeviceType)(atoi(row[0].c_str()));
				Hal::TW1DeviceAddress addr;
				::std::stringstream ss;
				ss << std::hex << row[1];
				ss >> addr;
				
				std::cout << "Address: " << addr << " Type " << type << '\n';
				
				Hal::TW1DeviceInfo deviceInfo = Hal::TW1DeviceInfo(type, addr);
				std::cout << "deviceInfoAddress: " << deviceInfo.m_address << " deviceInfoType " << deviceInfo.m_type << '\n';
				devices.push_back(deviceInfo);
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}

	return recCount;
}

int CSmartDevices::retrieve1WDevStatus(std::string address, CSmartDevices& cSmartDevices)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb != NULL)
	{		
		VRECORD record;
		sprintf(query,"SELECT status FROM smartdevices WHERE address = \'%s\'",address.c_str());
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
				cSmartDevices.mStatus = atoi(row[0].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
	return recCount;
}

int CSmartDevices::retrieve(int id, CSmartDevices& cSmartDevices)		
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb != NULL)
	{		
		VRECORD record;
		sprintf(query,"SELECT type_, interface, address, period, status, "
		        "highthres, lowthres FROM smartdevices WHERE id = \'%d\'",id);
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
				cSmartDevices.mType = atoi(row[0].c_str());
				cSmartDevices.mInterface = atoi(row[1].c_str());
				cSmartDevices.mAddress = row[2].c_str();
				cSmartDevices.mInterval = atoi(row[3].c_str());
				cSmartDevices.mStatus = atoi(row[4].c_str());
			    cSmartDevices.mHighThr = atoi(row[5].c_str());
			    cSmartDevices.mLowThr = atoi(row[6].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
	return recCount;
}

int CSmartDevices::retrieveHighThr(int id, CSmartDevices& cSmartDevices)		
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb != NULL)
	{		
		VRECORD record;
		sprintf(query,"SELECT address,highthres FROM smartdevices WHERE id = \'%d\'",id);
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
				cSmartDevices.mAddress=row[0].c_str();
				cSmartDevices.mHighThr=atoi(row[1].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CSmartDevices::retrieveLowThr(int id, CSmartDevices& cSmartDevices)		
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb != NULL)
	{		
		VRECORD record;
		sprintf(query,"SELECT address,lowthres FROM smartdevices WHERE id = \'%d\'",id);
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
				cSmartDevices.mAddress=row[0].c_str();
				cSmartDevices.mLowThr=atoi(row[1].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CSmartDevices::retrieveThrs(int interface, int address, CSmartDevices& cSmartDevices)
{
    int recCount =0;
    char query[1000];
    CDatabase* pdb = CDatabase::getInstance();
    if(pdb != NULL)
    {
        VRECORD record;
        sprintf(query,"SELECT lowthres,highthres FROM smartdevices "
                "WHERE interface = \'%d\' AND address = \'%d\'",
                interface, address);
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
                cSmartDevices.mLowThr=atoi(row[0].c_str());
                cSmartDevices.mHighThr=atoi(row[1].c_str());
            }
        }
    }
    else
    {
        LOG_ERROR("database", "CDatabase returned a NULL pointer");
    }
    return recCount;
}

int CSmartDevices::retrieveStatus(int type, CSmartDevices& cSmartDevices)		
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb != NULL)
	{		
		VRECORD record;
		sprintf(query,"SELECT status FROM smartdevices WHERE type_ = \'%d\'",type);
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
				cSmartDevices.mStatus=atoi(row[0].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
return recCount;
}

int CSmartDevices::retrieveStatusInt(int interface, int address, CSmartDevices& cSmartDevices)
{
    int recCount =0;
    char query[1000];
    CDatabase* pdb = CDatabase::getInstance();
    if(pdb != NULL)
    {
        VRECORD record;
        sprintf(query, "SELECT status FROM smartdevices "
                       "WHERE interface = \'%d\' AND address = \'%d\'",
                       interface, address);
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
                cSmartDevices.mStatus=atoi(row[0].c_str());
            }
        }
    }
    else
    {
        LOG_ERROR("database", "CDatabase returned a NULL pointer");
    }
    return recCount;
}

int CSmartDevices::retrieveInt(int id, CSmartDevices& cSmartDevices)		
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb != NULL)
	{		
		VRECORD record;
		sprintf(query,"SELECT period FROM smartdevices WHERE id = \'%d\'",id);
 		int result = pdb->query(query, record);
		if(result == DB_FAIL) 
		{
			LOG_ERROR("database", "Query Not executed");		}
		else
		{
			recCount = record.size();
			for(unsigned int i=0;i<record.size();i++)
			{
				VROW row = record[i];
				cSmartDevices.mInterval=atoi(row[0].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
	return recCount;
}

int CSmartDevices::retrieveIntInt(int interface, int address, CSmartDevices& cSmartDevices)
{
    int recCount =0;
    char query[1000];
    CDatabase* pdb = CDatabase::getInstance();
    if(pdb != NULL)
    {
        VRECORD record;
        sprintf(query, "SELECT period FROM smartdevices "
                       "WHERE interface = \'%d\' AND address = \'%d\'",
                       interface, address);
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
                cSmartDevices.mInterval=atoi(row[0].c_str());
            }
        }
    }
    else
    {
        LOG_ERROR("database", "CDatabase returned a NULL pointer");
    }
    return recCount;
}

int CSmartDevices::retrieveIntAddr(std::string address, CSmartDevices& cSmartDevices)
{
	int recCount =0;
	char query[1000];
	CDatabase* pdb = CDatabase::getInstance();
	if(pdb != NULL)
	{		
		VRECORD record;
		sprintf(query,"SELECT period FROM smartdevices WHERE address = \'%s\'",address.c_str());
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
				cSmartDevices.mInterval=atoi(row[0].c_str());
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
	return recCount;
}

int CSmartDevices::insert(std::string address, int type)
{
	char query[1000];
	std::string str;
	
	str.append("INSERT INTO smartdevices(");
	str.append("id,");
	str.append("updated,");
	str.append("interface,");
	str.append("type_,");
	str.append("address)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), 2, type, address.c_str());
	
	return CDatabase::getInstance()->execute(query);
}

int CSmartDevices::update(std::string address, std::string updateAddr)
{
	char query[1000];
	std::string str;

	str.append("UPDATE smartdevices SET");
	str.append(" type_=");
	str.append("\'%d\',");
	str.append(" interface=");
	str.append("\'%d\',");
	str.append(" status=");
	str.append("\'%d\',");
	str.append(" period=");
	str.append("\'%d\',");
	str.append(" address=");
	str.append("\'%s\',");
	str.append(" alarm=");
	str.append("\'%d\',");
	str.append(" severity=");
	str.append("\'%d\',");
	str.append(" maker=");
	str.append("\'%s\'");
	str.append(" model=");
	str.append("\'%s\'");
	str.append(" description=");
	str.append("\'%s\'");
	str.append(" WHERE address = \'%s\'");

	sprintf(query,str.c_str(), NULL, 2, 0, 40, updateAddr.c_str(), 0, NULL, NULL, NULL, NULL, address.c_str());

	return CDatabase::getInstance()->execute(query);
}

int CSmartDevices::disableOneWireDev()
{
	char query[1000];
	std::string str;

	str.append("UPDATE smartdevices SET");
	str.append(" status=");
	str.append("\'%d\'");
	str.append(" WHERE interface = \'%d\'");

	sprintf(query,str.c_str(), 0, 2);

	return CDatabase::getInstance()->execute(query);
}

int CSmartDevices::disableOneWireDevAddr(std::string address)
{
	char query[1000];
	std::string str;

	str.append("UPDATE smartdevices SET");
	str.append(" status=");
	str.append("\'%d\'");
	str.append(" WHERE interface = \'%d\' AND address = \'%s\'");

	sprintf(query,str.c_str(), 0, 2, address.c_str());

	return CDatabase::getInstance()->execute(query);
}

int CSmartDevices::removeOneWireDev()
{
	char query[255];
	sprintf(query,"DELETE FROM smartdevices WHERE interface = 2");
	return CDatabase::getInstance()->execute(query);
}

int CSmartDevices::removeOneWireDevAddr(std::string address)
{
	char query[255];
	sprintf(query,"DELETE FROM smartdevices WHERE address = \'%s\'",address.c_str());
	#ifdef DEBUGSD
	printf ("%s\n", query);
	#endif
	return CDatabase::getInstance()->execute(query);
}

int CSmartDevices::enumerateOneWireDev(Hal::TW1DevicesInfo& devicesHAL)
{
	int hal, db, flag = 0;
	hal = devicesHAL.size();
	Hal::TW1DevicesInfo devicesDB;
	retrieve1WDev(devicesDB);
	db = devicesDB.size();
	#ifdef DEBUGSD
	printf("Size of deviceDB : %d\n", devicesDB.size());
	printf("Size of deviceHAL: %d\n", devicesHAL.size());
	printf("*****************************\n");
	#endif	
	#ifdef DEBUGSD
	for(int i=0; i<devicesDB.size(); i++)
		printf("deviceDB : %d @ %d\n", devicesDB[i], i);
	printf("*****************************\n");
	for(int i=0; i<devicesHAL.size(); i++)
		printf("deviceHAL: %d @ %d\n", devicesHAL[i], i);
	printf("*****************************\n");
	#endif	
	if(hal == 0)
	{
		disableOneWireDev();
	}
	else
	{
		for(int i=0; i<db; i++)
		{
			#ifdef DEBUGSD
			printf("i = %d\n", i);
			#endif
			for(int j=0; j<hal; j++)
			{
				if(devicesDB[i].m_address == devicesHAL[j].m_address)
				{
					flag = 1;
					devicesHAL.erase(devicesHAL.begin() + j);
					hal--;
					#ifdef DEBUGSD
					printf("Size of deviceHAL: %d and hal: %d\n", devicesHAL.size(), hal);
					printf("*****************************\n");
					for(int i=0; i<devicesHAL.size(); i++)
					{
						printf("deviceHAL: %d @ %d\n", devicesHAL[i], i);
					}
					printf("*****************************\n");
					#endif
					break;
				}
			}
			if(flag == 0)
			{
				std::string str_rem;
				::std::ostringstream out;
				out <<  std::hex << devicesDB[i].m_address;
				str_rem = out.str();
				disableOneWireDevAddr(str_rem);
				#ifdef DEBUGSD
				printf("Size of deviceDB (Before Deleting): %d and db: %d\n", devicesDB.size(), db);
				printf("*****************************\n");
				#endif				
				#ifdef DEBUGSD
				printf("Size of deviceDB: %d and db: %d\n", devicesDB.size(), db);
				for(int i=0; i<devicesDB.size(); i++)
					printf("deviceDB : %d @ %d\n", devicesDB[i], i);
				printf("*****************************\n");
				#endif			
				#ifdef DEBUGSD
				printf("deviceDB(db)\n");
				for(int i=0; i<db; i++)
					printf("deviceDB : %d @ %d\n", devicesDB[i], i);
				printf("*****************************\n");
				#endif			
			}
			flag = 0;
		}
		for(int k=0; k<hal; k++)
		{
			#ifdef DEBUGSD
			printf("inserting into DB: %s\n", to_std::string(devicesHAL[k]).c_str());
			printf("*****************************\n");
			#endif
			::std::ostringstream out;
			out << std::hex << devicesHAL[k].m_address;
			std::string str = out.str();
			insert(str, (devicesHAL[k].m_type + 3));			//It must be converted to proper value
		}
	}
	#ifdef DEBUGSD
	printf("Size of deviceDB : %d and db : %d\n", devicesDB.size(), db);
	printf("Size of deviceHAL: %d and hal: %d\n", devicesHAL.size(), hal);
	printf("*****************************\n");
	for(int i=0; i<devicesDB.size(); i++)
		printf("deviceDB : %d @ %d\n", devicesDB[i], i);
	printf("*****************************\n");
	for(int i=0; i<devicesHAL.size(); i++)
		printf("deviceHAL: %d @ %d\n", devicesHAL[i], i);
	printf("*****************************\n");
	#endif	
	
	return 0;
}
