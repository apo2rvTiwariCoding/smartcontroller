#ifndef _ALARMS_SYSTEM_H
#define _ALARMS_SYSTEM_H

class CAlarmSystem
{
public:
	static CAlarmSystem* getInstance();
	~CAlarmSystem();
	
  
public:
	static int insert(int type, int severity, std::string val);
	static int insert(int type, int severity, int commandCode, std::string desc);


private:
	static CAlarmSystem* mInstance;
	CAlarmSystem();

	int mId;
	std::string mUpdated;
  	int mType; 
	int mSeverity;
	std::string mDescription;
};

#endif