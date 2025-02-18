# -*- Makefile -*-
#
# Makefile.Linux - Makefile rules for linux
#

#copy this file from Makefile.Linux
#
#sudo apt-get install libsdl2-dev
#(x)sudo apt-get install liblua5.1-0-dev
#sudo apt-get install libsdl2-image-dev 
#sudo apt-get install libsdl2-ttf-dev 
#sudo apt-get install libsdl2-mixer-dev 
#sudo apt-get install libbz2-dev
#(x)sudo apt-get install libfontconfig1-dev
#(x)sudo apt-get install libogg-dev
#(x)sudo apt-get install libvorbis-dev
#
MIYOO:=1
#now only for MIYOO A30, not MIYOO MINI
#if MIYOO==0, built for PC, xubuntu20 or rpd:
#make clean && make MIYOO=0

EXESUFFIX =
OBJSUFFIX = .o

.SUFFIXES:
.SUFFIXES: $(OBJSUFFIX) .cpp .h

#TARGET = onscripter$(EXESUFFIX) \
#	sardec$(EXESUFFIX) \
#	nsadec$(EXESUFFIX) \
#	sarconv$(EXESUFFIX) \
#	nsaconv$(EXESUFFIX) 
TARGET = onscripter$(EXESUFFIX)
EXT_OBJS = 

# mandatory: SDL, SDL_ttf, SDL_image, SDL_mixer, bzip2
ifeq ($(MIYOO),1)
SYSROOT?=/home/wmt/work_r36s/aarch64-buildroot-linux-gnu_sdk-buildroot/aarch64-buildroot-linux-gnu/sysroot/
#see aarch64-buildroot-linux-gnu_sdk-buildroot.tar.gz
ARCH=
#-march=armv7ve+simd
DEFS = -DLINUX -DUSE_SDL_RENDERER -DNDEBUG -DMIYOO
#-DMIYOO, search SDL_RenderPresent in ONScripter.cpp, there is a display flush bug for SDL2
INCS = -Os $(ARCH) -I./SDL2_image-2.0.5_mod -I./jpeg-6b_mod -I./bzip2-1.0.4_mod -I${SYSROOT}/usr/include -I${SYSROOT}/usr/include/SDL2 -ffunction-sections -fdata-sections -Wall
LIBS = -L${SYSROOT}/usr/lib $(ARCH) -lSDL2_ttf -lSDL2_mixer -lSDL2 -lfreetype -lpng -lz -lpthread -lm
#removed -lbz2 -ljpeg -lSDL2_image 
#removed -lmad
EXT_FLAGS =
else
DEFS = -DLINUX -DUSE_SDL_RENDERER -DNDEBUG -DMIYOO
INCS = -I./SDL2_image-2.0.5_mod -I./jpeg-6b_mod -I./bzip2-1.0.4_mod `sdl2-config --cflags`
LIBS = `sdl2-config --libs` -lSDL2_ttf -lSDL2_mixer -lpng -lz -lm
#-ljpeg -lSDL2_image 
#-lbz2
EXT_FLAGS = 
 endif

# recommended: smpeg
#DEFS += -DUSE_SMPEG
#INCS += `smpeg-config --cflags`
#LIBS += `smpeg-config --libs`

# recommended: fontconfig (to get default font)
#DEFS += -DUSE_FONTCONFIG
#LIBS += -lfontconfig

# recommended: OggVorbis 
#DEFS += -DUSE_OGG_VORBIS
#LIBS += -logg -lvorbis -lvorbisfile

# optional: Integer OggVorbis
#DEFS += -DUSE_OGG_VORBIS -DINTEGER_OGG_VORBIS
#LIBS += -lvorbisidec

# optional: support CD audio
#DEFS += -DUSE_CDROM

# optional: avifile
#DEFS += -DUSE_AVIFILE
#INCS += `avifile-config --cflags`
#LIBS += `avifile-config --libs`
#TARGET += simple_aviplay$(EXESUFFIX)
#EXT_OBJS += AVIWrapper$(OBJSUFFIX)

# optional: lua
#DEFS += -DUSE_LUA
#INCS += -I/usr/include/lua5.1
#LIBS += -llua5.1
#EXT_OBJS += LUAHandler$(OBJSUFFIX)

# optional: SIMD optimizing
#DEFS += -DUSE_SIMD -DUSE_SIMD_X86_SSE2

# optional: multicore rendering
#DEFS += -DUSE_OMP_PARALLEL
#EXT_FLAGS += -fopenmp

# optional: enable builtin effects
DEFS += -DUSE_BUILTIN_EFFECTS -DUSE_BUILTIN_LAYER_EFFECTS


# optional: enable English mode
#DEFS += -DENABLE_1BYTE_CHAR -DFORCE_1BYTE_CHAR


# for GNU g++
ifeq ($(MIYOO),1)
CC = /home/wmt/work_r36s/aarch64-buildroot-linux-gnu_sdk-buildroot/bin/aarch64-buildroot-linux-gnu-g++ 
LD = /home/wmt/work_r36s/aarch64-buildroot-linux-gnu_sdk-buildroot/bin/aarch64-buildroot-linux-gnu-g++ -o
else
CC = g++ 
LD = g++ -o
endif

#CFLAGS = -g -Wall -pipe -c $(INCS) $(DEFS)
CFLAGS = -fpermissive -std=c++11 -O3 -Wall -fomit-frame-pointer -pipe -c $(INCS) $(DEFS) $(EXT_FLAGS)

# for GCC on PowerPC specfied
#CC = powerpc-unknown-linux-gnu-g++
#LD = powerpc-unknown-linux-gnu-g++ -o

#CFLAGS = -O3 -mtune=G4 -maltivec -mabi=altivec -mpowerpc-gfxopt -mmultiple -mstring -Wall -fomit-frame-pointer -pipe -c $(INCS) $(DEFS)

# for Intel compiler
#CC = icc
#LD = icc -o

#CFLAGS = -O3 -tpp6 -xK -c $(INCS) $(DEFS)

RM = rm -f

include Makefile.onscripter
