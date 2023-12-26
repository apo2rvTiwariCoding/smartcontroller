//ref for multiple thread using same sql connection : http://dev.mysql.com/doc/refman/5.1/en/c-api-threaded-clients.html
#ifndef _DATABASE_H
#define _DATABASE_H
#include <mysql/mysql.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <vector>
#include <string>


// macros used as constant values for database status
#define DBEXECUTE_SUCCESS	 1
#define DBQUERY_SUCCESS		 2
#define DB_FAIL				-1


// VROW is alias for std::vector<std::string>
typedef std::vector<std::string> VROW;

// VRECORD is alias for std::vector<VROW>
typedef std::vector< VROW > VRECORD;

// technically VRECORD is 2D vector of strings : vector containing vectors of string



/**
 * @brief 
 * 
 */
class CDatabase
{
	public:
		static CDatabase* getInstance(std::string server,std::string user,std::string password,std::string database);
		int dbQuery(std::string sql_query,VRECORD& record);
		
	private:
		CDatabase(std::string server,std::string user,std::string password,std::string database);
		~CDatabase();
		int connect();
		
		bool connected()
		{
			return mConnected;
		}
		
		static CDatabase* getInstance();
		int execute(std::string sql_query);
		int query(std::string sql_query,VRECORD& record);

		pthread_mutex_t mutex, mutex_exe;
		std::string mServer;
		std::string mUser;
		std::string mPassword;
		std::string mDatabase;
		MYSQL *mConnection;	// the connection
		VRECORD mRecord;
		static CDatabase* mDBInstance;
		bool mConnected;

		friend class CASEMP;
		friend class CActionThread;
		friend class CActions;
		friend class CAlarmSystem;
		friend class CAlarmsRetrosave;
		friend class CBypass;
		friend class CCommands;
		friend class CDeviceRegistration;
		friend class CDiagnostics;
		friend class CHVAC;
		friend class CHumidifier;
		friend class CPendingAction;
		friend class CRelays;
		friend class CRemoteControl;
		friend class CSensorsdyn;
		friend class CSettings;
		friend class CSmartDevices;
		friend class CSmartPlugdyn;
		friend class CSmartSensor;
		friend class CSmartSensorRaw;
		friend class CThermostat;
		friend class CZedDev;
		friend class CZigbee;
		friend class CZigbeeASE;
		friend class CZigbeeAlarm;
		friend class CZigbeeCommands;
		friend class CZigbeeDevice;
		friend class CZigbeeHA;
		friend class CZone;
};

#endif