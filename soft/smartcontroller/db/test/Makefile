#
# The module MuxDemux tests
#

ROOT_DIR := ../..
include $(ROOT_DIR)/Makefile.def

TYPE := exe
NAME := test
DEPS := \
	$(ROOT_DIR)/db/$(BUILD_DIR)/db.a \
	$(ROOT_DIR)/lib/log.a
DEPS_DIRS := \
	$(ROOT_DIR)/db
DEFS +=
SRCS := TestMuxDemuxDb.cpp
SRC_DIRS :=
LIBS += \
	-lmysqlclient \
	-llog4cplus \
	-lrt

include $(ROOT_DIR)/Makefile.rules
