#ifndef _THERMOSTAT_H
#define _THERMOSTAT_H

class CThermostat
{
public:
	static CThermostat* getInstance();
	~CThermostat();	
  
public:
	static int insert(int w1, int w2, int y1, int y2, int g, int ob);
	static int insertY1(int y1);
	static int insertY2(int y2);
	static int insertW1(int w1);
	static int insertW2(int w2);
	static int insertOB(int ob);
	static int insertG(int g);
	static int insertRc(int rc);
	static int insertRh(int rh);
	static int insertAux(int aux);
	static int insertHum(int hum);

private:
	static CThermostat* mInstance;
	CThermostat();

	int mId;
	std::string mUpdated;
  	int W1; 
	int W2;
	int Y1;
	int Y2;
	int G;
	int OB;
	int Rc;
	int Rh;
	int Aux;
	int Hum;
	float mAvgT;
};

#endif