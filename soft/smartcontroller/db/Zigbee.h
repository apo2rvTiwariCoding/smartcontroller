#ifndef _ZIGBEE_DB_H
#define _ZIGBEE_DB_H

class CZigbee
{
public:
	static CZigbee* getInstance();
	CZigbee();
	~CZigbee();
	
  
public:

	static int update(int zigbeeId, int channel, int panId, std::string addr64, std::string  addr16, std::string mfcId, std::string hwVersion, std::string swVersion);
	static int updatePanId(int zigbeeId, int panId);	
	static int updateChannel(int zigbeeId, int channel);	

	static int retrieve(int zigbeeId, CZigbee zigbee);
	static int retrieveChannel(int zigbeeId, CZigbee zigbee);
	static int retrievePanId(int zigbeeId, CZigbee zigbee);
	static int retrieveEncryption(int zigbeeId, CZigbee zigbee);

	int getChannel(){return mChannel;}
	int getPanId(){return mPanId;}
	int getPanIdSel(){return mPanIdSel;}
	int getEncryption(){return mEncryption;}
	std::string getSecKey(){return mSecKey.c_str();}

private:
	static CZigbee* mInstance;

	int mId;
  	int mChannel; 
  	int mChannelSel; 
  	int mPanId; 
  	int mPanIdSel; 
  	int mEncryption; 
  	std::string mAddr64; 
  	std::string mAddr16; 
	std::string mSecKey;
	std::string mMfcId;
	std::string mHwVer;
	std::string mSwVer;
	int mAlarms;
};
#endif
