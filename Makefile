#
# TOPPERS/JSPを用いたライントレーサー用のMakefile
#
#	単にmakeとするとプログラムをアップロード
#	make music　で音楽の検査用プログラムmusic.exeを作成
#	make clean　で余計なファイルを削除
#		music.exeだけは残ってしまうので注意
#	make firmware　でNXTにファームウェアをアップロード


# Target specific macros
CUSTOM_SRC=custom_src/
TARGET = jouga
TARGET_SOURCES = \
	$(CUSTOM_SRC)jouga.c \
	music.c button.c display.c graphics.c
TOPPERS_JSP_CFG_SOURCE = ./jouga.cfg
TARGET_HEADERS = \
	$(CUSTOM_SRC)jouga.h \
	jouga_cfg.h music.h button.h display.h graphics.h
FIRMWARE = c:/cygwin/nexttool/lms_arm_nbcnxc_128.rfw

# ここから先は、内容を理解してから変更してください
# Don't modify below part unless you understand them

TOPPERS_KERNEL = NXT_JSP
NXTOSEK_ROOT = /nxtOSEK
BUILD_MODE = RXE_ONLY

.PHONY: first_target
first_target	: all upload

.PHONY: upload
upload	:
	sh ./rxeflash.sh

.PHONY: firmware
firmware	:
	/nexttool/NeXTTool.exe /COM=usb -firmware=$(FIRMWARE)

O_PATH ?= build
include $(NXTOSEK_ROOT)/ecrobot/ecrobot.mak

music	: music.c
	gcc -DMUSIC_DEBUG -o music music.c -lwinmm

#### 依存関係の指定
#### Dependencies
jouga.o		: jouga.h jouga_cfg.h music.h button.h graphics.h display.h
button.o	: button.h
music.o		:
kernel_cfg.c	: jouga_cfg.h jouga.h
display.o	: display.h
graphics.o	: graphics.h display.h
