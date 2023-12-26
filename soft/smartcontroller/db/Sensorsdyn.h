#ifndef _SENSORS_DYN_H
#define _SENSORS_DYN_H

class CSensorsdyn
{
public:
	static CSensorsdyn* getInstance();
	~CSensorsdyn();
	
  
public:
	static int insert(int reportType, int deviceId, float tempMax, float humMax, int luxMax, int coMax, int co2Max, int pirCount, int rssi, int battery, int acCurrent);

private:
	static CSensorsdyn* mInstance;
	CSensorsdyn();

	int mId;
	std::string mUpdated;
  	int mType; 
  	int mDeviceId; 
 	float mMaxTemp;
 	float mMinTemp;
 	float mAvgTemp;
 	float mMaxHum;
 	float mMinHum;
 	float mAvgHum;
  	int mMaxLux;
  	int mMinLux;
  	int mMaxCO; 
  	int mMinCO; 
  	int mAvgCO; 
  	int mMaxCO2; 
  	int mMinCO2; 
  	int mAvgCO2; 
  	int mCountPIR;
  	int mRSSI;
  	int mBattery;
  	int mRemoteAck;
};

#endif