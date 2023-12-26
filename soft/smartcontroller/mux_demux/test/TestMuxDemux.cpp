#include <iostream>
#include "mux_demux/mux_demux.h"
#include "util/log/log.h"
#include "mux_demux/test/testZC.h"

int main(int argc, char *argv[])
{
	CLog * cLog = CLog::getInstance();
	cLog->loginit("../../../log/logs.properties");
    if(4 == argc)
    {
        MuxDemuxInit(argv[1], argv[2], argv[3]);
		int ret = 1; //ZCInit();
        if(ret)
		{
			LOG_INFO_FMT("server", "ZC is not initialized, Return Code = %d", ret);
		}
		MuxDemuxRun();
		LOG_INFO("server", "MuxDemux initialized and Running");
    }
    else
    {
        ::std::cerr << "Wrong arguments passed.\n";
		LOG_ERROR("server", "Wrong arguments passed.");
    }
}
