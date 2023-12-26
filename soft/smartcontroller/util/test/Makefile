#
# The module <Name>
#

ROOT_DIR := ../../
include $(ROOT_DIR)/Makefile.def

TYPE := exe
NAME := test
DEPS := $(ROOT_DIR)/util/$(BUILD_DIR)/util.a
DEPS_DIRS := $(ROOT_DIR)/util
DEFS += -DTEST
SRCS := test.cpp
SRC_DIRS :=
LIBS += -lrt

include $(ROOT_DIR)/Makefile.rules
