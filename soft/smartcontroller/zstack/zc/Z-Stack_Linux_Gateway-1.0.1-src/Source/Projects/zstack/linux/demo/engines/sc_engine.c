/*******************************************************************************
 Filename:       sc_engine.c
 Revised:        $Date$
 Revision:       $Revision$

 Description:    Device List Engine manages updating the list of devices in the network.


 Copyright 2013 Texas Instruments Incorporated. All rights reserved.

 IMPORTANT: Your use of this Software is limited to those specific rights
 granted under the terms of a software license agreement between the user
 who downloaded the software, his/her employer (which must be your employer)
 and Texas Instruments Incorporated (the "License").  You may not use this
 Software unless you agree to abide by the terms of the License. The License
 limits your use, and you acknowledge, that the Software may not be modified,
 copied or distributed unless used solely and exclusively in conjunction with
 a Texas Instruments radio frequency device, which is integrated into
 your product.  Other than for the foregoing purpose, you may not use,
 reproduce, copy, prepare derivative works of, modify, distribute, perform,
 display or sell this Software and/or its documentation for any purpose.

 YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
 PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,l
 INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE,
 NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
 TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
 NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
 LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
 INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
 OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
 OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
 (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

 Should you have any questions regarding your right to use this Software,
 contact Texas Instruments Incorporated at www.TI.com.
*******************************************************************************/

/******************************************************************************
 * Include
 *****************************************************************************/

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include "data_structures.h"
#include "socket_interface.h"
#include "device_list_engine.h"
#include "nwkmgr.pb-c.h"
#include "user_interface.h" 

/******************************************************************************
 * Constants
 *****************************************************************************/


/******************************************************************************
 * Global Variables
 *****************************************************************************/


/******************************************************************************
 * Function Prototypes
 *****************************************************************************/
static void sc_print_log(char * format, ...);

/******************************************************************************
 * Function
 *****************************************************************************/

static FILE *logfile = NULL;

static int openLogFile(char *log_filename)
{
   if(logfile != NULL) return 1;

        if (log_filename != NULL)
        {
                logfile = fopen(log_filename, "a");

                if (logfile == NULL)
                {
                        fprintf(stderr, "ERROR could not open the output log file\n");

                        return -1;
                }
        }

        return 1;
}


int displayDeviceInfo(device_info_t *devinfo)
{
   int rc = 1;

   openLogFile("sclog.txt");

   sc_print_log("displayDeviceInfo: devInfo 0x%x\n", devinfo);

   return rc;
}


static void sc_print_log(char * format, ...)
{
        va_list args;

        va_start(args, format);

        vprintf(format, args);
        printf(RESET_ATTRIBUTES);

        if (logfile != NULL)
        {
                vfprintf(logfile, format, args);
                fprintf(logfile, "\n");
                fflush(logfile);
        }
}
