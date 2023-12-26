#
# The module Zigbee library test
#

ROOT_DIR := ../../
include $(ROOT_DIR)/Makefile.def

TYPE := exe
NAME := test
DEPS := \
	$(ROOT_DIR)/zigbee/$(BUILD_DIR)/zigbee_sync.a \
	$(ROOT_DIR)/lib/zigbee.a \
	$(ROOT_DIR)/lib/log.a
DEPS_DIRS := \
	$(ROOT_DIR)/zigbee
DEFS += -DTEST
SRCS := test.cpp
SRC_DIRS :=
LIBS += \
	-llog4cplus \
	-lrt \
	-lprotobuf-c

include $(ROOT_DIR)/Makefile.rules
