#
# The module Net
#

ROOT_DIR := ..
include $(ROOT_DIR)/Makefile.def

TYPE := lib # or exe, custom
NAME := net
DEPS :=
DEFS +=
SRCS := tcp_client_mux.cpp tcp_socket_mux.cpp
SRCS_DIRS :=
LIBS += -lglib-2.0 -lreadline -lcurl -liw -lwiringPi -lrt -lstdc++ -lpthread -ljson -lmysqlclient

include $(ROOT_DIR)/Makefile.rules
