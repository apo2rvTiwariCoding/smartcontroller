#include <string.h>
#include "Database.h"
#include "util/log/log.h"

CDatabase* CDatabase::mDBInstance = NULL;
CDatabase::CDatabase(std::string server,std::string user,std::string password,std::string database)
{
	LOG_INFO("database", "Inside CDatabase constructor");
	mServer=server;
	mUser=user;
	mPassword=password;
	mDatabase=database;
	mConnection=mysql_init(NULL);
	mConnected=false;
	mutex = mutex_exe = PTHREAD_MUTEX_INITIALIZER;
	if(!connect())
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}
}

CDatabase::~CDatabase()
{
	mysql_close(mConnection);
	if (pthread_mutex_destroy(&mutex))
	{
		LOG_ERROR("database", "mutex could not be destroyed");
	}
	if (pthread_mutex_destroy(&mutex_exe))
	{
		LOG_ERROR("database", "mutex_exe could not be destroyed");
	}
}


// singleton pattern
CDatabase* CDatabase::getInstance(std::string server,std::string user,std::string password,std::string database)
{
	if(mDBInstance == NULL)
	{
		mDBInstance = new CDatabase(server,user,password,database);
	}
	return mDBInstance;
}

CDatabase* CDatabase::getInstance()
{
	return mDBInstance;
}

int CDatabase::connect()
{
	if(mConnection==0) return 0;

	if (!mysql_real_connect(mConnection, mServer.c_str(), mUser.c_str(), mPassword.c_str(), mDatabase.c_str(), 0, NULL, 0)) 
	{
		LOG_ERROR_FMT("database", "Connection error: %s", mysql_error(mConnection));
		mConnected = false;
	}
	mConnected = true;
	return mConnected;
}

int CDatabase::execute(std::string sql_query)
{
	if(!connected()) return DB_FAIL;

	int dbResult = DBEXECUTE_SUCCESS;

	if (!pthread_mutex_lock(&mutex))
	{
		//MYSQL_RES *result;  // the results
		//MYSQL_ROW row;    	// the results row (line by line)
		// send the query to the database
		if (mysql_query(mConnection, sql_query.c_str()))
		{
			LOG_ERROR_FMT("database", "Mysql Query Error: %s", mysql_error(mConnection));
			dbResult = DB_FAIL;
		}
	}
	else
	{
		dbResult = DB_FAIL;
	}
	if (pthread_mutex_unlock(&mutex))
	{
		dbResult = DB_FAIL;
	}
	return dbResult;
}

int CDatabase::query(std::string sql_query,VRECORD& record)
{
	int res=DBQUERY_SUCCESS;
	if (!pthread_mutex_lock(&mutex)) // if successfull it returns zero
	{
		MYSQL_RES *result;  // the results
		MYSQL_ROW row;    	// the results row (line by line)
		if(connected())
		{ 
			// send the query to the database
			if (mysql_query(mConnection, sql_query.c_str()))
			{
				LOG_ERROR_FMT("database", "Mysql Query Error: %s", mysql_error(mConnection));
				res= DB_FAIL;
			}
			else
			{
				result = mysql_use_result(mConnection);
				int colCount = mysql_num_fields(result);
				if(result != NULL)
				{
					while ((row = mysql_fetch_row(result)) !=NULL)
					{
						VROW vecRow;
						for(int i=0;i<colCount;i++)
						{
							char rowItem[255];
							if(row[i] == NULL) 
							{
								row[i] = (char * )"NULL";
							}
							sprintf(rowItem,"%s",row[i]);
							vecRow.push_back(std::string(rowItem));
						}
						record.push_back(vecRow);	
					}
					mysql_free_result(result);	
					res= DBQUERY_SUCCESS;
				}
			}
		}
		else
		{
			res= DB_FAIL;
		}
	}
	else
	{
		LOG_ERROR("database", "Can't lock mutex");
		res= DB_FAIL;
	}
	if (pthread_mutex_unlock(&mutex))
	{
		LOG_ERROR("database", "Can't unlock mutex");
		res= DB_FAIL;
	}

	return res;
} 

int CDatabase::dbQuery(std::string sql_query,VRECORD& record)
{
	return query(sql_query,record);
}