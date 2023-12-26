#
# The module Simulator tests
#

ROOT_DIR := ../..
include $(ROOT_DIR)/Makefile.def

TYPE := exe
NAME := testsimulatorz
DEPS := \
	$(ROOT_DIR)/simulator/$(BUILD_DIR)/simulator.a \
	$(ROOT_DIR)/util/$(BUILD_DIR)/util.a \
	$(ROOT_DIR)/net/$(BUILD_DIR)/net.a
DEPS_DIRS := \
	$(ROOT_DIR)/simulator \
	$(ROOT_DIR)/util \
	$(ROOT_DIR)/net
DEFS +=
SRCS := testsimulatorz.c
SRC_DIRS :=
LIBS +=  -lpthread

include $(ROOT_DIR)/Makefile.rules


