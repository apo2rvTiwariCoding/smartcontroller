// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <iostream>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "inc/version.h"
#include "mux_demux/mux_demux.h"


//-----------------------------------------------------------------------------
int main(int argc, char *argv[])
{
    // extern const pointer pointing const char
    // g_app_git_version is const pointer to const char.
    // neither pointer nor content can be changed.
    extern const char *const g_app_git_version;

    // global namespace std -> cout
    // ::std::cout , to avoid ambuiguity and to make sure explicitly referrring to "std" even if there are conflicting declarations in current scope.
    ::std::cout << APP_LONG_NAME " v" APP_STRING_VERSION
                   " (" << g_app_git_version << ")\n";

    // check if program arguments equal to 3 or not
    if(4 != argc)
    {
        // printing to standard error stream, which is unbuffered and will print immediately.
        ::std::cerr << "Wrong arguments passed.\n";
        return -1;
    }

    // calling MuxDemuxInit function with 3 arguments passed via main() fn.
    MuxDemuxInit(argv[1], argv[2], argv[3]);
    MuxDemuxRun();

    return 0;
}
