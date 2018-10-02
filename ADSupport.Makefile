#
#  Copyright (c) 2017 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# 
# Author  : williamledda
#           Jeong Han Lee
# email   : williamledda@esss.se
#           jeonghan.lee@gmail.com
# Date    : Thursday, September 13 22:35:06 CEST 2018
# version : 0.0.1

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(where_am_I)/../configure/DECOUPLE_FLAGS

EXCLUDE_ARCHS += linux-ppc64e6500



APPS:=supportApp

OS_DEF   := os/default
OS_LINUX := os/Linux

# No DEPEND on other DIR
NETCDF_DIR			:= $(APPS)/netCDFSrc
JPEG_DIR			:= $(APPS)/jpegSrc
ZLIB_DIR			:= $(APPS)/zlibSrc
SZIP_DIR			:= $(APPS)/szipSrc

# DEPEND on zlibSrc
TIFF_DIR			:= $(APPS)/tiffSrc
BLOSC_DIR                       := $(APPS)/bloscSrc
XML2_DIR			:= $(APPS)/xml2Src

# DEPEND on zlibSrc sizpSrc
HDF5_DIR			:= $(APPS)/hdf5Src

# DEPEND on hdf5Src
HDF5_HL_DIR			:= $(APPS)/hdf5_hlSrc
NEXUS_DIR			:= $(APPS)/nexusSrc

# DEPEND on tiffSrc zlibSrc xml2Src jpegSrc
GRAPHICSMAGICK_DIR 	:= $(APPS)/GraphicsMagickSrc

# GRAPHICSMAGICK subprojects
GM_BZLIB_DIR 	:= $(GRAPHICSMAGICK_DIR)/bzlib
GM_LCMS_DIR  	:= $(GRAPHICSMAGICK_DIR)/lcms
GM_TTF_DIR   	:= $(GRAPHICSMAGICK_DIR)/ttf
GM_WMF_DIR 	:= $(GRAPHICSMAGICK_DIR)/wmf
GM_WEBP_DIR 	:= $(GRAPHICSMAGICK_DIR)/webp
GM_JBIG_DIR 	:= $(GRAPHICSMAGICK_DIR)/jbig
GM_JP2_DIR	:= $(GRAPHICSMAGICK_DIR)/jp2
GM_PNG_DIR 	:= $(GRAPHICSMAGICK_DIR)/png
GM_MAGICK_DIR	:= $(GRAPHICSMAGICK_DIR)/magick
GM_MAGICK++_DIR	:= $(GRAPHICSMAGICK_DIR)/Magick++
GM_CODERS_DIR	:= $(GRAPHICSMAGICK_DIR)/coders
GM_FILTERS_DIR	:= $(GRAPHICSMAGICK_DIR)/filters

USR_CFLAGS   += -Wno-unused-variable
USR_CFLAGS   += -Wno-unused-function
USR_CFLAGS   += -Wno-unused-but-set-variable
USR_CPPFLAGS += -Wno-unused-variable
USR_CPPFLAGS += -Wno-unused-function
USR_CPPFLAGS += -Wno-unused-but-set-variable

###################################### Build Graphics Magi support ###################################
# The following is the build order and dependencies
#
# 1)  bzlib												[CONFLICTS -> DISABLED]
# 2)  lcms												[OK]
# 3)  ttf												[NOT FULLY INTEGRATED]
# 4)  wmf												[OK]
# 5)  webp												[NOT INTEGRATED]
# 6)  jp2												[NOT INTEGRATED]
# 7)  jbig												[OK]
# 8)  png      -> bzlib									[OK]
# 9)  magick   -> bzlib lcms ttf                        [CONFLICTS -> DISABLED]
# 10) coders   -> bzlib big jp2 magick png ttf webp wmf [CONFLICTS -> DISABLED]
# 11) filters  -> magick ttf							[OK]
# 12) Magick++ -> magick coders							[OK]
##############################################################################################





ifeq ($(WITH_GRAPHICSMAGICK),YES)

# 12) Magick++

ifeq ($(GRAPHICSMAGICK_PREFIX_SYMBOLS),YES)
USR_CXXFLAGS += -DPREFIX_MAGICK_SYMBOLS
endif

USR_LDFLAGS += -lxml2

USR_INCLUDES += -I$(where_am_I)/$(GRAPHICSMAGICK_DIR)
USR_INCLUDES += -I$(where_am_I)/$(GM_LCMS_DIR)/include
USR_INCLUDES += -I$(where_am_I)/$(GM_MAGICK++_DIR)/lib

HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Include.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Image.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Pixels.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/STL.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Blob.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Color.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Drawable.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/BlobRef.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/CoderInfo.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Exception.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Geometry.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/ImageRef.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Functions.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Montage.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Options.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/Thread.h
HEADERS += $(GM_MAGICK++_DIR)/lib/Magick++/TypeMetric.h

SOURCES += $(GM_MAGICK++_DIR)/lib/Blob.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/BlobRef.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/CoderInfo.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/Color.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/Drawable.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/Exception.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/Functions.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/Geometry.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/Image.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/ImageRef.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/Montage.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/Options.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/Pixels.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/STL.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/Thread.cpp
SOURCES += $(GM_MAGICK++_DIR)/lib/TypeMetric.cpp

#LIB_LIBS += Magick
#LIB_LIBS += coders

#LIB_SYS_LIBS_Linux += Xext

# 11) filters

USR_CFLAGS += -D_MAGICKLIB_

ifeq ($(GRAPHICSMAGICK_PREFIX_SYMBOLS),YES)
USR_CFLAGS += -DPREFIX_MAGICK_SYMBOLS
endif

USR_INCLUDES += -I$(where_am_I)/$(GRAPHICSMAGICK_DIR)
USR_INCLUDES += -I$(where_am_I)/$(GM_LCMS_DIR)/inc

SOURCES += $(GM_FILTERS_DIR)/analyze.c

# 10) coders --> conflicts

ifeq (0,1) 

USR_CFLAGS += -DHAVE_VSNPRINTF
USR_CFLAGS += -DBuildMagickModules

ifeq ($(GRAPHICSMAGICK_PREFIX_SYMBOLS),YES)
USR_CFLAGS += -DPREFIX_MAGICK_SYMBOLS
endif

USR_INCLUDES += -I$(where_am_I)/$(GRAPHICSMAGICK_DIR)
USR_INCLUDES += -I$(where_am_I)/$(GM_JBIG_DIR)/libjbig
USR_INCLUDES += -I$(where_am_I)/$(GM_JP2_DIR)/src/libjasper/include
USR_INCLUDES += -I$(where_am_I)/$(GM_BZLIB_DIR)/bzlib
USR_INCLUDES += -I$(where_am_I)/$(GM_PNG_DIR)/png
USR_INCLUDES += -I$(where_am_I)/$(GM_WEBP_DIR)/src
USR_INCLUDES += -I$(where_am_I)/$(GM_TTF_DIR)/include
USR_INCLUDES += -I$(where_am_I)/$(GM_WMF_DIR)/include
USR_INCLUDES += -I$(where_am_I)/$(XML2_DIR)/$(OS_DEF)
USR_INCLUDES += -I$(where_am_I)/$(TIFF_DIR)/$(OS_DEF)
USR_INCLUDES += -I$(where_am_I)/$(TIFF_DIR)/$(OS_LINUX)

HEADERS += $(GM_CODERS_DIR)/static.h

