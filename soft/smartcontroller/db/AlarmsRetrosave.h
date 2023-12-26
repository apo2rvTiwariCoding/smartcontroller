#ifndef _ALARMS_RETROSAVE
#define _ALARMS_RETROSAVE

class CAlarmsRetrosave
{
public:
	static CAlarmsRetrosave* getInstance();
	~CAlarmsRetrosave();
	
  
public:
	static int insert(int type, int severity);


private:
	static CAlarmsRetrosave* mInstance;
	CAlarmsRetrosave();

	int mId;
	std::string mUpdated;
  	int mType; 
	int mSeverity;
};

#endif
