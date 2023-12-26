#ifndef FILE_HAL_ERRORS_H
#define FILE_HAL_ERRORS_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <string>
#include <exception>
#include <system_error>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "hal/hal.h"


namespace Hal
{

#ifdef DEBUG
#define THROW_EXCEPTION(x) \
    TException::Throw(x, __PRETTY_FUNCTION__, __FILE__, __LINE__)
#else
#define THROW_EXCEPTION(x) \
    TException::Throw(x)
#endif


/**
 * @brief The module base exception.
 */
class TException : public ::std::exception
{
protected:
    TException(TErrorCode error) noexcept : m_error(error) {}

#ifdef DEBUG

public:
    template< class T >
    inline static void Throw(T&& e, const char* function_name,
        const char* file_name, int line_number)
      {
          e.m_debug_info.Set(function_name, file_name, line_number);
          throw e;
      }

private:
    struct TDebugInfo
    {
        TDebugInfo() noexcept
            : m_function_name(nullptr),
              m_file_name(nullptr)
          {}

        void Set(const char* function_name,
            const char* file_name, int line_number) noexcept;

        const char* m_function_name;
        const char* m_file_name;
        int m_line_number;
    }; // struct TDebugInfo
    TDebugInfo m_debug_info;

#else

public:
    template< class T >
    inline static void Throw(T&& e)
      {
          throw e;
      }

#endif

public:
    const TErrorCode m_error; ///< HAL error code

    ::std::string ToString() const;
    virtual const char* what() const noexcept { return "base exception"; }

protected:
    virtual void OnGetDescription(::std::ostream& out) const;
}; // struct TException

/// Errors reported by the system.
struct TSystemError : TException
{
    explicit TSystemError(int error_number)
        : TException(EC_SYSTEM),
          m_error(error_number, ::std::system_category())
      {}

    virtual const char* what() const noexcept { return "system error"; }

    ::std::error_code m_error; ///< System error code

protected:
    virtual void OnGetDescription(::std::ostream& out) const;
};

/// Invalid (unexpected) response
struct TInvalidResponseError : TException
{
    TInvalidResponseError()
        : TException(EC_INVALID_RESPONSE)
      {}

    virtual const char* what() const noexcept { return "invalid response"; }
};

/// Data is corrupt
struct TCorruptDataError : TException
{
    TCorruptDataError()
        : TException(EC_CORRUPT_DATA)
      {}

    virtual const char* what() const noexcept { return "corrupt data"; }
};

/// Invalid argument error
struct TInvalidArgumentError : TException
{
    TInvalidArgumentError(const ::std::string& name)
        : TException(EC_INVALID_ARGUMENT)
      {}

    virtual ~TInvalidArgumentError() noexcept {}


    const ::std::string m_name;

    virtual const char* what() const noexcept { return "invalid argument"; }

protected:
    virtual void OnGetDescription(::std::ostream& out) const;
};

/// Resource not available
struct TResourceNotAvailableError : TException
{
    TResourceNotAvailableError()
        : TException(EC_RESOURCE_NOT_AVAILABLE)
      {}

    virtual const char* what() const noexcept { return "resource not available"; }
};

} // namespace Hal

#endif // #ifndef FILE_HAL_ERRORS_H
