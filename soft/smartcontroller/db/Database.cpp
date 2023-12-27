#include <string.h>
#include "Database.h"
#include "util/log/log.h"


// global pointer to hold CDatabase class object instance.
CDatabase* CDatabase::mDBInstance = NULL;

/**
 * @brief Construct a new CDatabase::CDatabase object
// parameterized constructor to initialize 
// variables : mServer, mUser, mPassword, mDatabase
// mConnection from mysql_init()
// mConnected
// mutexes : mutex, mutex_exe with PTHREAD_MUTEX_INITIALIZER
// mutexes are used to initialize with macro PTHREAD_MUTEX_INITIALIZER (actual value : -1)
 * 
//  also check CDatabase::connect() and if return 0 then log error
 * @param server 
 * @param user 
 * @param password 
 * @param database 
 */
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

// destructor 
// closes sql
// destroy mutex, mutex_exe
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
// create instance of CDatabase object if not present else return the pointer of present one
CDatabase* CDatabase::getInstance(std::string server,std::string user,std::string password,std::string database)
{
	if(mDBInstance == NULL)
	{
		mDBInstance = new CDatabase(server,user,password,database);
	}
	return mDBInstance;
}

// just return the CDatabase object pointer doesn't matter present or not.
CDatabase* CDatabase::getInstance()
{
	return mDBInstance;
}

// connect to sql and return status
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

// execute query for sql with first mutex lock, query, mutex unlock
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


// query mysql with sql_query
// mutex lock
// query
// if result found
// then, 
// 		push all strings to vector container of string
// 		push string vector container to vector container of string vector container
// 		free the memory used by query result
// else 
// 		set flag for query fail
// mutex unlock
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


// wrapper function for query function, directly
int CDatabase::dbQuery(std::string sql_query,VRECORD& record)
{
	return query(sql_query,record);
}