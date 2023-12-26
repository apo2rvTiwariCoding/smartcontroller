#include "Database.h"
#include "Thermostat.h"

CThermostat* CThermostat::mInstance = NULL;
CThermostat::CThermostat()
{
}

CThermostat::~CThermostat()
{
}

CThermostat* CThermostat::getInstance()
{
	if(mInstance == NULL)
	{
		mInstance = new CThermostat();
	}
	return mInstance;
}

int CThermostat::insert(int w1, int w2, int y1, int y2, int g, int ob)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO thermostat(");
	str.append("id,");
	str.append("updated,");
	str.append("W1,");
	str.append("W2,");
	str.append("Y1,");
	str.append("Y2,");
	str.append("G,");
	str.append("OB)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\',");
	str.append("\'%d\')");

	sprintf(query,str.c_str(), w1, w2, y1, y2, g, ob);
  
	return CDatabase::getInstance()->execute(query);
}

int CThermostat::insertY1(int y1)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO thermostat(");
	str.append("id,");
	str.append("updated,");
	str.append("Y1)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), y1);
   
	return CDatabase::getInstance()->execute(query);
}

int CThermostat::insertY2(int y2)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO thermostat(");
	str.append("id,");
	str.append("updated,");
	str.append("Y2)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), y2);
   
	return CDatabase::getInstance()->execute(query);
}

int CThermostat::insertW1(int w1)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO thermostat(");
	str.append("id,");
	str.append("updated,");
	str.append("W1)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), w1);
   
	return CDatabase::getInstance()->execute(query);
}

int CThermostat::insertW2(int w2)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO thermostat(");
	str.append("id,");
	str.append("updated,");
	str.append("W2)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), w2);
   
	return CDatabase::getInstance()->execute(query);
}

int CThermostat::insertOB(int ob)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO thermostat(");
	str.append("id,");
	str.append("updated,");
	str.append("OB)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), ob);
   
	return CDatabase::getInstance()->execute(query);
}

int CThermostat::insertG(int g)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO thermostat(");
	str.append("id,");
	str.append("updated,");
	str.append("G)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), g);
   
	return CDatabase::getInstance()->execute(query);
}

int CThermostat::insertRc(int rc)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO thermostat(");
	str.append("id,");
	str.append("updated,");
	str.append("Rc)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), rc);
   
	return CDatabase::getInstance()->execute(query);
}

int CThermostat::insertAux(int aux)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO thermostat(");
	str.append("id,");
	str.append("updated,");
	str.append("Aux)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), aux);
   
	return CDatabase::getInstance()->execute(query);
}

int CThermostat::insertRh(int rh)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO thermostat(");
	str.append("id,");
	str.append("updated,");
	str.append("Rh)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), rh);
   
	return CDatabase::getInstance()->execute(query);
}

int CThermostat::insertHum(int hum)
{
	char query[1000];

	std::string str;
	str.append("INSERT INTO thermostat(");
	str.append("id,");
	str.append("updated,");
	str.append("Hum)");
	str.append(" VALUES (");

	str.append("NULL,");
	str.append("NOW(),");
	str.append("\'%d\')");


	sprintf(query,str.c_str(), hum);
   
	return CDatabase::getInstance()->execute(query);
}
