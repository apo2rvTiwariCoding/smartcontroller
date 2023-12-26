// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <array>
#include <memory>
#include <cassert>
#include <iostream>
#include <pthread.h>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "util/timer.h"
#include "util/comm/buffer.h"


using namespace Util;

static volatile int s_counter;

//----------------------------------------------------------------------------
static void OnTimer(int id)
{
    //::std::cout << "on timer: " << id << ", " << ::pthread_self() << '\n';
    s_counter++;
}

//----------------------------------------------------------------------------
int main(int argc, char *argv[])
{
#if 0 // timers
    {
        typedef ::std::unique_ptr< TTimer > TTimerPtr;
        ::std::array< TTimerPtr, 100 > timers;
        for(::std::size_t i = 0; i < timers.size(); i++)
        {
            timers[i].reset(new TTimer([i]()->void { OnTimer(i); } ));
            timers[i]->StartRepeat(0, 0, 1);
        }

        ::sleep(2);
    }
    ::sleep(1);
    // At this point all the timers should be stopped and destroyed.

    assert(s_counter >= 100);
    //::std::cout << "main: " << s_counter << '\n';
    
    const int counter = s_counter;
    ::sleep(1);
    //::std::cout << "main: " << s_counter << '\n';
    assert(counter == s_counter);    
#endif

#if 1 // buffer
    {
        const char storage[] = "\x65\x5\x2";
        Comm::TConstCBuffer buffer(storage, sizeof(storage));
        for(unsigned i = 0; i < sizeof(storage); i++)
        {
            const int x = buffer.PopAs< ::std::uint8_t >();
            ::std::cout << ::std::hex << x << ::std::dec << '\n';
        }
    }

    {
        char storage[10];
        Comm::TCBuffer buffer(storage, sizeof(storage));

        buffer.PushAs< ::std::uint16_t >(2);
        buffer.Reset();
        const int i = buffer.PopAs< ::std::uint16_t >();
        ::std::cout << i << '\n';
    }
#endif
    return 0;
}
