#ifndef _HVAC_H
#define _HVAC_H

class CHVAC
{
public:
	CHVAC();
	~CHVAC();
	
  
public:
	static int retrieve(CHVAC& hvac);		//int id deleted from parameter, maybe needed later

	int getW1(){return W1;}
	int getW2(){return W2;}
	int getY1(){return Y1;}
	int getY2(){return Y2;}
	int getG(){return G;}
	int getOB(){return OB;}
	int getAux(){return Aux;}
	int getRcRh(){return RcRh;}

private:
	int mId;
	std::string mUpdated;
  	int W1; 
	int W2;
	int Y1;
	int Y2;
	int G;
	int OB;
	int Aux;
	int RcRh;
};

#endif