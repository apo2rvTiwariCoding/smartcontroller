#ifndef _ZONE_H
#define _ZONE_H

class CZone
{
public:
	CZone();
	~CZone();
	
  
public:
	static int retrieve(int zoneId,CZone& zone);

	int getOcupation(){return mOccupation;}

private:
	int mZoneId;
	int mOccupation;
	int mState;
	int mTimerOn;
	int mTimerOff;
  	int mPriority; 
};

#endif