SOURCES += $(GM_CODERS_DIR)/art.c
SOURCES += $(GM_CODERS_DIR)/avi.c
SOURCES += $(GM_CODERS_DIR)/avs.c
SOURCES += $(GM_CODERS_DIR)/bmp.c
SOURCES += $(GM_CODERS_DIR)/cals.c
SOURCES += $(GM_CODERS_DIR)/caption.c
SOURCES += $(GM_CODERS_DIR)/cineon.c
SOURCES += $(GM_CODERS_DIR)/clipboard.c
SOURCES += $(GM_CODERS_DIR)/cmyk.c
SOURCES += $(GM_CODERS_DIR)/cut.c
SOURCES += $(GM_CODERS_DIR)/dcm.c
SOURCES += $(GM_CODERS_DIR)/dcraw.c
SOURCES += $(GM_CODERS_DIR)/dib.c
SOURCES += $(GM_CODERS_DIR)/dps.c
SOURCES += $(GM_CODERS_DIR)/dpx.c
SOURCES += $(GM_CODERS_DIR)/emf.c
SOURCES += $(GM_CODERS_DIR)/ept.c
SOURCES += $(GM_CODERS_DIR)/fax.c
SOURCES += $(GM_CODERS_DIR)/fits.c
SOURCES += $(GM_CODERS_DIR)/fpx.c
SOURCES += $(GM_CODERS_DIR)/gif.c
SOURCES += $(GM_CODERS_DIR)/gradient.c
SOURCES += $(GM_CODERS_DIR)/gray.c
SOURCES += $(GM_CODERS_DIR)/hdf.c
SOURCES += $(GM_CODERS_DIR)/histogram.c
SOURCES += $(GM_CODERS_DIR)/hrz.c
SOURCES += $(GM_CODERS_DIR)/html.c
SOURCES += $(GM_CODERS_DIR)/icon.c
SOURCES += $(GM_CODERS_DIR)/identity.c
SOURCES += $(GM_CODERS_DIR)/info.c
SOURCES += $(GM_CODERS_DIR)/jbig.c
SOURCES += $(GM_CODERS_DIR)/jnx.c
SOURCES += $(GM_CODERS_DIR)/jp2.c
SOURCES += $(GM_CODERS_DIR)/jpeg.c
SOURCES += $(GM_CODERS_DIR)/label.c
SOURCES += $(GM_CODERS_DIR)/locale.c
SOURCES += $(GM_CODERS_DIR)/logo.c
SOURCES += $(GM_CODERS_DIR)/mac.c
SOURCES += $(GM_CODERS_DIR)/map.c
SOURCES += $(GM_CODERS_DIR)/mat.c
SOURCES += $(GM_CODERS_DIR)/matte.c
SOURCES += $(GM_CODERS_DIR)/meta.c
SOURCES += $(GM_CODERS_DIR)/miff.c
SOURCES += $(GM_CODERS_DIR)/mono.c
SOURCES += $(GM_CODERS_DIR)/mpc.c
SOURCES += $(GM_CODERS_DIR)/mpeg.c
SOURCES += $(GM_CODERS_DIR)/mpr.c
SOURCES += $(GM_CODERS_DIR)/msl.c
SOURCES += $(GM_CODERS_DIR)/mtv.c
SOURCES += $(GM_CODERS_DIR)/mvg.c
SOURCES += $(GM_CODERS_DIR)/null.c
SOURCES += $(GM_CODERS_DIR)/otb.c
SOURCES += $(GM_CODERS_DIR)/palm.c
SOURCES += $(GM_CODERS_DIR)/pcd.c
SOURCES += $(GM_CODERS_DIR)/pcl.c
SOURCES += $(GM_CODERS_DIR)/pcx.c
SOURCES += $(GM_CODERS_DIR)/pdb.c
SOURCES += $(GM_CODERS_DIR)/pdf.c
SOURCES += $(GM_CODERS_DIR)/pict.c
SOURCES += $(GM_CODERS_DIR)/pix.c
SOURCES += $(GM_CODERS_DIR)/plasma.c
SOURCES += $(GM_CODERS_DIR)/png.c
SOURCES += $(GM_CODERS_DIR)/pnm.c
SOURCES += $(GM_CODERS_DIR)/preview.c
SOURCES += $(GM_CODERS_DIR)/ps.c
SOURCES += $(GM_CODERS_DIR)/ps2.c
SOURCES += $(GM_CODERS_DIR)/ps3.c
SOURCES += $(GM_CODERS_DIR)/psd.c
SOURCES += $(GM_CODERS_DIR)/pwp.c
SOURCES += $(GM_CODERS_DIR)/rgb.c
SOURCES += $(GM_CODERS_DIR)/rla.c
SOURCES += $(GM_CODERS_DIR)/rle.c
SOURCES += $(GM_CODERS_DIR)/sct.c
SOURCES += $(GM_CODERS_DIR)/sfw.c
SOURCES += $(GM_CODERS_DIR)/sgi.c
SOURCES += $(GM_CODERS_DIR)/stegano.c
SOURCES += $(GM_CODERS_DIR)/sun.c
SOURCES += $(GM_CODERS_DIR)/svg.c
SOURCES += $(GM_CODERS_DIR)/tga.c
SOURCES += $(GM_CODERS_DIR)/tiff.c
SOURCES += $(GM_CODERS_DIR)/tile.c
SOURCES += $(GM_CODERS_DIR)/tim.c
SOURCES += $(GM_CODERS_DIR)/topol.c
SOURCES += $(GM_CODERS_DIR)/ttf.c
SOURCES += $(GM_CODERS_DIR)/txt.c
SOURCES += $(GM_CODERS_DIR)/uil.c
SOURCES += $(GM_CODERS_DIR)/url.c
SOURCES += $(GM_CODERS_DIR)/uyvy.c
SOURCES += $(GM_CODERS_DIR)/vicar.c
SOURCES += $(GM_CODERS_DIR)/vid.c
SOURCES += $(GM_CODERS_DIR)/viff.c
SOURCES += $(GM_CODERS_DIR)/wbmp.c
SOURCES += $(GM_CODERS_DIR)/webp.c
SOURCES += $(GM_CODERS_DIR)/wmf.c
SOURCES += $(GM_CODERS_DIR)/wpg.c
SOURCES += $(GM_CODERS_DIR)/x.c
SOURCES += $(GM_CODERS_DIR)/xbm.c
SOURCES += $(GM_CODERS_DIR)/xc.c
SOURCES += $(GM_CODERS_DIR)/xcf.c
SOURCES += $(GM_CODERS_DIR)/xpm.c
SOURCES += $(GM_CODERS_DIR)/xtrn.c
SOURCES += $(GM_CODERS_DIR)/xwd.c
SOURCES += $(GM_CODERS_DIR)/yuv.c
SOURCES += $(GM_CODERS_DIR)/static.c

#LIB_LIBS += bzlib jbig jp2 Magick png ttf webp wmf jpeg zlib tiff
#ifeq ($(XML2_EXTERNAL), NO)
#  LIB_LIBS += xml2
#else
#  USR_INCLUDES += -I$(XML2_INCLUDE)
#  ifdef XML2_LIB
#    xml2_DIR     = $(XML2_LIB)
#    LIB_LIBS     += xml2
#  else
#    LIB_SYS_LIBS += xml2
#  endif
#endif
endif

# 9) magick -> UNABLE TO BUILD IT PROPERLY NAME CONFLICTS

ifeq (0, 1)
USR_INCLUDES += -I$(where_am_I)/$(GRAPHICSMAGICK_DIR)
USR_INCLUDES += -I$(where_am_I)/$(GM_LCMS_DIR)/include
USR_INCLUDES += -I$(where_am_I)/$(GM_TTF_DIR)/include

USR_CFLAGS += -D_MAGICKLIB_
USR_CFLAGS += -DHAVE_VSNPRINTF

ifeq ($(GRAPHICSMAGICK_PREFIX_SYMBOLS),YES)
USR_CFLAGS += -DPREFIX_MAGICK_SYMBOLS
endif

# Here overriding the default header file install location.
# This allows Magick++ headers files (at $(INSTALL_LOCATION)/include/Magick++) to
# include magick header files at relative path e.g. "magick/magick_config.h
#INSTALL_INCLUDE           = $(INSTALL_LOCATION)/include/magick
HEADERS += $(GM_MAGICK_DIR)/magick_config.h
#HEADERS += $(GM_MAGICK_DIR)/magick_config_Win32.h
HEADERS += $(GM_MAGICK_DIR)/magick_config_Linux.h
HEADERS += $(GM_MAGICK_DIR)/api.h
HEADERS += $(GM_MAGICK_DIR)/enum_strings.h
HEADERS += $(GM_MAGICK_DIR)/common.h
HEADERS += $(GM_MAGICK_DIR)/magick_types.h
HEADERS += $(GM_MAGICK_DIR)/analyze.h
HEADERS += $(GM_MAGICK_DIR)/image.h
HEADERS += $(GM_MAGICK_DIR)/forward.h
HEADERS += $(GM_MAGICK_DIR)/colorspace.h
HEADERS += $(GM_MAGICK_DIR)/error.h
HEADERS += $(GM_MAGICK_DIR)/log.h
HEADERS += $(GM_MAGICK_DIR)/timer.h
HEADERS += $(GM_MAGICK_DIR)/attribute.h
HEADERS += $(GM_MAGICK_DIR)/average.h
HEADERS += $(GM_MAGICK_DIR)/blob.h
HEADERS += $(GM_MAGICK_DIR)/cdl.h
HEADERS += $(GM_MAGICK_DIR)/channel.h
HEADERS += $(GM_MAGICK_DIR)/color.h
HEADERS += $(GM_MAGICK_DIR)/color_lookup.h
HEADERS += $(GM_MAGICK_DIR)/colormap.h
HEADERS += $(GM_MAGICK_DIR)/command.h
HEADERS += $(GM_MAGICK_DIR)/compare.h
HEADERS += $(GM_MAGICK_DIR)/composite.h
HEADERS += $(GM_MAGICK_DIR)/compress.h
HEADERS += $(GM_MAGICK_DIR)/confirm_access.h
HEADERS += $(GM_MAGICK_DIR)/constitute.h
HEADERS += $(GM_MAGICK_DIR)/decorate.h
HEADERS += $(GM_MAGICK_DIR)/delegate.h
HEADERS += $(GM_MAGICK_DIR)/deprecate.h
HEADERS += $(GM_MAGICK_DIR)/describe.h
HEADERS += $(GM_MAGICK_DIR)/draw.h
HEADERS += $(GM_MAGICK_DIR)/effect.h
HEADERS += $(GM_MAGICK_DIR)/enhance.h
HEADERS += $(GM_MAGICK_DIR)/error.h
HEADERS += $(GM_MAGICK_DIR)/fx.h
HEADERS += $(GM_MAGICK_DIR)/gem.h
HEADERS += $(GM_MAGICK_DIR)/gradient.h
HEADERS += $(GM_MAGICK_DIR)/hclut.h
HEADERS += $(GM_MAGICK_DIR)/image.h
HEADERS += $(GM_MAGICK_DIR)/list.h
HEADERS += $(GM_MAGICK_DIR)/log.h
HEADERS += $(GM_MAGICK_DIR)/magic.h
HEADERS += $(GM_MAGICK_DIR)/magick.h
HEADERS += $(GM_MAGICK_DIR)/memory.h
HEADERS += $(GM_MAGICK_DIR)/module.h
HEADERS += $(GM_MAGICK_DIR)/monitor.h
HEADERS += $(GM_MAGICK_DIR)/montage.h
HEADERS += $(GM_MAGICK_DIR)/operator.h
HEADERS += $(GM_MAGICK_DIR)/paint.h
HEADERS += $(GM_MAGICK_DIR)/pixel_cache.h
HEADERS += $(GM_MAGICK_DIR)/pixel_iterator.h
HEADERS += $(GM_MAGICK_DIR)/plasma.h
HEADERS += $(GM_MAGICK_DIR)/profile.h
HEADERS += $(GM_MAGICK_DIR)/random.h
HEADERS += $(GM_MAGICK_DIR)/quantize.h
HEADERS += $(GM_MAGICK_DIR)/registry.h
HEADERS += $(GM_MAGICK_DIR)/render.h
HEADERS += $(GM_MAGICK_DIR)/resize.h
HEADERS += $(GM_MAGICK_DIR)/resource.h
HEADERS += $(GM_MAGICK_DIR)/shear.h
HEADERS += $(GM_MAGICK_DIR)/signature.h
HEADERS += $(GM_MAGICK_DIR)/statistics.h
HEADERS += $(GM_MAGICK_DIR)/symbols.h
HEADERS += $(GM_MAGICK_DIR)/texture.h
HEADERS += $(GM_MAGICK_DIR)/timer.h
HEADERS += $(GM_MAGICK_DIR)/transform.h
HEADERS += $(GM_MAGICK_DIR)/type.h
HEADERS += $(GM_MAGICK_DIR)/utility.h
HEADERS += $(GM_MAGICK_DIR)/version.h


#LIB_SRCS_DEFAULT += analyze_Linux.c
#LIB_SRCS_WIN32 += analyze_Win32.c

