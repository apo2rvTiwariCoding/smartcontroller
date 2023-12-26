#
# The module MuxDemux tests
#

ROOT_DIR := ../..
include $(ROOT_DIR)/Makefile.def

TYPE := exe
NAME := test
DEPS := \
	$(ROOT_DIR)/mux_demux/$(BUILD_DIR)/mux_demux.a \
	$(ROOT_DIR)/db/$(BUILD_DIR)/db.a \
	$(ROOT_DIR)/net/$(BUILD_DIR)/net.a \
	$(ROOT_DIR)/hal/$(BUILD_DIR)/hal.a \
	$(ROOT_DIR)/zigbee/$(BUILD_DIR)/zigbee_sync.a \
	$(ROOT_DIR)/lib/zigbee.a \
	$(ROOT_DIR)/lib/log.a
DEPS_DIRS := \
	$(ROOT_DIR)/mux_demux \
	$(ROOT_DIR)/net \
	$(ROOT_DIR)/db \
	$(ROOT_DIR)/hal \
	$(ROOT_DIR)/zigbee
DEFS +=
SRCS := TestMuxDemux.cpp 
#		testZC.cpp
SRC_DIRS :=
LIBS += -lmysqlclient \
	-llog4cplus \
	-llog4cplus \
	-lrt  
#	-L$(ROOT_DIR)/zstack/zc/Z-Stack_Linux_Gateway-1.0.1-src/Source/protobuf-c-arm/lib \
	-lprotobuf-c \
	-L$(ROOT_DIR)/zstack/zc/Z-Stack_Linux_Gateway-1.0.1-src/Source/Projects/zstack/linux/demo/ase \
	-lzigbee
	
include $(ROOT_DIR)/Makefile.rules
