#include "Database.h"
#include "Diagnostics.h"

CDiagnostics* CDiagnostics::mInstance = NULL;
CDiagnostics::CDiagnostics()
{
}

CDiagnostics::~CDiagnostics()
{
}

CDiagnostics* CDiagnostics::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CDiagnostics();
	}
	return mInstance;
}

int CDiagnostics::insert(int type, std::string desc)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO diagnostics(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("event)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%s\')");

	sprintf(query,str.c_str(), type, desc.c_str());
   
	return CDatabase::getInstance()->execute(query);
}