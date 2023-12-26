#
# The module Smart controller
#

ROOT_DIR := .
include $(ROOT_DIR)/Makefile.def

TYPE := exe
NAME := sc
DEPS := \
	$(ROOT_DIR)/mux_demux/$(BUILD_DIR)/mux_demux.a \
	$(ROOT_DIR)/db/$(BUILD_DIR)/db.a \
	$(ROOT_DIR)/net/$(BUILD_DIR)/net.a \
	$(ROOT_DIR)/util/$(BUILD_DIR)/util.a \
	$(ROOT_DIR)/hal/$(BUILD_DIR)/hal.a \
	$(ROOT_DIR)/zigbee/$(BUILD_DIR)/zigbee_sync.a \
	$(ROOT_DIR)/lib/zigbee.a \
	$(ROOT_DIR)/lib/log.a
DEPS_DIRS := \
	$(ROOT_DIR)/db \
	$(ROOT_DIR)/net \
	$(ROOT_DIR)/mux_demux \
	$(ROOT_DIR)/util \
	$(ROOT_DIR)/hal \
	$(ROOT_DIR)/zigbee
DEFS +=
SRCS := smart_controller.cpp
SRCS_GEN := $(BUILD_DIR)/git_version.c
SRCS_DIRS := $(BUILD_DIR)
LIBS += \
	-lmysqlclient \
	-llog4cplus \
	-lprotobuf-c \
	-lrt

include $(ROOT_DIR)/Makefile.rules


$(BUILD_DIR)/git_version.c:
	@echo "GEN $@"
ifeq ($(HOST),linux)

	@echo /\* Automatically generated file. \*/ > $(BUILD_DIR)/git_version.c
ifdef GIT
	@echo const char \*const g_app_git_version = \"$(shell $(GIT) rev-parse HEAD)\"\; >> $(BUILD_DIR)/git_version.c
else
	@echo const char \*const g_app_git_version = \"unknown\"\; >> $(BUILD_DIR)/git_version.c
endif

else ifeq ($(HOST),windows)

	@echo /* Automatically generated file. */ > $(BUILD_DIR)/git_version.c
ifdef GIT
	@echo const char *const g_app_git_version = "$(shell $(GIT) rev-parse HEAD)"; >> $(BUILD_DIR)/git_version.c
else
	@echo const char *const g_app_git_version = "unknown"; >> $(BUILD_DIR)/git_version.c
endif

else
$(error Not supported)
endif

