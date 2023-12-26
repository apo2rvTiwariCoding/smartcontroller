// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <array>
#include <cstdio>
#include <fstream>
#include <sstream>
#include <cstring>
#include <fcntl.h>
#include <cassert>
#include <iostream>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/dev/details/gpio.h"
#include "hal/errors.h"


namespace Hal
{
namespace Dev
{
namespace Details
{

//-----------------------------------------------------------------------------
TGpio::TGpio(unsigned num, TEdge edge)
    : m_fd(INVALID_FD),
      m_root_name(GetRootName(num))
{
    {
        ::std::ofstream file("/sys/class/gpio/export");
        if (file.fail())
        {
            // Not perfect but at least the error is reported.
            THROW_EXCEPTION(TSystemError(errno));
        }
        file << num << '\n';
    }

    Edge(edge);

    m_fd = ::open((m_root_name + "value").c_str(), O_RDONLY | O_NONBLOCK);
    if (INVALID_FD == m_fd)
    {
        THROW_EXCEPTION(TSystemError(errno));
    }
}

//-----------------------------------------------------------------------------
TGpio::~TGpio()
{
    ::close(m_fd);
}

//-----------------------------------------------------------------------------
void TGpio::Edge(TEdge edge)
{
    static const ::std::array< const char*, TEdge::BOTH + 1 > str =
    {{
        "none",    // TEdge::NONE
        "falling", // TEdge::FALLING
        "rising",  // TEdge::RISING
        "both"     // TEdge::BOTH
    }};
    assert(edge < str.size());

    ::std::ofstream file(m_root_name + "edge");
    if (file.fail())
    {
        // Not perfect but at least the error is reported.
        THROW_EXCEPTION(TSystemError(errno));
    }
    file << str[edge] << '\n';
}

//-----------------------------------------------------------------------------
bool TGpio::Value() const
{
    unsigned value;
    char buffer[16];
    ::read(m_fd, buffer, sizeof(buffer));
    ::std::sscanf(buffer, "%u", &value);
    return value;
}

//-----------------------------------------------------------------------------
void TGpio::Value(bool value)
{
    char buffer[16];
    const int count = ::std::snprintf(buffer, sizeof(buffer), "%u\n", value);
    ::write(m_fd, buffer, count);
}

//-----------------------------------------------------------------------------
::std::string TGpio::GetRootName(unsigned num)
{
    ::std::ostringstream tmp;
    tmp << "/sys/class/gpio/gpio" << num << '/';
    return ::std::move(tmp.str());
}

} // namespace Details
} // namespace Dev
} // namespace Hal
