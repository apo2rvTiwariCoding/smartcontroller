// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <sstream>
#include <cassert>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/errors.h"


namespace Hal
{

//-----------------------------------------------------------------------------
void TException::TDebugInfo::Set(const char* function_name,
                                 const char* file_name, int line_number) noexcept
{
    m_function_name = function_name;
    m_file_name = file_name;
    m_line_number = line_number;
}

//-----------------------------------------------------------------------------
::std::string TException::ToString() const
{
    ::std::ostringstream tmp;
    tmp << "[exception]: " << what() << '\n';
    OnGetDescription(tmp);
    return ::std::move(tmp.str());
}

//-----------------------------------------------------------------------------
void TException::OnGetDescription(::std::ostream& out) const
{
#ifdef DEBUG
    if (m_debug_info.m_function_name && m_debug_info.m_file_name)
    {
        out << "[function]: " << m_debug_info.m_function_name << '\n'
            << "[file]: " << m_debug_info.m_file_name
            << " (" << m_debug_info.m_line_number << ")\n";
    }
    else
    {
        out << "No debug information. Use THROW_EXCEPTION\n";
    }
#endif
}

//-----------------------------------------------------------------------------
void TSystemError::OnGetDescription(::std::ostream& out) const
{
    TException::OnGetDescription(out);
    out << "[error]: " << m_error.value() << ", ("
        <<  m_error.message() << ")\n";
}

//-----------------------------------------------------------------------------
void TInvalidArgumentError::OnGetDescription(::std::ostream& out) const
{
    TException::OnGetDescription(out);
    out << "[name]: " << m_name << '\n';
}

} // namespace Hal
