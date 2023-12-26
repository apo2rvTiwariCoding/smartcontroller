#include <sstream>
#include "Database.h"
#include "Bypass.h"

CBypass* CBypass::mInstance = NULL;
CBypass::CBypass()
{
}

CBypass::~CBypass()
{
}

CBypass* CBypass::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CBypass();
	}
	return mInstance;
}

int CBypass::insert(int type, int status)
{
	char query[1000];

	std::string str;

	str.append("INSERT INTO bypass(");
	str.append("id,");
	str.append("updated,");
	str.append("type_,");
	str.append("status)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\')");

	sprintf(query,str.c_str(), type, status);
   
	return CDatabase::getInstance()->execute(query);
}