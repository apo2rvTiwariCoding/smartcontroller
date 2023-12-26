#ifndef _ZIGBEE_COMMANDS_H
#define _ZIGBEE_COMMANDS_H

class CZigbeeCommands
{
public:
	static CZigbeeCommands* getInstance();
	CZigbeeCommands();
	~CZigbeeCommands();
	
  
public:
	static int insert(int returnCode, std::string returnString, int returnValue);
	static int insert(int returnCode);

	static int remove();
	static int retrieve(int deviceId, CZigbeeCommands& zigbeeCommand);

	int getCommand(){return mCommand;}
	int getReturnedCode(){return mReturnedCode;}

private:
	static CZigbeeCommands* mInstance;

	int mId;
	std::string mUpdated;
	int mDeviceId;
	int mCommand;
	int mReturnedCode;
	int mReturnedString;
  	int mReturnedValue; 
};
#endif
