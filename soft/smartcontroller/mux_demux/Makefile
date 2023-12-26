#
# The module MuxDemux
#

ROOT_DIR := ..
include $(ROOT_DIR)/Makefile.def

TYPE := lib
NAME := mux_demux
DEPS := \
	$(ROOT_DIR)/util/$(BUILD_DIR)/util.a \
	$(ROOT_DIR)/net/$(BUILD_DIR)/net.a \
	$(ROOT_DIR)/db/$(BUILD_DIR)/db.a \
	$(ROOT_DIR)/zigbee/$(BUILD_DIR)/zigbee_sync.a
DEPS_DIRS := \
	$(ROOT_DIR)/util \
	$(ROOT_DIR)/net \
	$(ROOT_DIR)/db \
	$(ROOT_DIR)/zigbee
DEFS +=
SRCS := \
	action_thread.cpp \
	mux_demux_intf.cpp \
	mux_demux.cpp \
	hal.cpp \
	zed_emulation.cpp \
	zigbee.cpp \
	zigbee_cb.cpp \
	asemp.cpp
SRC_DIRS :=
LIBS += 

include $(ROOT_DIR)/Makefile.rules