SOURCES += $(GM_MAGICK_DIR)/animate.c
SOURCES += $(GM_MAGICK_DIR)/annotate.c
SOURCES += $(GM_MAGICK_DIR)/attribute.c
SOURCES += $(GM_MAGICK_DIR)/average.c
SOURCES += $(GM_MAGICK_DIR)/bit_stream.c
SOURCES += $(GM_MAGICK_DIR)/blob.c
SOURCES += $(GM_MAGICK_DIR)/cdl.c
SOURCES += $(GM_MAGICK_DIR)/channel.c
SOURCES += $(GM_MAGICK_DIR)/color.c
SOURCES += $(GM_MAGICK_DIR)/colormap.c
SOURCES += $(GM_MAGICK_DIR)/colorspace.c
SOURCES += $(GM_MAGICK_DIR)/color_lookup.c
SOURCES += $(GM_MAGICK_DIR)/command.c
SOURCES += $(GM_MAGICK_DIR)/compare.c
SOURCES += $(GM_MAGICK_DIR)/composite.c
SOURCES += $(GM_MAGICK_DIR)/compress.c
SOURCES += $(GM_MAGICK_DIR)/confirm_access.c
SOURCES += $(GM_MAGICK_DIR)/constitute.c
SOURCES += $(GM_MAGICK_DIR)/decorate.c
SOURCES += $(GM_MAGICK_DIR)/delegate.c
SOURCES += $(GM_MAGICK_DIR)/deprecate.c
SOURCES += $(GM_MAGICK_DIR)/describe.c
SOURCES += $(GM_MAGICK_DIR)/display.c
SOURCES += $(GM_MAGICK_DIR)/draw.c
SOURCES += $(GM_MAGICK_DIR)/effect.c
SOURCES += $(GM_MAGICK_DIR)/enhance.c
SOURCES += $(GM_MAGICK_DIR)/enum_strings.c
SOURCES += $(GM_MAGICK_DIR)/error.c
SOURCES += $(GM_MAGICK_DIR)/export.c
SOURCES += $(GM_MAGICK_DIR)/floats.c
SOURCES += $(GM_MAGICK_DIR)/fx.c
SOURCES += $(GM_MAGICK_DIR)/gem.c
SOURCES += $(GM_MAGICK_DIR)/gradient.c
SOURCES += $(GM_MAGICK_DIR)/hclut.c
SOURCES += $(GM_MAGICK_DIR)/image.c
SOURCES += $(GM_MAGICK_DIR)/import.c
SOURCES += $(GM_MAGICK_DIR)/list.c
SOURCES += $(GM_MAGICK_DIR)/locale.c
SOURCES += $(GM_MAGICK_DIR)/log.c
SOURCES += $(GM_MAGICK_DIR)/magic.c
SOURCES += $(GM_MAGICK_DIR)/magick.c
SOURCES += $(GM_MAGICK_DIR)/magick_endian.c
SOURCES += $(GM_MAGICK_DIR)/map.c
SOURCES += $(GM_MAGICK_DIR)/memory.c
SOURCES += $(GM_MAGICK_DIR)/module.c
SOURCES += $(GM_MAGICK_DIR)/monitor.c
SOURCES += $(GM_MAGICK_DIR)/montage.c
SOURCES += $(GM_MAGICK_DIR)/nt_base.c
SOURCES += $(GM_MAGICK_DIR)/nt_feature.c
SOURCES += $(GM_MAGICK_DIR)/omp_data_view.c
SOURCES += $(GM_MAGICK_DIR)/operator.c
SOURCES += $(GM_MAGICK_DIR)/paint.c
SOURCES += $(GM_MAGICK_DIR)/pixel_cache.c
SOURCES += $(GM_MAGICK_DIR)/pixel_iterator.c
SOURCES += $(GM_MAGICK_DIR)/plasma.c
SOURCES += $(GM_MAGICK_DIR)/PreRvIcccm.c
SOURCES += $(GM_MAGICK_DIR)/profile.c
SOURCES += $(GM_MAGICK_DIR)/quantize.c
SOURCES += $(GM_MAGICK_DIR)/random.c
SOURCES += $(GM_MAGICK_DIR)/registry.c
SOURCES += $(GM_MAGICK_DIR)/render.c
SOURCES += $(GM_MAGICK_DIR)/resize.c
SOURCES += $(GM_MAGICK_DIR)/resource.c
SOURCES += $(GM_MAGICK_DIR)/segment.c
SOURCES += $(GM_MAGICK_DIR)/semaphore.c
SOURCES += $(GM_MAGICK_DIR)/shear.c
SOURCES += $(GM_MAGICK_DIR)/signature.c
SOURCES += $(GM_MAGICK_DIR)/statistics.c
SOURCES += $(GM_MAGICK_DIR)/tempfile.c
SOURCES += $(GM_MAGICK_DIR)/texture.c
SOURCES += $(GM_MAGICK_DIR)/timer.c
SOURCES += $(GM_MAGICK_DIR)/transform.c
SOURCES += $(GM_MAGICK_DIR)/tsd.c
SOURCES += $(GM_MAGICK_DIR)/type.c
SOURCES += $(GM_MAGICK_DIR)/unix_port.c
SOURCES += $(GM_MAGICK_DIR)/utility.c
SOURCES += $(GM_MAGICK_DIR)/version.c
SOURCES += $(GM_MAGICK_DIR)/widget.c
SOURCES += $(GM_MAGICK_DIR)/xwindow.c
endif #eq(0, 1)

# 8) png

USR_CFLAGS += -D_PNGLIB_
USR_CFLAGS += -DPNG_NO_MODULEDEF
USR_CFLAGS += -D__FLAT__

SOURCES += $(GM_PNG_DIR)/png.c
SOURCES += $(GM_PNG_DIR)/pngerror.c
SOURCES += $(GM_PNG_DIR)/pngget.c
SOURCES += $(GM_PNG_DIR)/pngmem.c
SOURCES += $(GM_PNG_DIR)/pngpread.c
SOURCES += $(GM_PNG_DIR)/pngrio.c
SOURCES += $(GM_PNG_DIR)/pngrtran.c
SOURCES += $(GM_PNG_DIR)/pngrutil.c
SOURCES += $(GM_PNG_DIR)/pngset.c
SOURCES += $(GM_PNG_DIR)/pngtrans.c
SOURCES += $(GM_PNG_DIR)/pngwio.c
SOURCES += $(GM_PNG_DIR)/pngwrite.c
SOURCES += $(GM_PNG_DIR)/pngwtran.c
SOURCES += $(GM_PNG_DIR)/pngwutil.c
SOURCES += $(GM_PNG_DIR)/pngread.c

#LIB_RCS  += png.rc

# 7) jbig

USR_INCLUDES += -I$(where_am_I)/$(GRAPHICSMAGICK_DIR)

SOURCES += $(GM_JBIG_DIR)/libjbig/jbig.c
SOURCES += $(GM_JBIG_DIR)/libjbig/jbig_tab.c

#How to manage RC file?
#LIB_RCS +=  $(GM_JBIG_DIR)/jbig.rc

# 6) jp2

# 5) webp
USR_INCLUDES += -I$(where_am_I)/$(GRAPHICSMAGICK_DIR)/$(GM_WEBP_DIR)/webp

#USR_CFLAGS := $(subst -DHAVE_CONFIG_H,,$(USR_CFLAGS))

#SRC_DIRS += $(WEBPSRC)/dsp
SOURCES += $(GM_WEBP_DIR)/src/dsp/rescalerdsp.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/rescaler_mips32.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/rescaler_mips_dsp_r2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/rescaler_neon.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/rescaler_sse2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/lossless.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/lossless_enc.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/lossless_enc_mips32.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/lossless_enc_mips_dsp_r2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/lossless_enc_neon.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/lossless_enc_sse2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/lossless_enc_sse41.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/lossless_mips_dsp_r2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/lossless_neon.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/lossless_sse2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/filtersdsp.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/filters_mips_dsp_r2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/filters_sse2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/enc.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/enc_avx2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/enc_mips32.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/enc_mips_dsp_r2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/enc_neon.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/enc_sse2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/enc_sse41.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/costdsp.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/cost_mips32.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/cost_mips_dsp_r2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/cost_sse2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/cpu.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/dec.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/dec_clip_tables.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/dec_mips32.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/dec_mips_dsp_r2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/dec_msa.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/dec_neon.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/dec_sse2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/dec_sse41.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/argb.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/argb_mips_dsp_r2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/argb_sse2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/alpha_processing.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/alpha_processing_mips_dsp_r2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/alpha_processing_sse2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/alpha_processing_sse41.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/upsampling.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/upsampling_mips_dsp_r2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/upsampling_neon.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/upsampling_sse2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/yuv.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/yuv_mips32.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/yuv_mips_dsp_r2.c
SOURCES += $(GM_WEBP_DIR)/src/dsp/yuv_sse2.c

#SRC_DIRS += $(WEBPSRC)/mux
SOURCES += $(GM_WEBP_DIR)/src/mux/anim_encode.c
SOURCES += $(GM_WEBP_DIR)/src/mux/muxedit.c
SOURCES += $(GM_WEBP_DIR)/src/mux/muxinternal.c
SOURCES += $(GM_WEBP_DIR)/src/mux/muxread.c

#	SRC_DIRS += $(WEBPSRC)/enc
SOURCES += $(GM_WEBP_DIR)/src/enc/vp8lenc.c
SOURCES += $(GM_WEBP_DIR)/src/enc/treeenc.c
SOURCES += $(GM_WEBP_DIR)/src/enc/token.c
SOURCES += $(GM_WEBP_DIR)/src/enc/syntax.c
SOURCES += $(GM_WEBP_DIR)/src/enc/near_lossless.c
SOURCES += $(GM_WEBP_DIR)/src/enc/picture.c
SOURCES += $(GM_WEBP_DIR)/src/enc/picture_csp.c
SOURCES += $(GM_WEBP_DIR)/src/enc/picture_psnr.c
SOURCES += $(GM_WEBP_DIR)/src/enc/picture_rescale.c
SOURCES += $(GM_WEBP_DIR)/src/enc/picture_tools.c
SOURCES += $(GM_WEBP_DIR)/src/enc/quantenc.c
SOURCES += $(GM_WEBP_DIR)/src/enc/iterator.c
SOURCES += $(GM_WEBP_DIR)/src/enc/histogram.c
SOURCES += $(GM_WEBP_DIR)/src/enc/frameenc.c
SOURCES += $(GM_WEBP_DIR)/src/enc/filter.c
SOURCES += $(GM_WEBP_DIR)/src/enc/config.c
SOURCES += $(GM_WEBP_DIR)/src/enc/costenc.c
SOURCES += $(GM_WEBP_DIR)/src/enc/delta_palettization.c
SOURCES += $(GM_WEBP_DIR)/src/enc/backward_references.c
SOURCES += $(GM_WEBP_DIR)/src/enc/alphaenc.c
SOURCES += $(GM_WEBP_DIR)/src/enc/analysis.c
SOURCES += $(GM_WEBP_DIR)/src/enc/webpenc.c

