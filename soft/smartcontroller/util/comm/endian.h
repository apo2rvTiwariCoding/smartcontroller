#ifndef FILE_UTIL_COMM_ENDIAN_H
#define FILE_UTIL_COMM_ENDIAN_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <endian.h>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------


namespace Util
{
namespace Comm
{

/// Endianes
enum TEndian
{
    BIG,
    LITTLE
};

/// The converter(s)
template< typename T, TEndian endian >
struct TEndianConverter {};

template<>
struct TEndianConverter< ::std::int8_t, TEndian::BIG >
{
    typedef ::std::int8_t TValue;
    inline static TValue To(TValue value) { return value; }
    inline static TValue From(TValue value) { return value; }
};

template<>
struct TEndianConverter< ::std::uint8_t, TEndian::BIG >
{
    typedef ::std::uint8_t TValue;
    inline static TValue To(TValue value) { return value; }
    inline static TValue From(TValue value) { return value; }
};

template<>
struct TEndianConverter< ::std::uint8_t, TEndian::LITTLE >
{
    typedef ::std::uint8_t TValue;
    inline static TValue To(TValue value) { return value; }
    inline static TValue From(TValue value) { return value; }
};

template<>
struct TEndianConverter< ::std::int16_t, TEndian::BIG >
{
    typedef ::std::int16_t TValue;
    inline static TValue To(TValue value) { return htobe16(value); }
    inline static TValue From(TValue value) { return be16toh(value); }
};

template<>
struct TEndianConverter< ::std::int16_t, TEndian::LITTLE >
{
    typedef ::std::int16_t TValue;
    inline static TValue To(TValue value) { return htole16(value); }
    inline static TValue From(TValue value) { return le16toh(value); }
};

template<>
struct TEndianConverter< ::std::uint16_t, TEndian::BIG >
{
    typedef ::std::uint16_t TValue;
    inline static TValue To(TValue value) { return htobe16(value); }
    inline static TValue From(TValue value) { return be16toh(value); }
};

template<>
struct TEndianConverter< ::std::uint16_t, TEndian::LITTLE >
{
    typedef ::std::uint16_t TValue;
    inline static TValue To(TValue value) { return htole16(value); }
    inline static TValue From(TValue value) { return le16toh(value); }
};

template<>
struct TEndianConverter< ::std::int32_t, TEndian::BIG >
{
    typedef ::std::int32_t TValue;
    inline static TValue To(TValue value) { return htobe32(value); }
    inline static TValue From(TValue value) { return be32toh(value); }
};

template<>
struct TEndianConverter< ::std::int32_t, TEndian::LITTLE >
{
    typedef ::std::int32_t TValue;
    inline static TValue To(TValue value) { return htole32(value); }
    inline static TValue From(TValue value) { return le32toh(value); }
};

template<>
struct TEndianConverter< ::std::uint32_t, TEndian::BIG >
{
    typedef ::std::uint32_t TValue;
    inline static TValue To(TValue value) { return htobe32(value); }
    inline static TValue From(TValue value) { return be32toh(value); }
};

template<>
struct TEndianConverter< ::std::uint32_t, TEndian::LITTLE >
{
    typedef ::std::uint32_t TValue;
    inline static TValue To(TValue value) { return htole32(value); }
    inline static TValue From(TValue value) { return le32toh(value); }
};

template<>
struct TEndianConverter< ::std::int64_t, TEndian::BIG >
{
    typedef ::std::int64_t TValue;
    inline static TValue To(TValue value) { return htobe64(value); }
    inline static TValue From(TValue value) { return be64toh(value); }
};

template<>
struct TEndianConverter< ::std::int64_t, TEndian::LITTLE >
{
    typedef ::std::int64_t TValue;
    inline static TValue To(TValue value) { return htole64(value); }
    inline static TValue From(TValue value) { return le64toh(value); }
};

template<>
struct TEndianConverter< ::std::uint64_t, TEndian::BIG >
{
    typedef ::std::uint64_t TValue;
    inline static TValue To(TValue value) { return htobe64(value); }
    inline static TValue From(TValue value) { return be64toh(value); }
};

template<>
struct TEndianConverter< ::std::uint64_t, TEndian::LITTLE >
{
    typedef ::std::uint64_t TValue;
    inline static TValue To(TValue value) { return htole64(value); }
    inline static TValue From(TValue value) { return le64toh(value); }
};

/// \note Floats are treated like a 32-bit integers
template<>
struct TEndianConverter< float, TEndian::BIG >
{
    typedef float TValue;
    typedef TValue TFloat;
    typedef ::std::uint32_t TInteger;
    static_assert(sizeof(TValue) == sizeof(TInteger),
            "the sizes don't match");

    union TFloatInteger
    {
        TValue m_float;
        TInteger m_integer;
    };

    static TValue To(TValue value)
      {
          TFloatInteger tmp;
          tmp.m_float = value;
          tmp.m_integer = htobe32(tmp.m_integer);
          return tmp.m_float;
      }

    static TValue From(TValue value)
      {
          TFloatInteger tmp;
          tmp.m_float = value;
          tmp.m_integer = be32toh(tmp.m_integer);
          return tmp.m_float;
      }
}; // struct TEndianConverter< float >

/// \note Floats are treated like a 32-bit integers
template<>
struct TEndianConverter< float, TEndian::LITTLE >
{
    typedef float TValue;
    typedef TValue TFloat;
    typedef ::std::uint32_t TInteger;
    static_assert(sizeof(TValue) == sizeof(TInteger),
            "the sizes don't match");

    union TFloatInteger
    {
        TValue m_float;
        TInteger m_integer;
    };

    static TValue To(TValue value)
      {
          TFloatInteger tmp;
          tmp.m_float = value;
          tmp.m_integer = htole32(tmp.m_integer);
          return tmp.m_float;
      }

    static TValue From(TValue value)
      {
          TFloatInteger tmp;
          tmp.m_float = value;
          tmp.m_integer = le32toh(tmp.m_integer);
          return tmp.m_float;
      }
}; // struct TEndianConverter< float >

} // namespace Comm
} // namespace Util

#endif // #ifndef FILE_UTIL_COMM_ENDIAN_H
