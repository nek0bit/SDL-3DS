ifeq ($(strip $(DEVKITARM)),)
$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

ifeq ($(strip $(DEVKITPRO)),)
$(error "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>devkitPRO")
endif

include $(DEVKITARM)/base_tools

TARGET_LIB = libSDL2.a
DIR_PREFIX = SDL2-3DS

OBJS =	$(DIR_PREFIX)/src/SDL.o \
	$(DIR_PREFIX)/src/SDL_assert.o \
	$(DIR_PREFIX)/src/SDL_error.o \
	$(DIR_PREFIX)/src/SDL_hints.o \
	$(DIR_PREFIX)/src/SDL_log.o \
	$(DIR_PREFIX)/src/atomic/SDL_atomic.o \
	$(DIR_PREFIX)/src/atomic/SDL_spinlock.o \
	$(DIR_PREFIX)/src/audio/SDL_audio.o \
	$(DIR_PREFIX)/src/audio/SDL_audiocvt.o \
	$(DIR_PREFIX)/src/audio/SDL_audiodev.o \
	$(DIR_PREFIX)/src/audio/SDL_audiotypecvt.o \
	$(DIR_PREFIX)/src/audio/SDL_mixer.o \
	$(DIR_PREFIX)/src/audio/SDL_wave.o \
	$(DIR_PREFIX)/src/audio/3ds/SDL_3dsaudio.o \
	$(DIR_PREFIX)/src/cpuinfo/SDL_cpuinfo.o \
	$(DIR_PREFIX)/src/events/SDL_clipboardevents.o \
	$(DIR_PREFIX)/src/events/SDL_dropevents.o \
	$(DIR_PREFIX)/src/events/SDL_events.o \
	$(DIR_PREFIX)/src/events/SDL_gesture.o \
	$(DIR_PREFIX)/src/events/SDL_keyboard.o \
	$(DIR_PREFIX)/src/events/SDL_mouse.o \
	$(DIR_PREFIX)/src/events/SDL_quit.o \
	$(DIR_PREFIX)/src/events/SDL_touch.o \
	$(DIR_PREFIX)/src/events/SDL_windowevents.o \
	$(DIR_PREFIX)/src/file/SDL_rwops.o \
	$(DIR_PREFIX)/src/haptic/SDL_haptic.o \
	$(DIR_PREFIX)/src/haptic/dummy/SDL_syshaptic.o \
	$(DIR_PREFIX)/src/joystick/SDL_joystick.o \
	$(DIR_PREFIX)/src/joystick/SDL_gamecontroller.o \
	$(DIR_PREFIX)/src/joystick/3ds/SDL_sysjoystick.o \
	$(DIR_PREFIX)/src/power/SDL_power.o \
	$(DIR_PREFIX)/src/power/3ds/SDL_syspower.o \
	$(DIR_PREFIX)/src/filesystem/dummy/SDL_sysfilesystem.o \
	$(DIR_PREFIX)/src/render/SDL_render.o \
	$(DIR_PREFIX)/src/render/SDL_yuv_sw.o \
	$(DIR_PREFIX)/src/render/3ds/shader.vsh.o \
	$(DIR_PREFIX)/src/render/3ds/shader_vsh_shbin.h \
	$(DIR_PREFIX)/src/render/3ds/SDL_render_3ds.o \
	$(DIR_PREFIX)/src/render/software/SDL_blendfillrect.o \
	$(DIR_PREFIX)/src/render/software/SDL_blendline.o \
	$(DIR_PREFIX)/src/render/software/SDL_blendpoint.o \
	$(DIR_PREFIX)/src/render/software/SDL_drawline.o \
	$(DIR_PREFIX)/src/render/software/SDL_drawpoint.o \
	$(DIR_PREFIX)/src/render/software/SDL_render_sw.o \
	$(DIR_PREFIX)/src/render/software/SDL_rotate.o \
	$(DIR_PREFIX)/src/stdlib/SDL_getenv.o \
	$(DIR_PREFIX)/src/stdlib/SDL_iconv.o \
	$(DIR_PREFIX)/src/stdlib/SDL_malloc.o \
	$(DIR_PREFIX)/src/stdlib/SDL_qsort.o \
	$(DIR_PREFIX)/src/stdlib/SDL_stdlib.o \
	$(DIR_PREFIX)/src/stdlib/SDL_string.o \
	$(DIR_PREFIX)/src/thread/SDL_thread.o \
	$(DIR_PREFIX)/src/thread/3ds/SDL_syssem.o \
	$(DIR_PREFIX)/src/thread/3ds/SDL_systhread.o \
	$(DIR_PREFIX)/src/thread/3ds/SDL_sysmutex.o \
	$(DIR_PREFIX)/src/thread/3ds/SDL_syscond.o \
	$(DIR_PREFIX)/src/thread/3ds/SDL_systls.o \
	$(DIR_PREFIX)/src/timer/SDL_timer.o \
	$(DIR_PREFIX)/src/timer/3ds/SDL_systimer.o \
	$(DIR_PREFIX)/src/video/SDL_RLEaccel.o \
	$(DIR_PREFIX)/src/video/SDL_blit.o \
	$(DIR_PREFIX)/src/video/SDL_blit_0.o \
	$(DIR_PREFIX)/src/video/SDL_blit_1.o \
	$(DIR_PREFIX)/src/video/SDL_blit_A.o \
	$(DIR_PREFIX)/src/video/SDL_blit_N.o \
	$(DIR_PREFIX)/src/video/SDL_blit_auto.o \
	$(DIR_PREFIX)/src/video/SDL_blit_copy.o \
	$(DIR_PREFIX)/src/video/SDL_blit_slow.o \
	$(DIR_PREFIX)/src/video/SDL_bmp.o \
	$(DIR_PREFIX)/src/video/SDL_clipboard.o \
	$(DIR_PREFIX)/src/video/SDL_fillrect.o \
	$(DIR_PREFIX)/src/video/SDL_pixels.o \
	$(DIR_PREFIX)/src/video/SDL_rect.o \
	$(DIR_PREFIX)/src/video/SDL_stretch.o \
	$(DIR_PREFIX)/src/video/SDL_surface.o \
	$(DIR_PREFIX)/src/video/SDL_video.o \
	$(DIR_PREFIX)/src/video/3ds/SDL_3dsevents.o \
	$(DIR_PREFIX)/src/video/3ds/SDL_3dsvideo.o \
	$(DIR_PREFIX)/src/video/3ds/SDL_3dsmouse.o