#SRC_DIRS += $(WEBPSRC)/utils
SOURCES += $(GM_WEBP_DIR)/src/utils/bit_reader.c
SOURCES += $(GM_WEBP_DIR)/src/utils/bit_writer.c
SOURCES += $(GM_WEBP_DIR)/src/utils/color_cache.c
SOURCES += $(GM_WEBP_DIR)/src/utils/filtersutils.c
SOURCES += $(GM_WEBP_DIR)/src/utils/huffman.c
SOURCES += $(GM_WEBP_DIR)/src/utils/huffman_encode.c
SOURCES += $(GM_WEBP_DIR)/src/utils/quant_levels.c
SOURCES += $(GM_WEBP_DIR)/src/utils/quant_levels_dec.c
SOURCES += $(GM_WEBP_DIR)/src/utils/random.c
SOURCES += $(GM_WEBP_DIR)/src/utils/rescalerutils.c
SOURCES += $(GM_WEBP_DIR)/src/utils/thread.c
SOURCES += $(GM_WEBP_DIR)/src/utils/utils.c

#SRC_DIRS += $(WEBPSRC)/dec
SOURCES += $(GM_WEBP_DIR)/src/dec/alphadec.c
SOURCES += $(GM_WEBP_DIR)/src/dec/buffer.c
SOURCES += $(GM_WEBP_DIR)/src/dec/framedec.c
SOURCES += $(GM_WEBP_DIR)/src/dec/idec.c
SOURCES += $(GM_WEBP_DIR)/src/dec/io.c
SOURCES += $(GM_WEBP_DIR)/src/dec/quantdec.c
SOURCES += $(GM_WEBP_DIR)/src/dec/treedec.c
SOURCES += $(GM_WEBP_DIR)/src/dec/vp8.c
SOURCES += $(GM_WEBP_DIR)/src/dec/vp8ldec.c
SOURCES += $(GM_WEBP_DIR)/src/dec/webp.c

#SRC_DIRS += $(WEBPSRC)/demux
SOURCES += $(GM_WEBP_DIR)/src/demux/anim_decode.c
SOURCES += $(GM_WEBP_DIR)/src/demux/demux.c

# 4) wmf
#USR_CFLAGS       += -DHAVE_CONFIG_H
USR_CFLAGS       += -D_EXPORT

USR_INCLUDES += -I$(where_am_I)/$(GRAPHICSMAGICK_DIR)
USR_INCLUDES += -I$(where_am_I)/$(GM_WMF_DIR)
USR_INCLUDES += -I$(where_am_I)/$(GM_WMF_DIR)/include
USR_INCLUDES += -I$(where_am_I)/$(GM_TTF_DIR)/include

SOURCES += $(GM_WMF_DIR)/src/api.c
SOURCES += $(GM_WMF_DIR)/src/bbuf.c
SOURCES += $(GM_WMF_DIR)/src/meta.c
SOURCES += $(GM_WMF_DIR)/src/player.c
SOURCES += $(GM_WMF_DIR)/src/recorder.c

# Build 3) ttf -----------> OMG!!!!!!!!!!!!!!!
ifeq (0, 1)
USR_INCLUDES += -I$(where_am_I)/$(GM_TTF_DIR)/include
USR_INCLUDES += -I$(where_am_I)/$(GM_TTF_DIR)/include/freetype/
USR_INCLUDES += -I$(where_am_I)/$(GM_TTF_DIR)/include/freetype/config/
USR_INCLUDES += -I$(where_am_I)/$(GM_TTF_DIR)/include/freetype/internal/
USR_INCLUDES += -I$(where_am_I)/$(GM_TTF_DIR)/include/freetype/internal/services

HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/ft2build.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/config/ftheader.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/config/ftconfig.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/config/ftoption.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/config/ftstdlib.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/freetype.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/fttypes.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/ftsystem.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/ftimage.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/fterrors.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/ftmoderr.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/fterrdef.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/ftglyph.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/ftoutln.h
HEADERS += $(GRAPHICSMAGICK_DIR)/ttf/include/freetype/ftbbox.h

SOURCES += $(GM_TTF_DIR)/src/autofit/autofit.c

SOURCES += $(GM_TTF_DIR)/src/base/ftbase.c
SOURCES += $(GM_TTF_DIR)/src/base/ftbbox.c
SOURCES += $(GM_TTF_DIR)/src/base/ftbitmap.c
SOURCES += $(GM_TTF_DIR)/src/base/ftfntfmt.c
SOURCES += $(GM_TTF_DIR)/src/base/ftfstype.c
SOURCES += $(GM_TTF_DIR)/src/base/ftgasp.c
SOURCES += $(GM_TTF_DIR)/src/base/ftglyph.c
SOURCES += $(GM_TTF_DIR)/src/base/ftgxval.c
SOURCES += $(GM_TTF_DIR)/src/base/ftinit.c
SOURCES += $(GM_TTF_DIR)/src/base/ftlcdfil.c
SOURCES += $(GM_TTF_DIR)/src/base/ftmm.c
SOURCES += $(GM_TTF_DIR)/src/base/ftotval.c
SOURCES += $(GM_TTF_DIR)/src/base/ftpatent.c
SOURCES += $(GM_TTF_DIR)/src/base/ftpfr.c
SOURCES += $(GM_TTF_DIR)/src/base/ftstroke.c
SOURCES += $(GM_TTF_DIR)/src/base/ftsynth.c
SOURCES += $(GM_TTF_DIR)/src/base/ftsystem.c
SOURCES += $(GM_TTF_DIR)/src/base/fttype1.c
SOURCES += $(GM_TTF_DIR)/src/base/ftwinfnt.c

SOURCES += $(GM_TTF_DIR)/src/bdf.c

#????????????????????????
#LIV_RCS += ttf.rc
endif

# Build 2) lcms
USR_CFLAGS += -D_LCMSLIB_

USR_INCLUDES += -I$(where_am_I)/$(GM_LCMS_DIR)/include

SOURCES += $(GM_LCMS_DIR)/src/cmsalpha.c
SOURCES += $(GM_LCMS_DIR)/src/cmscam02.c
SOURCES += $(GM_LCMS_DIR)/src/cmscgats.c
SOURCES += $(GM_LCMS_DIR)/src/cmscnvrt.c
SOURCES += $(GM_LCMS_DIR)/src/cmserr.c
SOURCES += $(GM_LCMS_DIR)/src/cmsgamma.c
SOURCES += $(GM_LCMS_DIR)/src/cmsgmt.c
SOURCES += $(GM_LCMS_DIR)/src/cmshalf.c
SOURCES += $(GM_LCMS_DIR)/src/cmsintrp.c
SOURCES += $(GM_LCMS_DIR)/src/cmsio0.c
SOURCES += $(GM_LCMS_DIR)/src/cmsio1.c
SOURCES += $(GM_LCMS_DIR)/src/cmslut.c
SOURCES += $(GM_LCMS_DIR)/src/cmsmd5.c
SOURCES += $(GM_LCMS_DIR)/src/cmsmtrx.c
SOURCES += $(GM_LCMS_DIR)/src/cmsnamed.c
SOURCES += $(GM_LCMS_DIR)/src/cmsopt.c
SOURCES += $(GM_LCMS_DIR)/src/cmspack.c
SOURCES += $(GM_LCMS_DIR)/src/cmspcs.c
SOURCES += $(GM_LCMS_DIR)/src/cmsplugin.c
SOURCES += $(GM_LCMS_DIR)/src/cmsps2.c
SOURCES += $(GM_LCMS_DIR)/src/cmssamp.c
SOURCES += $(GM_LCMS_DIR)/src/cmssm.c
SOURCES += $(GM_LCMS_DIR)/src/cmstypes.c
SOURCES += $(GM_LCMS_DIR)/src/cmsvirt.c
SOURCES += $(GM_LCMS_DIR)/src/cmswtpnt.c
SOURCES += $(GM_LCMS_DIR)/src/cmsxform.c
#    	
# Build 1) -> bzlib
# CONFLICT WITH ZLIB: multiple definition of `compress2' `compress' `compressBound'
#
#	#disable bzlib
ifeq (0, 1)
USR_CFLAGS += -DBZ_EXPORT
#    
HEADERS += $(GM_BZLIB_DIR)/bzlib.h

SOURCES += $(GM_BZLIB_DIR)/blocksort.c
SOURCES += $(GM_BZLIB_DIR)/bzlib.c
SOURCES += $(GM_BZLIB_DIR)/compress.c
SOURCES += $(GM_BZLIB_DIR)/crctable.c
SOURCES += $(GM_BZLIB_DIR)/decompress.c
SOURCES += $(GM_BZLIB_DIR)/huffman.c
SOURCES += $(GM_BZLIB_DIR)/randtable.c

#HOW TO HANDLE RC FILE?
LIB_RCS  += $(GM_BZLIB_DIR)/bzlib.rc
endif
endif # ($(WITH_GRAPHICSMAGICK),YES)

######################################################################################################



ifeq ($(WITH_NEXUS),YES)

HEADERS += $(NEXUS_DIR)/$(OS_DEF)/napi.h
HEADERS += $(NEXUS_DIR)/$(OS_DEF)/napiconfig.h
HEADERS += $(NEXUS_DIR)/$(OS_LINUX)/nxconfig.h

