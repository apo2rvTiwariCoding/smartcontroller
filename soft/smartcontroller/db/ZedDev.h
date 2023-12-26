#ifndef _ZED_DEVICE_H
#define _ZED_DEVICE_H

class CZedDev
{
public:
	CZedDev();
	~CZedDev();
	
  
public:
	static int retrieve(int id, CZedDev& zegDev);		

	int getStatus(){return mOnline;}
	std::string getAddr(){return mAddr64.c_str();}

private:
	int mOnline;
	std::string mAddr64;
};

#endif