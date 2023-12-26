#ifndef LOG_H
#define LOG_H
#include <string>
#include <cstdarg>

class CLog
{
public:
	static CLog *getInstance();
	static void deleteInstance();
	void configure();
	void setProperty(::std::string key, ::std::string value);
	::std::string getProperty(::std::string key);
	int trace(::std::string section, int line, const ::std::string& file, const ::std::string& fmt, ...);
	int debug(::std::string section, int line, const ::std::string& file, const ::std::string& fmt, ...);
	int info(::std::string section, int line, const ::std::string& file, const ::std::string& fmt, ...);
	int warn(::std::string section, int line, const ::std::string& file, const ::std::string& fmt, ...);
	int error(::std::string section, int line, const ::std::string& file, const ::std::string& fmt, ...);
	int fatal(::std::string section, int line, const ::std::string& file, const ::std::string& fmt, ...);

private:
	CLog();
	static CLog* mLog;
	int log(int logType, ::std::string section,  const int line, ::std::string file, const ::std::string& fmt, va_list args);
};


#ifdef LOG_ENABLED

# define LOG_GENERIC(level, section, msg) \
    do { \
        ::CLog::getInstance()->level(section,__LINE__,__FILE__,msg); \
    } while(0)

# define LOG_GENERIC_FMT(level, section, fmt, ...) \
    do { \
        ::CLog::getInstance()->level(section,__LINE__,__FILE__,fmt, __VA_ARGS__); \
    } while(0)

#else

# define LOG_GENERIC(level, section, msg)
# define LOG_GENERIC_FMT(level, section, fmt, ...)

#endif


#define LOG_TRACE(section, msg) LOG_GENERIC(trace, section, msg)
#define LOG_DEBUG(section, msg) LOG_GENERIC(debug, section, msg)
#define LOG_INFO(section, msg) LOG_GENERIC(info, section, msg)
#define LOG_WARN(section, msg) LOG_GENERIC(warn, section, msg)
#define LOG_ERROR(section, msg) LOG_GENERIC(error, section, msg)
#define LOG_FATAL(section, msg) LOG_GENERIC(fatal, section, msg)

#define LOG_TRACE_FMT(section, fmt, ...) LOG_GENERIC_FMT(trace, section, fmt, __VA_ARGS__)
#define LOG_DEBUG_FMT(section, fmt, ...) LOG_GENERIC_FMT(debug, section, fmt, __VA_ARGS__)
#define LOG_INFO_FMT(section, fmt, ...) LOG_GENERIC_FMT(info, section, fmt, __VA_ARGS__)
#define LOG_WARN_FMT(section, fmt, ...) LOG_GENERIC_FMT(warn, section, fmt, __VA_ARGS__)
#define LOG_ERROR_FMT(section, fmt, ...) LOG_GENERIC_FMT(error, section, fmt, __VA_ARGS__)
#define LOG_FATAL_FMT(section, fmt, ...) LOG_GENERIC_FMT(fatal, section, fmt, __VA_ARGS__)

#endif