SOURCES += $(NEXUS_DIR)/napi.c
SOURCES += $(NEXUS_DIR)/napi5.c
SOURCES += $(NEXUS_DIR)/napiu.c
SOURCES += $(NEXUS_DIR)/nxdataset.c
SOURCES += $(NEXUS_DIR)/nxio.c
SOURCES += $(NEXUS_DIR)/nxstack.c
SOURCES += $(NEXUS_DIR)/nxxml.c
SOURCES += $(NEXUS_DIR)/stptok.c

USR_CFLAGS += -DHDF5 -D_FILE_OFFSET_BITS=64

# Travis/ubuntu 12.04 tweak: persuade the hdf5 library build to use API v18 over v16
USR_CFLAGS += -DH5_NO_DEPRECATED_SYMBOLS -DH5Gopen_vers=2


endif # ($(WITH_NEXUS),YES)



# Building HDF5_DIR Support. This inclueds both hd5Src and hd5_hdlSrc
ifeq ($(WITH_HDF5),YES)

USR_CFLAGS += -D NDEBUG

USR_INCLUDES += -I$(where_am_I)$(HDF5_HL_DIR)


HEADERS += $(HDF5_HL_DIR)/H5DOpublic.h
HEADERS += $(HDF5_HL_DIR)/H5DSpublic.h
HEADERS += $(HDF5_HL_DIR)/H5IMpublic.h
HEADERS += $(HDF5_HL_DIR)/H5LDpublic.h
HEADERS += $(HDF5_HL_DIR)/H5LTpublic.h
HEADERS += $(HDF5_HL_DIR)/H5PTpublic.h
HEADERS += $(HDF5_HL_DIR)/H5TBpublic.h
HEADERS += $(HDF5_HL_DIR)/hdf5_hl.h

SOURCES += $(HDF5_HL_DIR)/H5DO.c
SOURCES += $(HDF5_HL_DIR)/H5DS.c
SOURCES += $(HDF5_HL_DIR)/H5IM.c
SOURCES += $(HDF5_HL_DIR)/H5LD.c
SOURCES += $(HDF5_HL_DIR)/H5LT.c
SOURCES += $(HDF5_HL_DIR)/H5LTanalyze.c
SOURCES += $(HDF5_HL_DIR)/H5LTparse.c
SOURCES += $(HDF5_HL_DIR)/H5PT.c
SOURCES += $(HDF5_HL_DIR)/H5TB.c


USR_INCLUDES += -I$(where_am_I)$(HDF5_DIR)

HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5ACpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5api_adpt.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Apublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5B2public.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Bpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Cpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Dpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Epubgen.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Epublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FDcore.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FDdirect.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FDfamily.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FDlog.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FDmpi.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FDmpio.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FDmulti.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FDpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FDsec2.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FDstdio.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FDwindows.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5FSpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Fpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Gpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5HFpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5HGpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5HLpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Ipublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Lpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5MMpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Opublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5overflow.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5PLextern.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5PLpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Ppublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5public.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Rpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Spublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Tpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5version.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5Zpublic.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/hdf5.h
HEADERS += $(HDF5_DIR)/$(OS_DEF)/H5pubconf.h
HEADERS += $(HDF5_DIR)/$(OS_LINUX)/H5pubconf_32.h
HEADERS += $(HDF5_DIR)/$(OS_LINUX)/H5pubconf_64.h


