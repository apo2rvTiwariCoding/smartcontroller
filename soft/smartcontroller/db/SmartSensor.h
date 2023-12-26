#ifndef _SMARTSENSORS_H
#define _SMARTSENSORS_H

class CSmartSensor
{
public:
	static CSmartSensor* getInstance();
	~CSmartSensor();
	
  
public:
	static int insert(int type,unsigned int colevel);
	static int insert(int type, float temperature);
	static int insertCO2(int type, int co2);
	static int insertHum(int type, int hum);
	static int insertTHC(int type, float temperature, int humidity, int co2 );
	static int insertTHV(int type, float temperature, int humidity, int velocity ) ;

private:
	static CSmartSensor* mInstance;
	CSmartSensor();

	int mId;
	std::string mUpdated;
  	int mType; 
 	float mFroomT;
  	int mFroomH;
  	int mCO; 
  	int mCO2;
  	float mInternalT;
  	float mSupplyDuctT;
  	float mReturnDuctT;
  	int mSupplyDuctH;
  	int mReturnDuctH;
  	float mHTU;
  	int mAirVel;
};

#endif