#ifndef _PENDING_ACTIONS_H
#define _PENDING_ACTIONS_H

class CPendingAction
{
public:
	static CPendingAction* getInstance();
	~CPendingAction();

	struct Action {
		int id;
		std::string table;
		int refId;
		int recordType; 
		  	//	0 = smart controller onboard hardware (relays, etc);
		  	//	1 = remote controller hardware (louvers, switches, etc);
		int priority;
	};
  
private:
	static CPendingAction* mInstance;
	CPendingAction();

	int mId;
	std::string mRefTable;
	int mRefId;
	int mType;
	int mPriority;

	

public:
	int retrieve(int id);
	int retrieve(std::vector<Action*>& actionList);
	
	int getId(){return mId;}
	std::string getRefTable(){return mRefTable.c_str();}
	int getRefId(){return mRefId;}
	int getType(){return mType;}
	int getPriority(){return mPriority;}

};

#endif