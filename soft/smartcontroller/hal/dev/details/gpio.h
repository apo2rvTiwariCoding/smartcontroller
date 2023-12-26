#ifndef FILE_HAL_DEV_DETAILS_GPIO_H
#define FILE_HAL_DEV_DETAILS_GPIO_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------
#include <memory>
#include <string>

// PROJECT INCLUDES
//-----------------------------------------------------------------------------


namespace Hal
{
namespace Dev
{
namespace Details
{

/**
 * @brief GPIO wrapper under Linux sys file system.
 */
class TGpio
{
public:
    typedef ::std::unique_ptr< TGpio > TUPtr;

    /// The interrupt edges 
    enum TEdge
    {
        NONE = 0,
        FALLING,
        RISING,
        BOTH
    };

    TGpio(unsigned num, TEdge edge = TEdge::NONE);
    ~TGpio();

    inline int Get() const noexcept { return m_fd; }    


    /**
     * @brief It sets the iterrupt edge.
     */
    void Edge(TEdge edge);

    /**
     * @brief It gets the IO value.
     */
    bool Value() const;

    /**
     * @brief It gets the IO value.
     */
    void Value(bool value);

private:
    static const int INVALID_FD = -1;
    int m_fd; //< The 'value' file.

    const ::std::string m_root_name; ///< The gpio file names root
    static ::std::string GetRootName(unsigned num);
}; // class TGpio

} // namespace Details
} // namespace Dev
} // namespace Hal

#endif // #ifndef FILE_HAL_DEV_DETAILS_GPIO_H