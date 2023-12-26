#ifndef _SMART_SENSORS_RAW_H
#define _SMART_SENSORS_RAW_H

class CSmartSensorRaw
{
public:
	static CSmartSensorRaw* getInstance();
	~CSmartSensorRaw();
	  
public:
	static int insert(int source, int dataTypes, std::string address, std::string rawValue);

private:
	static CSmartSensorRaw* mInstance;
	CSmartSensorRaw();

	int mId;
	std::string mUpdated;
	int mSource;
  	int mType; 
 	std::string mAddress;
  	std::string mValue;
};

#endif