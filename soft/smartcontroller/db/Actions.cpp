#include "Database.h"
#include "Actions.h"

CActions::CActions(void)
{
}	

CActions::~CActions(void)
{
}

int CActions::remove(int id)
{
	char query[255];
	sprintf(query,"DELETE FROM actions WHERE id=\'%d\'",id);
	printf(query);
	printf("\n");
	return CDatabase::getInstance()->execute(query);
}

