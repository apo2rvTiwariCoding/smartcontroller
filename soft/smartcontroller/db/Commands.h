#ifndef _COMMANDS_MD_H
#define _COMMANDS_MD_H

class CCommands
{
public:
    enum TType
    {
        LOUVER_POSITION_CHANGE = 0x00,
        AC_DEVICE_ENABLE = 0x01,
        AC_DEVICE_DISABLE = 0x02,
        DIMMER_CONTROL = 0x03,
        MODIFY_REPORT_INTERVAL = 0x04,
        TRANSMIT_UNSOLICITED_INFO = 0x05,
        LED_ALARM_ENABLE = 0x06,
        LED_ALARM_DISABLE = 0x07,
        AUDIBLE_ALARM_ENABLE = 0x08,
        AUDIBLE_ALARM_DISABLE = 0x09,
        RELAY_SET = 0x0A,
        RELAY_RESET = 0x0B,
        IR_TX_CMD = 0x0C,
        PROFILE = 0xFF,
        ACK = 0xFE
    };

	CCommands();
	~CCommands();

	static int retrieve(int id, CCommands& command);

    int getId() {return mId;}
    std::string getUpdated() {return mUpdated;}
    int getCommand() {return mCommand;}
    int getPriority() {return mPriority;}
    int getFlags() {return mFlags;}
    int getDeviceId() {return mDeviceId;}
    TType getType() {return mType;}
    std::string getParameters() {return mParameter;}

private:
    int mId;
    std::string mUpdated;
    int mCommand;
    int mPriority;
    int mFlags;
    int mDeviceId;
    TType mType;
    std::string mParameter;
};


#endif