SOURCES += $(HDF5_DIR)/H5.c
SOURCES += $(HDF5_DIR)/H5checksum.c
SOURCES += $(HDF5_DIR)/H5dbg.c
SOURCES += $(HDF5_DIR)/H5system.c
SOURCES += $(HDF5_DIR)/H5timer.c
SOURCES += $(HDF5_DIR)/H5trace.c
SOURCES += $(HDF5_DIR)/H5A.c
SOURCES += $(HDF5_DIR)/H5Abtree2.c
SOURCES += $(HDF5_DIR)/H5Adense.c
SOURCES += $(HDF5_DIR)/H5Adeprec.c
SOURCES += $(HDF5_DIR)/H5Aint.c
SOURCES += $(HDF5_DIR)/H5Atest.c
SOURCES += $(HDF5_DIR)/H5AC.c
SOURCES += $(HDF5_DIR)/H5AClog.c
SOURCES += $(HDF5_DIR)/H5ACdbg.c
SOURCES += $(HDF5_DIR)/H5ACproxy_entry.c
SOURCES += $(HDF5_DIR)/H5B.c
SOURCES += $(HDF5_DIR)/H5Bcache.c
SOURCES += $(HDF5_DIR)/H5Bdbg.c
SOURCES += $(HDF5_DIR)/H5B2.c
SOURCES += $(HDF5_DIR)/H5B2cache.c
SOURCES += $(HDF5_DIR)/H5B2dbg.c
SOURCES += $(HDF5_DIR)/H5B2hdr.c
SOURCES += $(HDF5_DIR)/H5B2int.c
SOURCES += $(HDF5_DIR)/H5B2internal.c
SOURCES += $(HDF5_DIR)/H5B2leaf.c
SOURCES += $(HDF5_DIR)/H5B2stat.c
SOURCES += $(HDF5_DIR)/H5B2test.c
SOURCES += $(HDF5_DIR)/H5C.c
SOURCES += $(HDF5_DIR)/H5Cdbg.c
SOURCES += $(HDF5_DIR)/H5Cepoch.c
SOURCES += $(HDF5_DIR)/H5Cimage.c
SOURCES += $(HDF5_DIR)/H5Clog.c
SOURCES += $(HDF5_DIR)/H5Cprefetched.c
SOURCES += $(HDF5_DIR)/H5Cquery.c
SOURCES += $(HDF5_DIR)/H5Ctag.c
SOURCES += $(HDF5_DIR)/H5Ctest.c
SOURCES += $(HDF5_DIR)/H5CS.c
SOURCES += $(HDF5_DIR)/H5D.c
SOURCES += $(HDF5_DIR)/H5Dbtree.c
SOURCES += $(HDF5_DIR)/H5Dbtree2.c
SOURCES += $(HDF5_DIR)/H5Dchunk.c
SOURCES += $(HDF5_DIR)/H5Dcompact.c
SOURCES += $(HDF5_DIR)/H5Dcontig.c
SOURCES += $(HDF5_DIR)/H5Ddbg.c
SOURCES += $(HDF5_DIR)/H5Ddeprec.c
SOURCES += $(HDF5_DIR)/H5Dearray.c
SOURCES += $(HDF5_DIR)/H5Defl.c
SOURCES += $(HDF5_DIR)/H5Dfarray.c
SOURCES += $(HDF5_DIR)/H5Dfill.c
SOURCES += $(HDF5_DIR)/H5Dint.c
SOURCES += $(HDF5_DIR)/H5Dio.c
SOURCES += $(HDF5_DIR)/H5Dlayout.c
SOURCES += $(HDF5_DIR)/H5Dnone.c
SOURCES += $(HDF5_DIR)/H5Doh.c
SOURCES += $(HDF5_DIR)/H5Dscatgath.c
SOURCES += $(HDF5_DIR)/H5Dselect.c
SOURCES += $(HDF5_DIR)/H5Dsingle.c
SOURCES += $(HDF5_DIR)/H5Dtest.c
SOURCES += $(HDF5_DIR)/H5Dvirtual.c
SOURCES += $(HDF5_DIR)/H5E.c
SOURCES += $(HDF5_DIR)/H5Edeprec.c
SOURCES += $(HDF5_DIR)/H5Eint.c
SOURCES += $(HDF5_DIR)/H5EA.c
SOURCES += $(HDF5_DIR)/H5EAcache.c
SOURCES += $(HDF5_DIR)/H5EAdbg.c
SOURCES += $(HDF5_DIR)/H5EAdblkpage.c
SOURCES += $(HDF5_DIR)/H5EAdblock.c
SOURCES += $(HDF5_DIR)/H5EAhdr.c
SOURCES += $(HDF5_DIR)/H5EAiblock.c
SOURCES += $(HDF5_DIR)/H5EAint.c
SOURCES += $(HDF5_DIR)/H5EAsblock.c
SOURCES += $(HDF5_DIR)/H5EAstat.c
SOURCES += $(HDF5_DIR)/H5EAtest.c
SOURCES += $(HDF5_DIR)/H5F.c
SOURCES += $(HDF5_DIR)/H5Faccum.c
SOURCES += $(HDF5_DIR)/H5Fcwfs.c
SOURCES += $(HDF5_DIR)/H5Fdbg.c
SOURCES += $(HDF5_DIR)/H5Fdeprec.c
SOURCES += $(HDF5_DIR)/H5Fefc.c
SOURCES += $(HDF5_DIR)/H5Ffake.c
SOURCES += $(HDF5_DIR)/H5Fint.c
SOURCES += $(HDF5_DIR)/H5Fio.c
SOURCES += $(HDF5_DIR)/H5Fmount.c
SOURCES += $(HDF5_DIR)/H5Fquery.c
SOURCES += $(HDF5_DIR)/H5Fsfile.c
SOURCES += $(HDF5_DIR)/H5Fspace.c
SOURCES += $(HDF5_DIR)/H5Fsuper.c
SOURCES += $(HDF5_DIR)/H5Fsuper_cache.c
SOURCES += $(HDF5_DIR)/H5Ftest.c
SOURCES += $(HDF5_DIR)/H5FA.c
SOURCES += $(HDF5_DIR)/H5FAcache.c
SOURCES += $(HDF5_DIR)/H5FAdbg.c
SOURCES += $(HDF5_DIR)/H5FAdblock.c
SOURCES += $(HDF5_DIR)/H5FAdblkpage.c
SOURCES += $(HDF5_DIR)/H5FAhdr.c
SOURCES += $(HDF5_DIR)/H5FAint.c
SOURCES += $(HDF5_DIR)/H5FAstat.c
SOURCES += $(HDF5_DIR)/H5FAtest.c
SOURCES += $(HDF5_DIR)/H5FD.c
SOURCES += $(HDF5_DIR)/H5FDcore.c
SOURCES += $(HDF5_DIR)/H5FDfamily.c
SOURCES += $(HDF5_DIR)/H5FDint.c
SOURCES += $(HDF5_DIR)/H5FDlog.c
SOURCES += $(HDF5_DIR)/H5FDmulti.c
SOURCES += $(HDF5_DIR)/H5FDsec2.c
SOURCES += $(HDF5_DIR)/H5FDspace.c
SOURCES += $(HDF5_DIR)/H5FDstdio.c
SOURCES += $(HDF5_DIR)/H5FDtest.c
SOURCES += $(HDF5_DIR)/H5FL.c
SOURCES += $(HDF5_DIR)/H5FO.c
SOURCES += $(HDF5_DIR)/H5FS.c
SOURCES += $(HDF5_DIR)/H5FScache.c
SOURCES += $(HDF5_DIR)/H5FSdbg.c
SOURCES += $(HDF5_DIR)/H5FSint.c
SOURCES += $(HDF5_DIR)/H5FSsection.c
SOURCES += $(HDF5_DIR)/H5FSstat.c
SOURCES += $(HDF5_DIR)/H5FStest.c
SOURCES += $(HDF5_DIR)/H5G.c
SOURCES += $(HDF5_DIR)/H5Gbtree2.c
SOURCES += $(HDF5_DIR)/H5Gcache.c
SOURCES += $(HDF5_DIR)/H5Gcompact.c
SOURCES += $(HDF5_DIR)/H5Gdense.c
SOURCES += $(HDF5_DIR)/H5Gdeprec.c
SOURCES += $(HDF5_DIR)/H5Gent.c
SOURCES += $(HDF5_DIR)/H5Gint.c
SOURCES += $(HDF5_DIR)/H5Glink.c
SOURCES += $(HDF5_DIR)/H5Gloc.c
SOURCES += $(HDF5_DIR)/H5Gname.c
SOURCES += $(HDF5_DIR)/H5Gnode.c
SOURCES += $(HDF5_DIR)/H5Gobj.c
SOURCES += $(HDF5_DIR)/H5Goh.c
SOURCES += $(HDF5_DIR)/H5Groot.c
SOURCES += $(HDF5_DIR)/H5Gstab.c
SOURCES += $(HDF5_DIR)/H5Gtest.c
SOURCES += $(HDF5_DIR)/H5Gtraverse.c
SOURCES += $(HDF5_DIR)/H5HF.c
SOURCES += $(HDF5_DIR)/H5HFbtree2.c
SOURCES += $(HDF5_DIR)/H5HFcache.c
SOURCES += $(HDF5_DIR)/H5HFdbg.c
SOURCES += $(HDF5_DIR)/H5HFdblock.c
SOURCES += $(HDF5_DIR)/H5HFdtable.c
SOURCES += $(HDF5_DIR)/H5HFhdr.c
SOURCES += $(HDF5_DIR)/H5HFhuge.c
SOURCES += $(HDF5_DIR)/H5HFiblock.c
SOURCES += $(HDF5_DIR)/H5HFiter.c
SOURCES += $(HDF5_DIR)/H5HFman.c
SOURCES += $(HDF5_DIR)/H5HFsection.c
SOURCES += $(HDF5_DIR)/H5HFspace.c
SOURCES += $(HDF5_DIR)/H5HFstat.c
SOURCES += $(HDF5_DIR)/H5HFtest.c
SOURCES += $(HDF5_DIR)/H5HFtiny.c
SOURCES += $(HDF5_DIR)/H5HG.c
SOURCES += $(HDF5_DIR)/H5HGcache.c
SOURCES += $(HDF5_DIR)/H5HGdbg.c
SOURCES += $(HDF5_DIR)/H5HGquery.c
SOURCES += $(HDF5_DIR)/H5HL.c
SOURCES += $(HDF5_DIR)/H5HLcache.c
SOURCES += $(HDF5_DIR)/H5HLdbg.c
SOURCES += $(HDF5_DIR)/H5HLint.c
SOURCES += $(HDF5_DIR)/H5HLprfx.c
SOURCES += $(HDF5_DIR)/H5HLdblk.c
SOURCES += $(HDF5_DIR)/H5HP.c
SOURCES += $(HDF5_DIR)/H5I.c
SOURCES += $(HDF5_DIR)/H5Itest.c
SOURCES += $(HDF5_DIR)/H5L.c
SOURCES += $(HDF5_DIR)/H5Lexternal.c
SOURCES += $(HDF5_DIR)/H5MF.c
SOURCES += $(HDF5_DIR)/H5MFaggr.c
SOURCES += $(HDF5_DIR)/H5MFdbg.c
SOURCES += $(HDF5_DIR)/H5MFsection.c
SOURCES += $(HDF5_DIR)/H5MM.c
SOURCES += $(HDF5_DIR)/H5MP.c
SOURCES += $(HDF5_DIR)/H5MPtest.c
SOURCES += $(HDF5_DIR)/H5O.c
SOURCES += $(HDF5_DIR)/H5Oainfo.c
SOURCES += $(HDF5_DIR)/H5Oalloc.c
SOURCES += $(HDF5_DIR)/H5Oattr.c
SOURCES += $(HDF5_DIR)/H5Oattribute.c
SOURCES += $(HDF5_DIR)/H5Obogus.c
SOURCES += $(HDF5_DIR)/H5Obtreek.c
SOURCES += $(HDF5_DIR)/H5Ocache.c
SOURCES += $(HDF5_DIR)/H5Ocache_image.c
SOURCES += $(HDF5_DIR)/H5Ochunk.c
SOURCES += $(HDF5_DIR)/H5Ocont.c
SOURCES += $(HDF5_DIR)/H5Ocopy.c
SOURCES += $(HDF5_DIR)/H5Odbg.c
SOURCES += $(HDF5_DIR)/H5Odrvinfo.c
SOURCES += $(HDF5_DIR)/H5Odtype.c
SOURCES += $(HDF5_DIR)/H5Oefl.c
SOURCES += $(HDF5_DIR)/H5Ofill.c
SOURCES += $(HDF5_DIR)/H5Oflush.c
SOURCES += $(HDF5_DIR)/H5Ofsinfo.c
SOURCES += $(HDF5_DIR)/H5Oginfo.c
SOURCES += $(HDF5_DIR)/H5Olayout.c
SOURCES += $(HDF5_DIR)/H5Olinfo.c
SOURCES += $(HDF5_DIR)/H5Olink.c
SOURCES += $(HDF5_DIR)/H5Omessage.c
SOURCES += $(HDF5_DIR)/H5Omtime.c
SOURCES += $(HDF5_DIR)/H5Oname.c
SOURCES += $(HDF5_DIR)/H5Onull.c
SOURCES += $(HDF5_DIR)/H5Opline.c
SOURCES += $(HDF5_DIR)/H5Orefcount.c
SOURCES += $(HDF5_DIR)/H5Osdspace.c
SOURCES += $(HDF5_DIR)/H5Oshared.c
SOURCES += $(HDF5_DIR)/H5Oshmesg.c
SOURCES += $(HDF5_DIR)/H5Ostab.c
SOURCES += $(HDF5_DIR)/H5Otest.c
SOURCES += $(HDF5_DIR)/H5Ounknown.c
SOURCES += $(HDF5_DIR)/H5P.c
SOURCES += $(HDF5_DIR)/H5Pacpl.c
SOURCES += $(HDF5_DIR)/H5Pdapl.c
SOURCES += $(HDF5_DIR)/H5Pdcpl.c
SOURCES += $(HDF5_DIR)/H5Pdeprec.c
SOURCES += $(HDF5_DIR)/H5Pdxpl.c
SOURCES += $(HDF5_DIR)/H5Pencdec.c
SOURCES += $(HDF5_DIR)/H5Pfapl.c
SOURCES += $(HDF5_DIR)/H5Pfcpl.c
SOURCES += $(HDF5_DIR)/H5Pfmpl.c
SOURCES += $(HDF5_DIR)/H5Pgcpl.c
SOURCES += $(HDF5_DIR)/H5Pint.c
SOURCES += $(HDF5_DIR)/H5Plapl.c
SOURCES += $(HDF5_DIR)/H5Plcpl.c
SOURCES += $(HDF5_DIR)/H5Pocpl.c
SOURCES += $(HDF5_DIR)/H5Pocpypl.c
SOURCES += $(HDF5_DIR)/H5Pstrcpl.c
SOURCES += $(HDF5_DIR)/H5Ptest.c
SOURCES += $(HDF5_DIR)/H5PB.c
SOURCES += $(HDF5_DIR)/H5PL.c
SOURCES += $(HDF5_DIR)/H5R.c
SOURCES += $(HDF5_DIR)/H5Rdeprec.c
SOURCES += $(HDF5_DIR)/H5UC.c
SOURCES += $(HDF5_DIR)/H5RS.c
SOURCES += $(HDF5_DIR)/H5S.c
SOURCES += $(HDF5_DIR)/H5Sall.c
SOURCES += $(HDF5_DIR)/H5Sdbg.c
SOURCES += $(HDF5_DIR)/H5Shyper.c
SOURCES += $(HDF5_DIR)/H5Snone.c
SOURCES += $(HDF5_DIR)/H5Spoint.c
SOURCES += $(HDF5_DIR)/H5Sselect.c
SOURCES += $(HDF5_DIR)/H5Stest.c
SOURCES += $(HDF5_DIR)/H5SL.c
SOURCES += $(HDF5_DIR)/H5SM.c
SOURCES += $(HDF5_DIR)/H5SMbtree2.c
SOURCES += $(HDF5_DIR)/H5SMcache.c
SOURCES += $(HDF5_DIR)/H5SMmessage.c
SOURCES += $(HDF5_DIR)/H5SMtest.c
SOURCES += $(HDF5_DIR)/H5ST.c
SOURCES += $(HDF5_DIR)/H5T.c
SOURCES += $(HDF5_DIR)/H5Tarray.c
SOURCES += $(HDF5_DIR)/H5Tbit.c
SOURCES += $(HDF5_DIR)/H5Tcommit.c
SOURCES += $(HDF5_DIR)/H5Tcompound.c
SOURCES += $(HDF5_DIR)/H5Tconv.c
SOURCES += $(HDF5_DIR)/H5Tcset.c
SOURCES += $(HDF5_DIR)/H5Tdbg.c
SOURCES += $(HDF5_DIR)/H5Tdeprec.c
SOURCES += $(HDF5_DIR)/H5Tenum.c
SOURCES += $(HDF5_DIR)/H5Tfields.c
SOURCES += $(HDF5_DIR)/H5Tfixed.c
SOURCES += $(HDF5_DIR)/H5Tfloat.c
SOURCES += $(HDF5_DIR)/H5Tnative.c
SOURCES += $(HDF5_DIR)/H5Toffset.c
SOURCES += $(HDF5_DIR)/H5Toh.c
SOURCES += $(HDF5_DIR)/H5Topaque.c
SOURCES += $(HDF5_DIR)/H5Torder.c
SOURCES += $(HDF5_DIR)/H5Tpad.c
SOURCES += $(HDF5_DIR)/H5Tprecis.c
SOURCES += $(HDF5_DIR)/H5Tstrpad.c
SOURCES += $(HDF5_DIR)/H5Tvisit.c
SOURCES += $(HDF5_DIR)/H5Tvlen.c
SOURCES += $(HDF5_DIR)/H5TS.c
SOURCES += $(HDF5_DIR)/H5VM.c
SOURCES += $(HDF5_DIR)/H5WB.c
SOURCES += $(HDF5_DIR)/H5Z.c
SOURCES += $(HDF5_DIR)/H5Zdeflate.c
SOURCES += $(HDF5_DIR)/H5Zfletcher32.c
SOURCES += $(HDF5_DIR)/H5Znbit.c
SOURCES += $(HDF5_DIR)/H5Zscaleoffset.c
SOURCES += $(HDF5_DIR)/H5Zshuffle.c
SOURCES += $(HDF5_DIR)/H5Zszip.c
SOURCES += $(HDF5_DIR)/H5Ztrans.c

