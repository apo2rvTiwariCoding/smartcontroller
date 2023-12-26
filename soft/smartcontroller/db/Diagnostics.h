#ifndef _DIAGNOSTICS_H
#define _DIAGNOSTICS_H

class CDiagnostics
{
public:
	static CDiagnostics* getInstance();
	~CDiagnostics();
	
  
public:
	static int insert(int type, std::string desc);

private:
	static CDiagnostics* mInstance;
	CDiagnostics();

	int mId;
	std::string mUpdated;
  	int mType; 
	std::string mEvent;
};

#endif