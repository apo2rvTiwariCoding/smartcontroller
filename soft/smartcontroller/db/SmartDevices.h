#ifndef _SMARTDEVICES_H
#define _SMARTDEVICES_H

#include "hal/hal.h"

class CSmartDevices
{
public:
	static CSmartDevices* getInstance();
	CSmartDevices();
	~CSmartDevices();

private:
	static CSmartDevices* mInstance;

public:
	/// Interface types (see smart devices table)
	enum TInterface
	{
	    ADC = 0,
	    I2C = 1,
	    W1 = 2,
	    IP = 3,
	    ZIGBEE = 4,
	    RELAY = 5
	};

	/// Device types (see smart devices table)
	enum TDevice
	{
	    ONBOARD_CO2_SENSOR = 0,
	    ONBOARD_CO_SENSOR = 1,
	    ONBOARD_TEMPERATURE_SENSOR = 2,
	    ONBOARD_HUMIDITY_SENSOR = 3,
	    GENERIC_TEMPERATURE = 4,
	    GENERIC_HUMIDITY = 5,
	    GENERIC_VELOCITY = 6,
	    GENERIC_ILLUMINATION = 7,
	    GENERIC_PRESSURE = 8,
	    FLOOD_SENSOR = 80,
	    HOT_WATER_TANK_ON_OFF_CONTROL = 81,
	    DAMPER_CONTROL = 82
	};

	static int insert(std::string address, int type);
	static int enumerateOneWireDev(Hal::TW1DevicesInfo& devicesHAL);
	static int retrieve1WDev(Hal::TW1DevicesInfo& devices);
	static int retrieve1WDevStatus(std::string address, CSmartDevices& cSmartDevices);
	static int retrieveHighThr(int id, CSmartDevices& cSmartDevices);
	static int retrieveLowThr(int id, CSmartDevices& cSmartDevices);
    static int retrieveThrs(int interface, int address, CSmartDevices& cSmartDevices);
	static int retrieveInt(int id, CSmartDevices& cSmartDevices);
	static int retrieveIntAddr(std::string address, CSmartDevices& cSmartDevices);
	static int retrieveIntInt(int interface, int address, CSmartDevices& cSmartDevices);
	static int retrieveStatus(int type, CSmartDevices& cSmartDevices);
	static int retrieveStatusInt(int interface, int address, CSmartDevices& cSmartDevices);
	static int retrieve(int id, CSmartDevices& cSmartDevices);
	static int removeOneWireDev();
	static int removeOneWireDevAddr(std::string address);
	static int disableOneWireDev();
	static int disableOneWireDevAddr(std::string address);
	static int update(std::string address, std::string updateAddr);
	
	int getInterface(){return mInterface;}
	int getInterval(){return mInterval;}
	int getHighThr(){return mHighThr;}
	int getLowThr(){return mLowThr;}
	int getType(){return mType;}
	int getStatus(){return mStatus;}
	std::string getAddress(){return mAddress.c_str();}

private:
	int mType;
	int mInterface;
	int mHighThr;
	int mLowThr;
	int mInterval;
	int mStatus;
	std::string mAddress;
};

#endif
