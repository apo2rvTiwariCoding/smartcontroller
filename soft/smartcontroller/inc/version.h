#ifndef FILE_INC_VERSION_H
#define FILE_INC_VERSION_H

// SYSTEM INCLUDES
//-----------------------------------------------------------------------------

// PROJECT INCLUDES
//-----------------------------------------------------------------------------


#define APP_SHORT_NAME "SC"
#define APP_LONG_NAME "SmartController"

/**
 * Z.YY.MM.DDX
 *
 * where Z is release flag. 0 means code/app is in development (beta, alpha,
 * pre-release) state. 1 means this is release, ready for deployment.
 * YY is short year. example is 14.
 * MM is short month. examples are : 11, 7, 3.
 * DD is short day. examples are : 31, 22, 5.
 * X is am/pm time suffix.
 *
 * date and time based on GMT+0 (UTC) timezone. so let's call it
 * "timestamp version".
 *
 * examples of version numbers :
 * 1.14.11.26p         - means release created at 26 Nov 2014 PM (GMT+0);
 * 0.14.11.28a         - means beta (or other non-released) version
 * created at 28 November 2014 AM (by GMT+0)
 */
#define APP_STRING_VERSION "0.14.12.05p"

#endif // #ifndef FILE_INC_VERSION_H
