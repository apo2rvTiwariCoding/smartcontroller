#include <string.h>
#include "Database.h"
#include "PendingAction.h"
#include "util/log/log.h"

CPendingAction* CPendingAction::mInstance = NULL;
CPendingAction::CPendingAction()
{
}

CPendingAction::~CPendingAction()
{
}

CPendingAction* CPendingAction::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CPendingAction();
	}
	return mInstance;
}

int CPendingAction::retrieve(std::vector<Action*>& actionList)
{
	int recCount =0;
	char query[1000];

	CDatabase* pdb = CDatabase::getInstance();
	if(pdb !=NULL)
	{
		VRECORD record;
		sprintf(query, "SELECT id, ref_table, ref_id, type_, priority FROM actions ORDER BY priority, id");
 		int result = pdb->query(query, record);
		if(result == DB_FAIL) 
		{
			LOG_ERROR("database", "Query Not executed");
		}
		else
		{
			recCount = record.size();

			for(unsigned int i=0;i<record.size();i++)
			{
				VROW row = record[i];
                Action* action = new Action();
				if(action!=NULL)
				{
					action->id = atoi(row[0].c_str());
					action->table = row[1];
					action->refId = atoi(row[2].c_str());
					action->recordType = atoi(row[3].c_str());
					action->priority = atoi(row[4].c_str());
				}
				actionList.push_back(action);
			}
		}
	}
	else
	{
		LOG_ERROR("database", "CDatabase returned a NULL pointer");
	}

	return recCount;
}