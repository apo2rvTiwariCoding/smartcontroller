#
# The module Hal
#

ROOT_DIR := ..
include $(ROOT_DIR)/Makefile.def

TYPE := lib
NAME := hal
DEPS := 
DEFS += 
#-DSIM
SRCS := \
	hal.cpp \
	log.cpp \
	driver.cpp \
	errors.cpp \
	dev/bus.cpp \
	dev/device.cpp \
	dev/ad5245.cpp \
	dev/ad7993.cpp \
	dev/ds1338.cpp \
	dev/htu21d.cpp \
	dev/mcp23017.cpp \
	dev/mcp23017_u2.cpp \
	dev/mcp23017_u4.cpp \
	dev/i2c_ext/sensor.cpp \
	dev/i2c_ext/factory.cpp \
	dev/i2c_ext/f400.cpp \
	dev/w1/bus.cpp \
	dev/w1/sensor.cpp \
	dev/w1/ds2482.cpp \
	dev/w1/ds18b20.cpp \
	dev/details/gpio.cpp
SRCS_DIRS := dev dev/details dev/w1 dev/i2c_ext
LIBS +=

include $(ROOT_DIR)/Makefile.rules
