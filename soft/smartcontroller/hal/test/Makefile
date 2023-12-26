#
# The module <Name>
#

ROOT_DIR := ../../
include $(ROOT_DIR)/Makefile.def

TYPE := exe
NAME := test
DEPS := \
	$(ROOT_DIR)/hal/$(BUILD_DIR)/hal.a \
	$(ROOT_DIR)/lib/log.a	
DEPS_DIRS := \
	$(ROOT_DIR)/hal
DEFS += -DTEST
SRCS := test.cpp
SRC_DIRS :=
LIBS += \
	-llog4cplus \
	-lrt

include $(ROOT_DIR)/Makefile.rules
