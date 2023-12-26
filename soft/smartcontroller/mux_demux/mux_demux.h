#ifndef FILE_MUX_DEMUX_MUX_DEMUX_H
#define FILE_MUX_DEMUX_MUX_DEMUX_H

#include <string>
#include "util/log/log.h"

int MuxDemuxInit(const ::std::string& user, const ::std::string& password,
        const ::std::string& database);
int MuxDemuxRun();

void LogInit(std::string logpath, std::string logfile);

#endif /* FILE_MUX_DEMUX_MUX_DEMUX_H */
