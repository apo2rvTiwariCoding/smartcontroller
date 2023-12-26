#ifndef _SMART_SENSORS_DYN_H
#define _SMART_SENSORS_DYN_H
 
class CSmartPlugdyn
{
public:
	static CSmartPlugdyn* getInstance();
	CSmartPlugdyn();
	~CSmartPlugdyn();
	
  
public:
	static int retrieve(int deviceId, CSmartPlugdyn& smartPlugDyn); 	
	static int update(int deviceId, int current); 	

	int getState(){return mState;}

private:
	static CSmartPlugdyn* mInstance;

	int mDeviceId;
	int mState;
	int mCurrent;
};

#endif