
#CC=/home/sitesync/Desktop/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc 
CC=gcc 
#LIB=/media/sf_SafetyLink/Z-Stack_Linux_Gateway-1.0.1-src/Source/protobuf-c-arm/lib 
LIB=/home/pi/Z-Stack_Linux_Gateway-1.0.1-src/Source/protobuf-c-arm/lib 
#LIB=/usr/lib
target:
	$(CC) main.c -rdynamic -o zigbee.bin -I../ -L$(LIB) -L./ -lprotobuf-c -lpthread -lzigbee

