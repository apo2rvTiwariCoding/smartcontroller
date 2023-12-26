#ifndef FILE_UTIL_COMM_BUFFER_H
#define FILE_UTIL_COMM_BUFFER_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <array>
#include <cstring>
#include <cstdint>
#include <cassert>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------
#include "util/comm/endian.h"


namespace Util
{
namespace Comm
{

/**
 * @brief A simple IO fixed size buffer for I2C comm.
 */
template< class T >
class TBufferBasic
{
public:
    typedef T TUnderlying;

    template< typename... Args >
    TBufferBasic(Args&&... args)
        : m_content(args...)
      {
          Reset();
      }


    inline TUnderlying& Underlying() noexcept { return m_content; }
    inline const TUnderlying& Underlying() const noexcept { return m_content; }

    inline ::std::size_t Capacity() const noexcept { return m_content.capacity(); }

    inline ::std::size_t Index() const noexcept { return m_index; }
    inline void Index(::std::size_t index) noexcept { m_index = index; }

    void Reset()
      {
          m_index = 0;
          m_overflow = false;
      }

    inline bool Overflow() const noexcept { return m_overflow; }


    /// Direct data access.
    inline const ::std::uint8_t* Data() const noexcept { return m_content.data(); }
    /// Direct data access.
    inline ::std::uint8_t* Data() noexcept { return m_content.data(); }


    static const TEndian DEFAULT_ENDIAN = TEndian::BIG;

    /**
     * @brief It pushes a value into the buffer at the index position.
     *        The index gets incremented.
     */
    template< typename T1, TEndian Endian = DEFAULT_ENDIAN >
    void PushAs(T1 value)
      {
          if (m_index + sizeof(value) <= m_content.capacity())
          {
              value = TEndianConverter< T1, Endian >::To(value);
              ::std::memcpy(&m_content[m_index], &value, sizeof(value));
              m_index += sizeof(value);
          }
          else
          {
              m_overflow = true;
          }
      }

    /**
     * @brief It takes a value from the buffer at the index position.
     *        The index gets incremented.
     */
    template< typename T1, TEndian Endian = DEFAULT_ENDIAN >
    T1 PopAs()
      {
          T1 ret;
          if (m_index + sizeof(ret) <= m_content.capacity())
          {
              ::std::memcpy(&ret, &m_content[m_index], sizeof(ret));
              m_index += sizeof(ret);
              ret = TEndianConverter< T1, Endian >::From(ret);
          }
          else
          {
              m_overflow = true;
          }
          return ret;
      }

private:
    TUnderlying m_content;

    ::std::size_t m_index;
    bool m_overflow;
}; // class TBufferBasic

namespace Details
{

// C++ array
template< ::std::size_t N >
struct TArray : ::std::array< ::std::uint8_t, N >
{
    inline static ::std::size_t capacity() noexcept { return N; }
}; // struct TArray

// C array
struct TCArray
{
    TCArray(void* data, ::std::size_t capacity)
        : m_data(static_cast< ::std::uint8_t* >(data)),
          m_capacity(capacity)
      {}

    inline ::std::size_t capacity() const noexcept { return m_capacity; }
    inline ::std::uint8_t* data() noexcept { return m_data; }
    inline const ::std::uint8_t* data() const noexcept { return m_data; }
    inline ::std::uint8_t& operator[](::std::size_t idx) noexcept
      {
          assert(idx < m_capacity);
          return m_data[idx];
      }
    inline const ::std::uint8_t& operator[](::std::size_t idx) const noexcept
      {
          assert(idx < m_capacity);
          return m_data[idx];
      }

    ::std::uint8_t *const m_data;
    const ::std::size_t m_capacity;
}; // struct TCArray

// Constant C array
struct TConstCArray
{
    TConstCArray(const void* data, ::std::size_t capacity)
        : m_data(static_cast< const ::std::uint8_t* >(data)),
          m_capacity(capacity)
      {}

    inline ::std::size_t capacity() const noexcept { return m_capacity; }
    inline const ::std::uint8_t* data() const noexcept { return m_data; }
    inline const ::std::uint8_t& operator[](::std::size_t idx) const noexcept
      {
          assert(idx < m_capacity);
          return m_data[idx];
      }

    const ::std::uint8_t *const m_data;
    const ::std::size_t m_capacity;
}; // struct TConstCArray

} // namespace Details

/// C++ fixed size array
template< ::std::size_t N >
class TBuffer : public TBufferBasic< Details::TArray< N > > {};
/// C fixed size array (external storage)
typedef TBufferBasic< Details::TCArray > TCBuffer;
/// C fixed size array (constant external storage)
typedef TBufferBasic< Details::TConstCArray > TConstCBuffer;

} // namespace Comm
} // namespace Util

#endif // #ifndef FILE_UTIL_COMM_BUFFER_H
