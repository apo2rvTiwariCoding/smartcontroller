#ifndef FILE_UTIL_TIMER_H
#define FILE_UTIL_TIMER_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <time.h>
#include <signal.h>
#include <functional>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------


namespace Util
{

/**
 * @brief A simple system (POSIX) timer wrapper.
 * @note The callback function is called from different thread contexts.
 * @note The class does not report any system error. In the case of error,
 *       the timer simply wont work :-).
 */
class TTimer
{
public:
    typedef ::std::function< void() > TCallback;

    TTimer(const TCallback& callback);
    ~TTimer() noexcept;


    void Start(int timeMs) noexcept;
    void StartRepeat(int hours, int mins, int seconds) noexcept; 
    void Stop() noexcept;

private:        
    const TCallback m_callback;

    ::timer_t m_id;
    /// The method is invoked from different thread context
    static void Handler(::sigval sigval);
}; // class TTimer

} // namespace Util

#endif // #ifndef FILE_UTIL_TIMER_H
