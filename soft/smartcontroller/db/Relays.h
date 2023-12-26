#ifndef _RELAYS_H
#define _RELAYS_H

class CRelays
{
public:
	CRelays();
	~CRelays();
	
  
public:
	static int retrieve(CRelays& relays);		//int id deleted from parameter, maybe needed later

	int getR1(){return R1;}
	int getR2(){return R2;}
	int getR3(){return R3;}
	int getR4(){return R4;}
	int getR5(){return R5;}
	int getR6(){return R6;}

private:

	int mId;
	std::string mUpdated;
  	int R1; 
	int R2;
	int R3;
	int R4;
	int R5;
	int R6;
};

#endif