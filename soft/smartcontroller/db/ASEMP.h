#ifndef _ASEMP_H
#define _ASEMP_H

class CASEMP
{
public:
	CASEMP();
	~CASEMP();
	
  
public:
	static int retrieve(int asemp, CASEMP& casemp);

	std::string getParameter(){return mParameter.c_str();}
	int getValue(){return mValue;}
	int getProfileValues(int loc){return mValues[loc];}

private:
	static CASEMP* mInstance;

	int mValues[20];
	int mId;
	int mProfileId;
	std::string mParameter;
	int mValue;
	int mDefault;
	std::string mDescription;
  	int mType; 
	std::string mUnits;
};

#endif