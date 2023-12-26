#ifndef _REMOTE_CONTROL_H
#define _REMOTE_CONTROL_H

class CRemoteControl
{
public:
	CRemoteControl();
	~CRemoteControl();
	
  
public:
	static int retrieveLouver(int deviceId, CRemoteControl& remoteControl);
	static int retrieveEnableTime(int deviceId, CRemoteControl& remoteControl);
	static int retrieveDimmer(int deviceId, CRemoteControl& remoteControl);
	static int retrieveACEnable(int deviceId, CRemoteControl& remoteControl);

	int getLouverPos(){return mLouverPos;}
	int getAcEnable(){return mAcEnable;}
	int getEnableTime(){return mEnableTime;}
	int getDimmer(){return mDimmer;}
	int getRemoteAck(){return mRemoteAck;}

private:

	int mId;
	std::string mUpdated;
	int mType;
	int mDeviceId;
	int mLouverPos;
  	int mAcEnable;
	int mEnableTime;
	int mDimmer;
	int mRemoteAck; 
};

#endif