SOURCES += $(HDF5_DIR)/$(OS_LINUX)/H5Tinit.c

SOURCES += $(HDF5_DIR)/H5lib_settings.c

# H5Tinit.c is architecture specific
SOURCES += $(HDF5_DIR)/$(OS_LINUX)/H5Tinit.c

ifeq ($(WITH_BLOSC),YES)
SOURCES += $(HDF5_DIR)/blosc_filter.c
endif	

endif # ($(WITH_HDF5),YES)


ifeq ($(WITH_SZIP),YES)

HEADERS += $(SZIP_DIR)/$(OS_DEF)/SZconfig.h
HEADERS += $(SZIP_DIR)/$(OS_DEF)/rice.h
HEADERS += $(SZIP_DIR)/$(OS_DEF)/ricehdf.h
HEADERS += $(SZIP_DIR)/$(OS_DEF)/szip_adpt.h
HEADERS += $(SZIP_DIR)/$(OS_DEF)/szlib.h

SOURCES += $(SZIP_DIR)/encoding.c
SOURCES += $(SZIP_DIR)/rice.c
SOURCES += $(SZIP_DIR)/sz_api.c

endif # ($(WITH_SZIP),YES)



ifeq ($(WITH_XML2),YES)

#   Need _REENTRANT flag on Linux for threads to build correctly
USR_CFLAGS_Linux += -D_REENTRANT

#HEADERS += $(XML2_DIR)/$(OS_LINUX)/config_32.h
#HEADERS += $(XML2_DIR)/$(OS_LINUX)/config_64.h

HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/DOCBparser.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/globals.h 
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/tree.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlregexp.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/HTMLparser.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/HTMLtree.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/SAX.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/SAX2.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/c14n.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/catalog.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/chvalid.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/debugXML.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/dict.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/encoding.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/entities.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/hash.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/list.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/nanoftp.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/nanohttp.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/parser.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/parserInternals.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/pattern.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/relaxng.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/schemasInternals.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/schematron.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/threads.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/uri.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/valid.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xinclude.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xlink.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlIO.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlautomata.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlerror.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlexports.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlmemory.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlreader.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlsave.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlschemas.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlschemastypes.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xpointer.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlstring.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlunicode.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlversion.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlwriter.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xpath.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xpathInternals.h
HEADERS += $(XML2_DIR)/$(OS_DEF)/libxml/xmlmodule.h

SOURCES += $(XML2_DIR)/buf.c
SOURCES += $(XML2_DIR)/c14n.c
SOURCES += $(XML2_DIR)/catalog.c
SOURCES += $(XML2_DIR)/chvalid.c
SOURCES += $(XML2_DIR)/debugXML.c
SOURCES += $(XML2_DIR)/dict.c
SOURCES += $(XML2_DIR)/DOCBparser.c
SOURCES += $(XML2_DIR)/encoding.c
SOURCES += $(XML2_DIR)/entities.c
SOURCES += $(XML2_DIR)/error.c
SOURCES += $(XML2_DIR)/globals.c
SOURCES += $(XML2_DIR)/hash.c
SOURCES += $(XML2_DIR)/HTMLparser.c
SOURCES += $(XML2_DIR)/HTMLtree.c
SOURCES += $(XML2_DIR)/legacy.c
SOURCES += $(XML2_DIR)/list.c

SOURCES += $(XML2_DIR)/parser.c
SOURCES += $(XML2_DIR)/parserInternals.c
SOURCES += $(XML2_DIR)/pattern.c
SOURCES += $(XML2_DIR)/relaxng.c
SOURCES += $(XML2_DIR)/SAX2.c
SOURCES += $(XML2_DIR)/SAX.c
SOURCES += $(XML2_DIR)/schematron.c
SOURCES += $(XML2_DIR)/threads.c
SOURCES += $(XML2_DIR)/tree.c
SOURCES += $(XML2_DIR)/uri.c
SOURCES += $(XML2_DIR)/valid.c
SOURCES += $(XML2_DIR)/xinclude.c
SOURCES += $(XML2_DIR)/xlink.c
SOURCES += $(XML2_DIR)/xmlIO.c
SOURCES += $(XML2_DIR)/xmlmemory.c
SOURCES += $(XML2_DIR)/xmlreader.c
SOURCES += $(XML2_DIR)/xmlregexp.c
SOURCES += $(XML2_DIR)/xmlmodule.c
SOURCES += $(XML2_DIR)/xmlsave.c
SOURCES += $(XML2_DIR)/xmlschemas.c
SOURCES += $(XML2_DIR)/xmlschemastypes.c
SOURCES += $(XML2_DIR)/xmlunicode.c
SOURCES += $(XML2_DIR)/xmlwriter.c
SOURCES += $(XML2_DIR)/xpath.c
SOURCES += $(XML2_DIR)/xpointer.c
SOURCES += $(XML2_DIR)/xmlstring.c

endif # ($(XML2_EXTERNAL),NO)





ifeq ($(WITH_BLOSC),YES)

BLOSC_PATH:=$(BLOSC_DIR)/blosc
INTCLIBS_PATH:=$(BLOSC_DIR)/internal-complibs
ZSTD_PATH:=$(INTCLIBS_PATH)/zstd-1.3.0
SNAPPY_PATH:=$(INTCLIBS_PATH)/snappy-1.1.1
LZ4_PATH:=$(INTCLIBS_PATH)/lz4-1.7.5

# Only exists in bloscSrc
USR_CFLAGS += -DHAVE_ZSTD

USR_INCLUDES += -I$(where_am_I)$(ZSTD_PATH)

SOURCES += $(ZSTD_PATH)/common/entropy_common.c
SOURCES += $(ZSTD_PATH)/common/error_private.c
SOURCES += $(ZSTD_PATH)/common/fse_decompress.c
SOURCES += $(ZSTD_PATH)/common/pool.c
SOURCES += $(ZSTD_PATH)/common/threading.c
SOURCES += $(ZSTD_PATH)/common/xxhash.c
SOURCES += $(ZSTD_PATH)/common/zstd_common.c
SOURCES += $(ZSTD_PATH)/compress/fse_compress.c
SOURCES += $(ZSTD_PATH)/compress/huf_compress.c
SOURCES += $(ZSTD_PATH)/compress/zstd_compress.c
SOURCES += $(ZSTD_PATH)/compress/zstdmt_compress.c
SOURCES += $(ZSTD_PATH)/decompress/huf_decompress.c
SOURCES += $(ZSTD_PATH)/decompress/zstd_decompress.c

# Only exists in bloscSrc
USR_CFLAGS += -DHAVE_SNAPPY
SOURCES += $(SNAPPY_PATH)/snappy.cc
SOURCES += $(SNAPPY_PATH)/snappy-c.cc
SOURCES += $(SNAPPY_PATH)/snappy-sinksource.cc
SOURCES += $(SNAPPY_PATH)/snappy-stubs-internal.cc

# Only exists in bloscSrc
USR_CFLAGS += -DHAVE_LZ4
SOURCES += $(LZ4_PATH)/lz4.c
SOURCES += $(LZ4_PATH)/lz4hc.c



HEADERS += $(BLOSC_PATH)/blosc.h
HEADERS += $(BLOSC_PATH)/blosc-export.h

SOURCES += $(BLOSC_PATH)/bitshuffle-generic.c
SOURCES += $(BLOSC_PATH)/blosc.c
SOURCES += $(BLOSC_PATH)/blosclz.c
SOURCES += $(BLOSC_PATH)/shuffle.c
SOURCES += $(BLOSC_PATH)/shuffle-generic.c

# Don't have any information about the following variables
ifeq ($(BLOSC_SSE2),YES)
SOURCES += $(BLOSC_PATH)/shuffle-sse2.c
SOURCES += $(BLOSC_PATH)/bitshuffle-sse2.c
endif
ifeq ($(BLOSC_AVX2),YES)
SOURCES += $(BLOSC_PATH)/shuffle-avx2.c 
SOURCES += $(BLOSC_PATH)/bitshuffle-avx2.c
endif

endif # ($(WITH_BLOSC),YES)




ifeq ($(WITH_TIFF),YES)
#ifeq ($(TIFF_EXTERNAL),NO)

HEADERS += $(TIFF_DIR)/$(OS_DEF)/tiff.h 
HEADERS += $(TIFF_DIR)/$(OS_DEF)/tiffio.h 
HEADERS += $(TIFF_DIR)/$(OS_DEF)/tiffvers.h 
HEADERS += $(TIFF_DIR)/$(OS_LINUX)/tiffconf.h 
HEADERS += $(TIFF_DIR)/$(OS_LINUX)/tiffconf_32.h
HEADERS += $(TIFF_DIR)/$(OS_LINUX)/tiffconf_64.h

