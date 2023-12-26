#ifndef _SETTINGS_H
#define _SETTINGS_H

class CSettings
{
public:
	CSettings();
	~CSettings();
	
  
public:
	static int retrieve(CSettings& settings);

	int getValue(){return mValue;}

private:

	int mValue;
};

#endif