CTRULIB	:= $(DEVKITPRO)/libctru
INCLUDES = -I./$(DIR_PREFIX)/include -I$(CTRULIB)/include 

#---------------------------------------------------------------------------------
# options for code generation
#---------------------------------------------------------------------------------
ARCH		:=	-march=armv6k -mtune=mpcore -mfloat-abi=hard
CFLAGS		:=	-g -Wall -O2 -mword-relocations -fno-short-enums \
			-fomit-frame-pointer -ffast-math \
			$(ARCH)
CFLAGS		+=	$(INCLUDES) -DARM11 -D_3DS -D__3DS__ -DSDL_BUILDING_3DS
CXXFLAGS	:=      $(CFLAGS) -fno-rtti -fno-exceptions -std=gnu++11
ASFLAGS		:=	-g $(ARCH)
LDFLAGS		:=	-specs=3dsx.specs -g $(ARCH) -Wl,-Map,$(notdir $*.map)

CFLAGS		+= -Wno-unused-variable

LIBS	:= -lctru -lm
CFLAGS += $(LIBS)

all: $(OBJS) $(TARGET_LIB)

$(TARGET_LIB): $(OBJS)
	$(AR) -rc $@ $^


$(DIR_PREFIX)/src/render/3ds/shader_vsh_shbin.h $(DIR_PREFIX)/src/render/3ds/shader.vsh.o:
	@python aemstro_as.py $(DIR_PREFIX)/src/render/3ds/shader.vsh $(DIR_PREFIX)/src/render/3ds/shader.vsh.shbin
	@bin2s $(DIR_PREFIX)/src/render/3ds/shader.vsh.shbin | $(PREFIX)as -o $@
	@echo "extern const u8" `(echo shader.vsh.shbin | sed -e 's/^\([0-9]\)/_\1/' | tr . _)`"_end[];" > `(echo $(DIR_PREFIX)/src/render/3ds/shader.vsh.shbin | tr . _)`.h
	@echo "extern const u8" `(echo shader.vsh.shbin | sed -e 's/^\([0-9]\)/_\1/' | tr . _)`"[];" >> `(echo $(DIR_PREFIX)/src/render/3ds/shader.vsh.shbin | tr . _)`.h
	@echo "extern const u32" `(echo shader.vsh.shbin | sed -e 's/^\([0-9]\)/_\1/' | tr . _)`_size";" >> `(echo $(DIR_PREFIX)/src/render/3ds/shader.vsh.shbin | tr . _)`.h
	@rm $(DIR_PREFIX)/src/render/3ds/shader.vsh.shbin

install: $(TARGET_LIB)
	@mkdir -p $(DEVKITPRO)/portlibs/3ds/lib
	@cp  $(TARGET_LIB) $(DEVKITPRO)/portlibs/3ds/lib
	@mkdir -p $(DEVKITPRO)/portlibs/3ds/include/SDL2
	@cp $(DIR_PREFIX)/include/*.h $(DEVKITPRO)/portlibs/3ds/include/SDL2
	@echo "Installed!"

clean:
	@rm -rf $(OBJS) $(TARGET_LIB) $(DIR_PREFIX)/src/render/3ds/shader_vsh_shbin.h