SOURCES += $(TIFF_DIR)/tif_aux.c
SOURCES += $(TIFF_DIR)/tif_close.c
SOURCES += $(TIFF_DIR)/tif_codec.c
SOURCES += $(TIFF_DIR)/tif_color.c
SOURCES += $(TIFF_DIR)/tif_compress.c
SOURCES += $(TIFF_DIR)/tif_dir.c
SOURCES += $(TIFF_DIR)/tif_dirinfo.c
SOURCES += $(TIFF_DIR)/tif_dirread.c
SOURCES += $(TIFF_DIR)/tif_dirwrite.c
SOURCES += $(TIFF_DIR)/tif_dumpmode.c
SOURCES += $(TIFF_DIR)/tif_error.c
SOURCES += $(TIFF_DIR)/tif_extension.c
SOURCES += $(TIFF_DIR)/tif_fax3.c
SOURCES += $(TIFF_DIR)/tif_fax3sm.c
SOURCES += $(TIFF_DIR)/tif_flush.c
SOURCES += $(TIFF_DIR)/tif_getimage.c
SOURCES += $(TIFF_DIR)/tif_jbig.c
SOURCES += $(TIFF_DIR)/tif_jpeg.c
SOURCES += $(TIFF_DIR)/tif_jpeg_12.c
SOURCES += $(TIFF_DIR)/tif_luv.c
SOURCES += $(TIFF_DIR)/tif_lzw.c
SOURCES += $(TIFF_DIR)/tif_next.c
SOURCES += $(TIFF_DIR)/tif_ojpeg.c
SOURCES += $(TIFF_DIR)/tif_open.c
SOURCES += $(TIFF_DIR)/tif_packbits.c
SOURCES += $(TIFF_DIR)/tif_pixarlog.c
SOURCES += $(TIFF_DIR)/tif_predict.c
SOURCES += $(TIFF_DIR)/tif_print.c
SOURCES += $(TIFF_DIR)/tif_read.c
SOURCES += $(TIFF_DIR)/tif_strip.c
#	#SOURCES += $(TIFF_DIR)/tif_stream.cpp
SOURCES += $(TIFF_DIR)/tif_swab.c
SOURCES += $(TIFF_DIR)/tif_thunder.c
SOURCES += $(TIFF_DIR)/tif_tile.c
SOURCES += $(TIFF_DIR)/tif_version.c
SOURCES += $(TIFF_DIR)/tif_warning.c
SOURCES += $(TIFF_DIR)/tif_write.c
SOURCES += $(TIFF_DIR)/tif_zip.c
SOURCES += $(TIFF_DIR)/tif_unix.c



# endif # ($(TIFF_EXTERNAL),NO)
endif # ($(WITH_TIFF),YES)
# #############################################################################################



ifeq ($(WITH_ZLIB),YES)
#ifeq ($(ZLIB_EXTERNAL),NO)	

USR_INCLUDES += -I$(where_am_I)$(ZLIB_DIR)/$(OS_LINUX)
USR_INCLUDES += -I$(where_am_I)$(ZLIB_DIR)/$(OS_DEF)

HEADERS += $(ZLIB_DIR)/$(OS_LINUX)/zconf.h
HEADERS += $(ZLIB_DIR)/$(OS_DEF)/zlib.h

SOURCES += $(ZLIB_DIR)/adler32.c
SOURCES += $(ZLIB_DIR)/compress.c
SOURCES += $(ZLIB_DIR)/crc32.c
SOURCES += $(ZLIB_DIR)/deflate.c
SOURCES += $(ZLIB_DIR)/gzclose.c
SOURCES += $(ZLIB_DIR)/gzlib.c
SOURCES += $(ZLIB_DIR)/gzread.c
SOURCES += $(ZLIB_DIR)/gzwrite.c
SOURCES += $(ZLIB_DIR)/infback.c
SOURCES += $(ZLIB_DIR)/inffast.c
SOURCES += $(ZLIB_DIR)/inflate.c
SOURCES += $(ZLIB_DIR)/inftrees.c
SOURCES += $(ZLIB_DIR)/trees.c
SOURCES += $(ZLIB_DIR)/uncompr.c
SOURCES += $(ZLIB_DIR)/zutil.c

#endif # ($(ZLIB_EXTERNAL),NO)	
endif # ($(WITH_ZLIB),YES)



ifeq ($(WITH_JPEG),YES)
ifeq ($(JPEG_EXTERNAL),NO)
USR_INCLUDES += -I$(where_am_I)$(JPEG_DIR)/$(OS_LINUX)
USR_INCLUDES += -I$(where_am_I)$(JPEG_DIR)/$(OS_DEF)

HEADERS += $(JPEG_DIR)/$(OS_DEF)/jpeglib.h
HEADERS += $(JPEG_DIR)/$(OS_DEF)/jerror.h  
HEADERS += $(JPEG_DIR)/$(OS_LINUX)/jconfig.h 
HEADERS += $(JPEG_DIR)/$(OS_LINUX)/jmorecfg.h 

SOURCES += $(JPEG_DIR)/jaricom.c 
SOURCES += $(JPEG_DIR)/jcapimin.c 
SOURCES += $(JPEG_DIR)/jcapistd.c 
SOURCES += $(JPEG_DIR)/jcarith.c 
SOURCES += $(JPEG_DIR)/jccoefct.c 
SOURCES += $(JPEG_DIR)/jccolor.c
SOURCES += $(JPEG_DIR)/jcdctmgr.c 
SOURCES += $(JPEG_DIR)/jchuff.c 
SOURCES += $(JPEG_DIR)/jcinit.c 
SOURCES += $(JPEG_DIR)/jcmainct.c 
SOURCES += $(JPEG_DIR)/jcmarker.c 
SOURCES += $(JPEG_DIR)/jcmaster.c
SOURCES += $(JPEG_DIR)/jcomapi.c 
SOURCES += $(JPEG_DIR)/jcparam.c 
SOURCES += $(JPEG_DIR)/jcprepct.c 
SOURCES += $(JPEG_DIR)/jcsample.c 
SOURCES += $(JPEG_DIR)/jctrans.c 
SOURCES += $(JPEG_DIR)/jdapimin.c
SOURCES += $(JPEG_DIR)/jdapistd.c 
SOURCES += $(JPEG_DIR)/jdarith.c 
SOURCES += $(JPEG_DIR)/jdatadst.c 
SOURCES += $(JPEG_DIR)/jdatasrc.c 
SOURCES += $(JPEG_DIR)/jdcoefct.c 
SOURCES += $(JPEG_DIR)/jdcolor.c
SOURCES += $(JPEG_DIR)/jddctmgr.c 
SOURCES += $(JPEG_DIR)/jdhuff.c 
SOURCES += $(JPEG_DIR)/jdinput.c 
SOURCES += $(JPEG_DIR)/jdmainct.c 
SOURCES += $(JPEG_DIR)/jdmarker.c 
SOURCES += $(JPEG_DIR)/jdmaster.c
SOURCES += $(JPEG_DIR)/jdmerge.c 
SOURCES += $(JPEG_DIR)/jdpostct.c 
SOURCES += $(JPEG_DIR)/jdsample.c 
SOURCES += $(JPEG_DIR)/jdtrans.c 
SOURCES += $(JPEG_DIR)/jerror.c 
SOURCES += $(JPEG_DIR)/jfdctflt.c
SOURCES += $(JPEG_DIR)/jfdctfst.c 
SOURCES += $(JPEG_DIR)/jfdctint.c
SOURCES += $(JPEG_DIR)/jidctflt.c 
SOURCES += $(JPEG_DIR)/jidctfst.c 
SOURCES += $(JPEG_DIR)/jidctint.c 
SOURCES += $(JPEG_DIR)/jquant1.c
SOURCES += $(JPEG_DIR)/jquant2.c 
SOURCES += $(JPEG_DIR)/jutils.c 
SOURCES += $(JPEG_DIR)/jmemmgr.c
SOURCES += $(JPEG_DIR)/jmemnobs.c
endif # ($(JPEG_EXTERNAL),NO)
LIB_SYS_LIBS += jpeg
endif # ($(WITH_JPEG),YES)





ifeq ($(WITH_NETCDF),YES)
#ifeq ($(NETCDF_EXTERNAL),NO)

USR_INCLUDES += -I$(where_am_I)$(NETCDF_DIR)/inc
USR_INCLUDES += -I$(where_am_I)$(NETCDF_DIR)/$(OS_LINUX)
USR_INCLUDES += -I$(where_am_I)$(NETCDF_DIR)/$(OS_DEF)

HEADERS += $(NETCDF_DIR)/$(OS_DEF)/netcdf.h

SOURCES += $(NETCDF_DIR)/libsrc/attr.c
SOURCES += $(NETCDF_DIR)/libsrc/dim.c
SOURCES += $(NETCDF_DIR)/libsrc/lookup3.c
SOURCES += $(NETCDF_DIR)/libsrc/nc.c
SOURCES += $(NETCDF_DIR)/libsrc/nc3dispatch.c
SOURCES += $(NETCDF_DIR)/libsrc/nclistmgr.c
SOURCES += $(NETCDF_DIR)/libsrc/ncx.c
SOURCES += $(NETCDF_DIR)/libsrc/posixio.c
SOURCES += $(NETCDF_DIR)/libsrc/putget.c
SOURCES += $(NETCDF_DIR)/libsrc/string.c
SOURCES += $(NETCDF_DIR)/libsrc/utf8proc.c
SOURCES += $(NETCDF_DIR)/libsrc/v1hpg.c
SOURCES += $(NETCDF_DIR)/libsrc/var.c

SOURCES += $(NETCDF_DIR)/libdispatch/att.c
SOURCES += $(NETCDF_DIR)/libdispatch/dim1.c
SOURCES += $(NETCDF_DIR)/libdispatch/dispatch.c
SOURCES += $(NETCDF_DIR)/libdispatch/error.c
SOURCES += $(NETCDF_DIR)/libdispatch/file.c
SOURCES += $(NETCDF_DIR)/libdispatch/nc_uri.c
SOURCES += $(NETCDF_DIR)/libdispatch/var1.c

SOURCES += $(NETCDF_DIR)/liblib/stub.c
#endif # ($(NETCDF_EXTERNAL),NO)
endif # ($(WITH_NETCDF),YES)





# db rule is the default in RULES_E3, so add the empty one

db:
