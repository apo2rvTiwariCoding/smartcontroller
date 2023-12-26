#ifndef _HUMIDIFIER_H
#define _HUMIDIFIER_H

class CHumidifier
{
public:
	CHumidifier();
	~CHumidifier();
	
  
public:
	static int retrieve(CHumidifier& humidifier); 

	int getHumidifier(){return mHumidifier;}

private:
	int mId;
	std::string mUpdated;
  	int mHumidifier; 
};

#endif