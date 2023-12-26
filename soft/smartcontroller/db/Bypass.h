#ifndef _BYPASS
#define _BYPASS

class CBypass
{
public:
	static CBypass* getInstance();
	~CBypass();
	
  
public:
	static int insert(int type, int status);


private:
	static CBypass* mInstance;
	CBypass();

	int mId;
	std::string mUpdated;
  	int mType; 
	int mStatus;
	int mDescription;
};

#endif
