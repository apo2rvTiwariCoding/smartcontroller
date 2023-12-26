#
# The module MuxDemux
#

ROOT_DIR := ..
include $(ROOT_DIR)/Makefile.def

TYPE := lib
NAME := simulator
DEPS := \
	$(ROOT_DIR)/util/$(BUILD_DIR)/util.a \
	$(ROOT_DIR)/net/$(BUILD_DIR)/net.a 
DEPS_DIRS := \
	$(ROOT_DIR)/util \
	$(ROOT_DIR)/net 
DEFS +=
SRCS := csimulator_zigbee.c
SRC_DIRS :=
LIBS += -lpthread
CFLAGS := -ggdb -ffunction-sections -O0 -std=c++0x -pedantic -Wall -Wno-comment


include $(ROOT_DIR)/Makefile.rules
