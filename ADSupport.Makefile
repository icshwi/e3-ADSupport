#
#  Copyright (c) 2019      Jeong Han Lee
#  Copyright (c) 2019      European Spallation Source ERIC

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
# Author  : Jeong Han Lee
# email   : jeonghan.lee@gmail.com
# Date    : Monday, September  9 11:53:48 CEST 2019
# version : 0.0.6
#

## The following lines are mandatory, please don't change them.
where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(E3_REQUIRE_CONFIG)/DECOUPLE_FLAGS

EXCLUDE_ARCHS = linux-ppc64e6500
EXCLUDE_ARCHS += linux-corei7-poky



APP:=supportApp

OS_default:=os/default
OS_Linux:=os/Linux

USR_CFLAGS   += -Wno-unused-variable
USR_CFLAGS   += -Wno-unused-function
USR_CFLAGS   += -Wno-unused-but-set-variable
USR_CPPFLAGS += -Wno-unused-variable
USR_CPPFLAGS += -Wno-unused-function
USR_CPPFLAGS += -Wno-unused-but-set-variable


WITH_GRAPHICSMAGICK:=NO
ifeq ($(WITH_GRAPHICSMAGICK),YES)
GRAPHICSMAGICK_EXTERNAL:=NO
ifeq ($(GRAPHICSMAGICK_EXTERNAL),NO)

GMTOP:=$(APP)/GraphicsMagickSrc


# ### filter
# USR_INCLUDES += -I$(where_am_I)$(GMTOP)
# USR_INCLUDES += -I$(where_am_I)$(GMTOP)/lcms/inc
# #USR_INCLUDES += -I$(where_am_I)$(GMTOP)/ttf/include

# # USR_CFLAGS += -D_MAGICKLIB_
# # ifeq ($(GRAPHICSMAGICK_PREFIX_SYMBOLS),YES)
# # USR_CFLAGS += -DPREFIX_MAGICK_SYMBOLS
# # endif

# # SOURCES += $(GMTOP)/filters/analyze.c

# USR_CFLAGS += -DBZ_EXPORT

# HEADERS += $(GMTOP)/bzlib/bzlib.h

# SOURCES += $(GMTOP)/bzlib/blocksort.c
# SOURCES += $(GMTOP)/bzlib/bzlib.c
# SOURCES += $(GMTOP)/bzlib/compress.c
# SOURCES += $(GMTOP)/bzlib/crctable.c
# SOURCES += $(GMTOP)/bzlib/decompress.c
# SOURCES += $(GMTOP)/bzlib/huffman.c
# SOURCES += $(GMTOP)/bzlib/randtable.c



endif # ($(GRAPHICSMAGICK_EXTERNAL),NO)
endif # ($(WITH_GRAPHICSMAGICK),YES)





ifeq ($(WITH_NEXUS),YES)
NEXUS_EXTERNAL:=NO
ifeq ($(NEXUS_EXTERNAL),NO)

NEXUSTOP:=$(APP)/nexusSrc

HEADERS += $(NEXUSTOP)/$(OS_default)/napi.h
HEADERS += $(NEXUSTOP)/$(OS_default)/napiconfig.h
HEADERS += $(NEXUSTOP)/$(OS_Linux)/nxconfig.h

SOURCES += $(NEXUSTOP)/napi.c
SOURCES += $(NEXUSTOP)/napi5.c
SOURCES += $(NEXUSTOP)/napiu.c
SOURCES += $(NEXUSTOP)/nxdataset.c
SOURCES += $(NEXUSTOP)/nxio.c
SOURCES += $(NEXUSTOP)/nxstack.c
SOURCES += $(NEXUSTOP)/nxxml.c
SOURCES += $(NEXUSTOP)/stptok.c

USR_CFLAGS += -DHDF5 -D_FILE_OFFSET_BITS=64

# Travis/ubuntu 12.04 tweak: persuade the hdf5 library build to use API v18 over v16
#USR_CFLAGS += -DH5_NO_DEPRECATED_SYMBOLS -DH5Gopen_vers=2


endif # ($(NEXUS_EXTERNAL),NO)
endif # ($(WITH_NEXUS),YES)






ifeq ($(WITH_HDF5),YES)
HDF5_EXTERNAL:=YES
ifeq ($(HDF5_EXTERNAL),NO)


HDF5HLTOP = $(APP)/hdf5_hlSrc


HEADERS += $(HDF5HLTOP)/H5DOpublic.h
HEADERS += $(HDF5HLTOP)/H5DSpublic.h
HEADERS += $(HDF5HLTOP)/H5IMpublic.h
HEADERS += $(HDF5HLTOP)/H5LDpublic.h
HEADERS += $(HDF5HLTOP)/H5LTpublic.h
HEADERS += $(HDF5HLTOP)/H5PTpublic.h
HEADERS += $(HDF5HLTOP)/H5TBpublic.h
HEADERS += $(HDF5HLTOP)/hdf5_hl.h

SOURCES += $(HDF5HLTOP)/H5DO.c
SOURCES += $(HDF5HLTOP)/H5DS.c
SOURCES += $(HDF5HLTOP)/H5IM.c
SOURCES += $(HDF5HLTOP)/H5LD.c
SOURCES += $(HDF5HLTOP)/H5LT.c
SOURCES += $(HDF5HLTOP)/H5LTanalyze.c
SOURCES += $(HDF5HLTOP)/H5LTparse.c
SOURCES += $(HDF5HLTOP)/H5PT.c
SOURCES += $(HDF5HLTOP)/H5TB.c

HDF5PLUGINTOP = $(APP)/hdf5PluginSrc

USR_CFLAGS_Linux += -std=c99
ifeq ($(WITH_BLOSC),YES)
SOURCES += $(HDF5PLUGINTOP)/blosc_filter.c
SOURCES += $(HDF5PLUGINTOP)/blosc_plugin.c
USR_CFLAGS += -DH5_HAVE_FILTER_BLOSC
endif

ifeq ($(WITH_BITSHUFFLE),YES)
SOURCES += $(HDF5PLUGINTOP)/bshuf_h5filter.c
SOURCES += $(HDF5PLUGINTOP)/bshuf_h5plugin.c
SOURCES += $(HDF5PLUGINTOP)/H5Zlz4.c
SOURCES += $(HDF5PLUGINTOP)/lz4_h5plugin.c
USR_CFLAGS += -DH5_HAVE_FILTER_LZ4
USR_CFLAGS += -DH5_HAVE_FILTER_BSHUF
endif


HDF5TOP = $(APP)/hdf5Src

USR_CFLAGS += -D NDEBUG

USR_INCLUDES += -I$(where_am_I)$(HDF5TOP)
USR_INCLUDES += -I$(where_am_I)$(HDF5TOP)/$(OS_Linux)
USR_INCLUDES += -I$(where_am_I)$(HDF5TOP)/$(OS_default)


HEADERS += $(HDF5TOP)/$(OS_default)/H5ACpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5api_adpt.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Apublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5B2public.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Bpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Cpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Dpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Epubgen.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Epublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FDcore.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FDdirect.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FDfamily.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FDlog.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FDmpi.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FDmpio.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FDmulti.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FDpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FDsec2.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FDstdio.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FDwindows.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5FSpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Fpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Gpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5HFpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5HGpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5HLpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Ipublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Lpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5MMpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Opublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5overflow.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5PLextern.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5PLpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Ppublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5public.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Rpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Spublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Tpublic.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5version.h
HEADERS += $(HDF5TOP)/$(OS_default)/H5Zpublic.h

HEADERS += $(HDF5TOP)/$(OS_default)/hdf5.h
HEADERS += $(HDF5TOP)/$(OS_Linux)/H5pubconf.h

HEADERS += $(HDF5TOP)/blosc_filter.h
HEADERS += $(HDF5TOP)/lz4_h5filter.h
HEADERS += $(HDF5TOP)/bshuf_h5filter.h

HEADERS += $(HDF5TOP)/$(OS_Linux)/H5pubconf_32.h
HEADERS += $(HDF5TOP)/$(OS_Linux)/H5pubconf_64.h


SOURCES += $(HDF5TOP)/H5.c
SOURCES += $(HDF5TOP)/H5checksum.c
SOURCES += $(HDF5TOP)/H5dbg.c
SOURCES += $(HDF5TOP)/H5system.c
SOURCES += $(HDF5TOP)/H5timer.c
SOURCES += $(HDF5TOP)/H5trace.c
SOURCES += $(HDF5TOP)/H5A.c
SOURCES += $(HDF5TOP)/H5Abtree2.c
SOURCES += $(HDF5TOP)/H5Adense.c
SOURCES += $(HDF5TOP)/H5Adeprec.c
SOURCES += $(HDF5TOP)/H5Aint.c
SOURCES += $(HDF5TOP)/H5Atest.c
SOURCES += $(HDF5TOP)/H5AC.c
SOURCES += $(HDF5TOP)/H5AClog.c
SOURCES += $(HDF5TOP)/H5ACdbg.c
SOURCES += $(HDF5TOP)/H5ACproxy_entry.c
SOURCES += $(HDF5TOP)/H5B.c
SOURCES += $(HDF5TOP)/H5Bcache.c
SOURCES += $(HDF5TOP)/H5Bdbg.c
SOURCES += $(HDF5TOP)/H5B2.c
SOURCES += $(HDF5TOP)/H5B2cache.c
SOURCES += $(HDF5TOP)/H5B2dbg.c
SOURCES += $(HDF5TOP)/H5B2hdr.c
SOURCES += $(HDF5TOP)/H5B2int.c
SOURCES += $(HDF5TOP)/H5B2internal.c
SOURCES += $(HDF5TOP)/H5B2leaf.c
SOURCES += $(HDF5TOP)/H5B2stat.c
SOURCES += $(HDF5TOP)/H5B2test.c
SOURCES += $(HDF5TOP)/H5C.c
SOURCES += $(HDF5TOP)/H5Cdbg.c
SOURCES += $(HDF5TOP)/H5Cepoch.c
SOURCES += $(HDF5TOP)/H5Cimage.c
SOURCES += $(HDF5TOP)/H5Clog.c
SOURCES += $(HDF5TOP)/H5Cprefetched.c
SOURCES += $(HDF5TOP)/H5Cquery.c
SOURCES += $(HDF5TOP)/H5Ctag.c
SOURCES += $(HDF5TOP)/H5Ctest.c
SOURCES += $(HDF5TOP)/H5CS.c
SOURCES += $(HDF5TOP)/H5D.c
SOURCES += $(HDF5TOP)/H5Dbtree.c
SOURCES += $(HDF5TOP)/H5Dbtree2.c
SOURCES += $(HDF5TOP)/H5Dchunk.c
SOURCES += $(HDF5TOP)/H5Dcompact.c
SOURCES += $(HDF5TOP)/H5Dcontig.c
SOURCES += $(HDF5TOP)/H5Ddbg.c
SOURCES += $(HDF5TOP)/H5Ddeprec.c
SOURCES += $(HDF5TOP)/H5Dearray.c
SOURCES += $(HDF5TOP)/H5Defl.c
SOURCES += $(HDF5TOP)/H5Dfarray.c
SOURCES += $(HDF5TOP)/H5Dfill.c
SOURCES += $(HDF5TOP)/H5Dint.c
SOURCES += $(HDF5TOP)/H5Dio.c
SOURCES += $(HDF5TOP)/H5Dlayout.c
SOURCES += $(HDF5TOP)/H5Dnone.c
SOURCES += $(HDF5TOP)/H5Doh.c
SOURCES += $(HDF5TOP)/H5Dscatgath.c
SOURCES += $(HDF5TOP)/H5Dselect.c
SOURCES += $(HDF5TOP)/H5Dsingle.c
SOURCES += $(HDF5TOP)/H5Dtest.c
SOURCES += $(HDF5TOP)/H5Dvirtual.c
SOURCES += $(HDF5TOP)/H5E.c
SOURCES += $(HDF5TOP)/H5Edeprec.c
SOURCES += $(HDF5TOP)/H5Eint.c
SOURCES += $(HDF5TOP)/H5EA.c
SOURCES += $(HDF5TOP)/H5EAcache.c
SOURCES += $(HDF5TOP)/H5EAdbg.c
SOURCES += $(HDF5TOP)/H5EAdblkpage.c
SOURCES += $(HDF5TOP)/H5EAdblock.c
SOURCES += $(HDF5TOP)/H5EAhdr.c
SOURCES += $(HDF5TOP)/H5EAiblock.c
SOURCES += $(HDF5TOP)/H5EAint.c
SOURCES += $(HDF5TOP)/H5EAsblock.c
SOURCES += $(HDF5TOP)/H5EAstat.c
SOURCES += $(HDF5TOP)/H5EAtest.c
SOURCES += $(HDF5TOP)/H5F.c
SOURCES += $(HDF5TOP)/H5Faccum.c
SOURCES += $(HDF5TOP)/H5Fcwfs.c
SOURCES += $(HDF5TOP)/H5Fdbg.c
SOURCES += $(HDF5TOP)/H5Fdeprec.c
SOURCES += $(HDF5TOP)/H5Fefc.c
SOURCES += $(HDF5TOP)/H5Ffake.c
SOURCES += $(HDF5TOP)/H5Fint.c
SOURCES += $(HDF5TOP)/H5Fio.c
SOURCES += $(HDF5TOP)/H5Fmount.c
SOURCES += $(HDF5TOP)/H5Fquery.c
SOURCES += $(HDF5TOP)/H5Fsfile.c
SOURCES += $(HDF5TOP)/H5Fspace.c
SOURCES += $(HDF5TOP)/H5Fsuper.c
SOURCES += $(HDF5TOP)/H5Fsuper_cache.c
SOURCES += $(HDF5TOP)/H5Ftest.c
SOURCES += $(HDF5TOP)/H5FA.c
SOURCES += $(HDF5TOP)/H5FAcache.c
SOURCES += $(HDF5TOP)/H5FAdbg.c
SOURCES += $(HDF5TOP)/H5FAdblock.c
SOURCES += $(HDF5TOP)/H5FAdblkpage.c
SOURCES += $(HDF5TOP)/H5FAhdr.c
SOURCES += $(HDF5TOP)/H5FAint.c
SOURCES += $(HDF5TOP)/H5FAstat.c
SOURCES += $(HDF5TOP)/H5FAtest.c
SOURCES += $(HDF5TOP)/H5FD.c
SOURCES += $(HDF5TOP)/H5FDcore.c
SOURCES += $(HDF5TOP)/H5FDfamily.c
SOURCES += $(HDF5TOP)/H5FDint.c
SOURCES += $(HDF5TOP)/H5FDlog.c
SOURCES += $(HDF5TOP)/H5FDmulti.c
SOURCES += $(HDF5TOP)/H5FDsec2.c
SOURCES += $(HDF5TOP)/H5FDspace.c
SOURCES += $(HDF5TOP)/H5FDstdio.c
SOURCES += $(HDF5TOP)/H5FDtest.c
SOURCES += $(HDF5TOP)/H5FL.c
SOURCES += $(HDF5TOP)/H5FO.c
SOURCES += $(HDF5TOP)/H5FS.c
SOURCES += $(HDF5TOP)/H5FScache.c
SOURCES += $(HDF5TOP)/H5FSdbg.c
SOURCES += $(HDF5TOP)/H5FSint.c
SOURCES += $(HDF5TOP)/H5FSsection.c
SOURCES += $(HDF5TOP)/H5FSstat.c
SOURCES += $(HDF5TOP)/H5FStest.c
SOURCES += $(HDF5TOP)/H5G.c
SOURCES += $(HDF5TOP)/H5Gbtree2.c
SOURCES += $(HDF5TOP)/H5Gcache.c
SOURCES += $(HDF5TOP)/H5Gcompact.c
SOURCES += $(HDF5TOP)/H5Gdense.c
SOURCES += $(HDF5TOP)/H5Gdeprec.c
SOURCES += $(HDF5TOP)/H5Gent.c
SOURCES += $(HDF5TOP)/H5Gint.c
SOURCES += $(HDF5TOP)/H5Glink.c
SOURCES += $(HDF5TOP)/H5Gloc.c
SOURCES += $(HDF5TOP)/H5Gname.c
SOURCES += $(HDF5TOP)/H5Gnode.c
SOURCES += $(HDF5TOP)/H5Gobj.c
SOURCES += $(HDF5TOP)/H5Goh.c
SOURCES += $(HDF5TOP)/H5Groot.c
SOURCES += $(HDF5TOP)/H5Gstab.c
SOURCES += $(HDF5TOP)/H5Gtest.c
SOURCES += $(HDF5TOP)/H5Gtraverse.c
SOURCES += $(HDF5TOP)/H5HF.c
SOURCES += $(HDF5TOP)/H5HFbtree2.c
SOURCES += $(HDF5TOP)/H5HFcache.c
SOURCES += $(HDF5TOP)/H5HFdbg.c
SOURCES += $(HDF5TOP)/H5HFdblock.c
SOURCES += $(HDF5TOP)/H5HFdtable.c
SOURCES += $(HDF5TOP)/H5HFhdr.c
SOURCES += $(HDF5TOP)/H5HFhuge.c
SOURCES += $(HDF5TOP)/H5HFiblock.c
SOURCES += $(HDF5TOP)/H5HFiter.c
SOURCES += $(HDF5TOP)/H5HFman.c
SOURCES += $(HDF5TOP)/H5HFsection.c
SOURCES += $(HDF5TOP)/H5HFspace.c
SOURCES += $(HDF5TOP)/H5HFstat.c
SOURCES += $(HDF5TOP)/H5HFtest.c
SOURCES += $(HDF5TOP)/H5HFtiny.c
SOURCES += $(HDF5TOP)/H5HG.c
SOURCES += $(HDF5TOP)/H5HGcache.c
SOURCES += $(HDF5TOP)/H5HGdbg.c
SOURCES += $(HDF5TOP)/H5HGquery.c
SOURCES += $(HDF5TOP)/H5HL.c
SOURCES += $(HDF5TOP)/H5HLcache.c
SOURCES += $(HDF5TOP)/H5HLdbg.c
SOURCES += $(HDF5TOP)/H5HLint.c
SOURCES += $(HDF5TOP)/H5HLprfx.c
SOURCES += $(HDF5TOP)/H5HLdblk.c
SOURCES += $(HDF5TOP)/H5HP.c
SOURCES += $(HDF5TOP)/H5I.c
SOURCES += $(HDF5TOP)/H5Itest.c
SOURCES += $(HDF5TOP)/H5L.c
SOURCES += $(HDF5TOP)/H5Lexternal.c
SOURCES += $(HDF5TOP)/H5MF.c
SOURCES += $(HDF5TOP)/H5MFaggr.c
SOURCES += $(HDF5TOP)/H5MFdbg.c
SOURCES += $(HDF5TOP)/H5MFsection.c
SOURCES += $(HDF5TOP)/H5MM.c
SOURCES += $(HDF5TOP)/H5MP.c
SOURCES += $(HDF5TOP)/H5MPtest.c
SOURCES += $(HDF5TOP)/H5O.c
SOURCES += $(HDF5TOP)/H5Oainfo.c
SOURCES += $(HDF5TOP)/H5Oalloc.c
SOURCES += $(HDF5TOP)/H5Oattr.c
SOURCES += $(HDF5TOP)/H5Oattribute.c
SOURCES += $(HDF5TOP)/H5Obogus.c
SOURCES += $(HDF5TOP)/H5Obtreek.c
SOURCES += $(HDF5TOP)/H5Ocache.c
SOURCES += $(HDF5TOP)/H5Ocache_image.c
SOURCES += $(HDF5TOP)/H5Ochunk.c
SOURCES += $(HDF5TOP)/H5Ocont.c
SOURCES += $(HDF5TOP)/H5Ocopy.c
SOURCES += $(HDF5TOP)/H5Odbg.c
SOURCES += $(HDF5TOP)/H5Odrvinfo.c
SOURCES += $(HDF5TOP)/H5Odtype.c
SOURCES += $(HDF5TOP)/H5Oefl.c
SOURCES += $(HDF5TOP)/H5Ofill.c
SOURCES += $(HDF5TOP)/H5Oflush.c
SOURCES += $(HDF5TOP)/H5Ofsinfo.c
SOURCES += $(HDF5TOP)/H5Oginfo.c
SOURCES += $(HDF5TOP)/H5Olayout.c
SOURCES += $(HDF5TOP)/H5Olinfo.c
SOURCES += $(HDF5TOP)/H5Olink.c
SOURCES += $(HDF5TOP)/H5Omessage.c
SOURCES += $(HDF5TOP)/H5Omtime.c
SOURCES += $(HDF5TOP)/H5Oname.c
SOURCES += $(HDF5TOP)/H5Onull.c
SOURCES += $(HDF5TOP)/H5Opline.c
SOURCES += $(HDF5TOP)/H5Orefcount.c
SOURCES += $(HDF5TOP)/H5Osdspace.c
SOURCES += $(HDF5TOP)/H5Oshared.c
SOURCES += $(HDF5TOP)/H5Oshmesg.c
SOURCES += $(HDF5TOP)/H5Ostab.c
SOURCES += $(HDF5TOP)/H5Otest.c
SOURCES += $(HDF5TOP)/H5Ounknown.c
SOURCES += $(HDF5TOP)/H5P.c
SOURCES += $(HDF5TOP)/H5Pacpl.c
SOURCES += $(HDF5TOP)/H5Pdapl.c
SOURCES += $(HDF5TOP)/H5Pdcpl.c
SOURCES += $(HDF5TOP)/H5Pdeprec.c
SOURCES += $(HDF5TOP)/H5Pdxpl.c
SOURCES += $(HDF5TOP)/H5Pencdec.c
SOURCES += $(HDF5TOP)/H5Pfapl.c
SOURCES += $(HDF5TOP)/H5Pfcpl.c
SOURCES += $(HDF5TOP)/H5Pfmpl.c
SOURCES += $(HDF5TOP)/H5Pgcpl.c
SOURCES += $(HDF5TOP)/H5Pint.c
SOURCES += $(HDF5TOP)/H5Plapl.c
SOURCES += $(HDF5TOP)/H5Plcpl.c
SOURCES += $(HDF5TOP)/H5Pocpl.c
SOURCES += $(HDF5TOP)/H5Pocpypl.c
SOURCES += $(HDF5TOP)/H5Pstrcpl.c
SOURCES += $(HDF5TOP)/H5Ptest.c
SOURCES += $(HDF5TOP)/H5PB.c
SOURCES += $(HDF5TOP)/H5PL.c
SOURCES += $(HDF5TOP)/H5R.c
SOURCES += $(HDF5TOP)/H5Rdeprec.c
SOURCES += $(HDF5TOP)/H5UC.c
SOURCES += $(HDF5TOP)/H5RS.c
SOURCES += $(HDF5TOP)/H5S.c
SOURCES += $(HDF5TOP)/H5Sall.c
SOURCES += $(HDF5TOP)/H5Sdbg.c
SOURCES += $(HDF5TOP)/H5Shyper.c
SOURCES += $(HDF5TOP)/H5Snone.c
SOURCES += $(HDF5TOP)/H5Spoint.c
SOURCES += $(HDF5TOP)/H5Sselect.c
SOURCES += $(HDF5TOP)/H5Stest.c
SOURCES += $(HDF5TOP)/H5SL.c
SOURCES += $(HDF5TOP)/H5SM.c
SOURCES += $(HDF5TOP)/H5SMbtree2.c
SOURCES += $(HDF5TOP)/H5SMcache.c
SOURCES += $(HDF5TOP)/H5SMmessage.c
SOURCES += $(HDF5TOP)/H5SMtest.c
SOURCES += $(HDF5TOP)/H5ST.c
SOURCES += $(HDF5TOP)/H5T.c
SOURCES += $(HDF5TOP)/H5Tarray.c
SOURCES += $(HDF5TOP)/H5Tbit.c
SOURCES += $(HDF5TOP)/H5Tcommit.c
SOURCES += $(HDF5TOP)/H5Tcompound.c
SOURCES += $(HDF5TOP)/H5Tconv.c
SOURCES += $(HDF5TOP)/H5Tcset.c
SOURCES += $(HDF5TOP)/H5Tdbg.c
SOURCES += $(HDF5TOP)/H5Tdeprec.c
SOURCES += $(HDF5TOP)/H5Tenum.c
SOURCES += $(HDF5TOP)/H5Tfields.c
SOURCES += $(HDF5TOP)/H5Tfixed.c
SOURCES += $(HDF5TOP)/H5Tfloat.c
SOURCES += $(HDF5TOP)/H5Tnative.c
SOURCES += $(HDF5TOP)/H5Toffset.c
SOURCES += $(HDF5TOP)/H5Toh.c
SOURCES += $(HDF5TOP)/H5Topaque.c
SOURCES += $(HDF5TOP)/H5Torder.c
SOURCES += $(HDF5TOP)/H5Tpad.c
SOURCES += $(HDF5TOP)/H5Tprecis.c
SOURCES += $(HDF5TOP)/H5Tstrpad.c
SOURCES += $(HDF5TOP)/H5Tvisit.c
SOURCES += $(HDF5TOP)/H5Tvlen.c
SOURCES += $(HDF5TOP)/H5TS.c
SOURCES += $(HDF5TOP)/H5VM.c
SOURCES += $(HDF5TOP)/H5WB.c
SOURCES += $(HDF5TOP)/H5Z.c
SOURCES += $(HDF5TOP)/H5Zdeflate.c
SOURCES += $(HDF5TOP)/H5Zfletcher32.c
SOURCES += $(HDF5TOP)/H5Znbit.c
SOURCES += $(HDF5TOP)/H5Zscaleoffset.c
SOURCES += $(HDF5TOP)/H5Zshuffle.c
SOURCES += $(HDF5TOP)/H5Zszip.c
SOURCES += $(HDF5TOP)/H5Ztrans.c

SOURCES += $(HDF5TOP)/$(OS_Linux)/H5Tinit.c

SOURCES += $(HDF5TOP)/H5lib_settings.c

ifeq ($(WITH_BLOSC),YES)
USR_CFLAGS += -DH5_HAVE_FILTER_BLOSC
SOURCES += $(HDF5TOP)/blosc_filter.c
endif

ifeq ($(WITH_BITSHUFFLE),YES)
USR_CFLAGS += -DH5_HAVE_FILTER_BSHUF
USR_CFLAGS += -DH5_HAVE_FILTER_LZ4
SOURCES += $(HDF5TOP)/bshuf_h5filter.c
SOURCES += $(HDF5TOP)/H5Zlz4.c
endif

SOURCES += $(HDF5TOP)/H5detect.c

else # ($(HDF5_EXTERNAL),NO)
# We have to combine libADSupport with libhdf5, so
# we need to add them here if you do use EXTERNAL HDF5
# We don't use the MPICH2 and OpenMPI, but use serial version in Debian
#
# CentOS    : /usr/local/lib
# ESS Yocto : $(SDKTARGETSYSROOT)/usr/lib64
# Debian    : /usr/lib/x86_64-linux-gnu/hdf5/serial
#
LIB_SYS_LIBS += hdf5
LIB_SYS_LIBS += hdf5_hl

# The followin LDGLAGSs are used for CentOS and Debian together
# It will be no harm in other based OS one.
USR_LDFLAGS  += -L/usr/local/lib
USR_LDFLAGS  += -L/usr/lib/x86_64-linux-gnu/hdf5/serial


ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include
# The following header path is only valid for Debian based system
USR_INCLUDES += -I/usr/include/hdf5/serial
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include
endif

endif # ($(HDF5_EXTERNAL),NO)

endif # ($(WITH_HDF5),YES)





ifeq ($(WITH_BITSHUFFLE),YES)
BITSHUFFLE_EXTERNAL:=NO
ifeq ($(BITSHUFFLE_EXTERNAL),NO)

BITSHUFFLETOP = $(APP)/bitshuffleSrc
USR_CFLAGS_Linux += -std=c99
HEADERS += $(BITSHUFFLETOP)/bitshuffle.h
HEADERS += $(BITSHUFFLETOP)/bitshuffle_core.h

SOURCES += $(BITSHUFFLETOP)/bitshuffle.c
SOURCES += $(BITSHUFFLETOP)/bitshuffle_core.c
SOURCES += $(BITSHUFFLETOP)/iochain.c

HEADERS += $(BITSHUFFLETOP)/lz4/lz4.h
SOURCES += $(BITSHUFFLETOP)/lz4/lz4.c

endif # ($(BITSHUFFLE_EXTERNAL),NO)
endif # ($(WITH_BITSHUFFLE),YES)



ifeq ($(WITH_SZIP),YES)
SZIP_EXTERNAL:=NO
ifeq ($(SZIP_EXTERNAL),NO)


SZIPTOP = $(APP)/szipSrc

USR_INCLUDES += -I$(where_am_I)$(SZIPTOP)/$(OS_default)

HEADERS += $(SZIPTOP)/$(OS_default)/SZconfig.h
HEADERS += $(SZIPTOP)/$(OS_default)/rice.h
HEADERS += $(SZIPTOP)/$(OS_default)/ricehdf.h
HEADERS += $(SZIPTOP)/$(OS_default)/szip_adpt.h
HEADERS += $(SZIPTOP)/$(OS_default)/szlib.h

SOURCES += $(SZIPTOP)/encoding.c
SOURCES += $(SZIPTOP)/rice.c
SOURCES += $(SZIPTOP)/sz_api.c

endif # ($(SZIP_EXTERNAL),NO)
endif # ($(WITH_SZIP),YES)





###
###
### We cannot use XML2 within ADSupport, because of
### config.h/config_32.h/config_64.h
### However, we install libxml2 in CentOS, Yocto Linux
### as the external library
###
### This space will leave here for the future, when
### ....
###
ifeq ($(WITH_XML2),YES)
XML2_EXTERNAL:=YES
ifeq ($(XML2_EXTERNAL),NO)
XML2TOP = $(APP)/xml2Src

# Need _REENTRANT flag on Linux for threads to build correctly
USR_CFLAGS_Linux += -D_REENTRANT

USR_INCLUDES += -I$(where_am_I)$(XML2TOP)
USR_INCLUDES += -I$(where_am_I)$(XML2TOP)/$(OS_Linux)
USR_INCLUDES += -I$(where_am_I)$(XML2TOP)/$(OS_default)/libxml

HEADERS += $(XML2TOP)/$(OS_Linux)/config_32.h
HEADERS += $(XML2TOP)/$(OS_Linux)/config_64.h

HEADERS += $(XML2TOP)/$(OS_default)/libxml/DOCBparser.h 
HEADERS += $(XML2TOP)/$(OS_default)/libxml/globals.h 
HEADERS += $(XML2TOP)/$(OS_default)/libxml/tree.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlregexp.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/HTMLparser.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/HTMLtree.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/SAX.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/SAX2.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/c14n.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/catalog.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/chvalid.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/debugXML.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/dict.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/encoding.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/entities.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/hash.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/list.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/nanoftp.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/nanohttp.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/parser.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/parserInternals.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/pattern.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/relaxng.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/schemasInternals.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/schematron.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/threads.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/uri.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/valid.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xinclude.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xlink.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlIO.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlautomata.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlerror.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlexports.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlmemory.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlreader.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlsave.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlschemas.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlschemastypes.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xpointer.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlstring.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlunicode.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlversion.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlwriter.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xpath.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xpathInternals.h
HEADERS += $(XML2TOP)/$(OS_default)/libxml/xmlmodule.h



SOURCES += $(XML2TOP)/buf.c
SOURCES += $(XML2TOP)/c14n.c
SOURCES += $(XML2TOP)/catalog.c
SOURCES += $(XML2TOP)/chvalid.c
SOURCES += $(XML2TOP)/debugXML.c
SOURCES += $(XML2TOP)/dict.c
SOURCES += $(XML2TOP)/DOCBparser.c
SOURCES += $(XML2TOP)/encoding.c
SOURCES += $(XML2TOP)/entities.c
SOURCES += $(XML2TOP)/error.c
SOURCES += $(XML2TOP)/globals.c
SOURCES += $(XML2TOP)/hash.c
SOURCES += $(XML2TOP)/HTMLparser.c
SOURCES += $(XML2TOP)/HTMLtree.c
SOURCES += $(XML2TOP)/legacy.c
SOURCES += $(XML2TOP)/list.c
SOURCES += $(XML2TOP)/nanoftp.c
SOURCES += $(XML2TOP)/nanohttp.c
SOURCES += $(XML2TOP)/parser.c
SOURCES += $(XML2TOP)/parserInternals.c
SOURCES += $(XML2TOP)/pattern.c
SOURCES += $(XML2TOP)/relaxng.c
SOURCES += $(XML2TOP)/SAX2.c
SOURCES += $(XML2TOP)/SAX.c
SOURCES += $(XML2TOP)/schematron.c
SOURCES += $(XML2TOP)/threads.c
SOURCES += $(XML2TOP)/tree.c
SOURCES += $(XML2TOP)/uri.c
SOURCES += $(XML2TOP)/valid.c
SOURCES += $(XML2TOP)/xinclude.c
SOURCES += $(XML2TOP)/xlink.c
SOURCES += $(XML2TOP)/xmlIO.c
SOURCES += $(XML2TOP)/xmlmemory.c
SOURCES += $(XML2TOP)/xmlreader.c
SOURCES += $(XML2TOP)/xmlregexp.c
SOURCES += $(XML2TOP)/xmlmodule.c
SOURCES += $(XML2TOP)/xmlsave.c
SOURCES += $(XML2TOP)/xmlschemas.c
SOURCES += $(XML2TOP)/xmlschemastypes.c
SOURCES += $(XML2TOP)/xmlunicode.c
SOURCES += $(XML2TOP)/xmlwriter.c
SOURCES += $(XML2TOP)/xpath.c
SOURCES += $(XML2TOP)/xpointer.c
SOURCES += $(XML2TOP)/xmlstring.c

else

LIB_SYS_LIBS += xml2
ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include/libxml2
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include/libxml2
endif
endif # ($(XML2_EXTERNAL),NO)
endif # ($(WITH_XML2),YES)


ifeq ($(WITH_TIFF0),YES)
TIFF_EXTERNAL:=YES
ifeq ($(TIFF_EXTERNAL),NO)

TIFFTOP = $(APP)/tiffSrc

USR_INCLUDES += -I$(where_am_I)$(TIFFTOP)
USR_INCLUDES += -I$(where_am_I)$(TIFFTOP)/$(OS_Linux)
USR_INCLUDES += -I$(where_am_I)$(TIFFTOP)/$(OS_default)


HEADERS += $(TIFFTOP)/$(OS_default)/tiff.h 
HEADERS += $(TIFFTOP)/$(OS_default)/tiffio.h 
HEADERS += $(TIFFTOP)/$(OS_default)/tiffvers.h 
HEADERS += $(TIFFTOP)/$(OS_Linux)/tiffconf.h 
HEADERS += $(TIFFTOP)/$(OS_Linux)/tiffconf_32.h
HEADERS += $(TIFFTOP)/$(OS_Linux)/tiffconf_64.h

SOURCES += $(TIFFTOP)/tif_aux.c
SOURCES += $(TIFFTOP)/tif_close.c
SOURCES += $(TIFFTOP)/tif_codec.c
SOURCES += $(TIFFTOP)/tif_color.c
SOURCES += $(TIFFTOP)/tif_compress.c
SOURCES += $(TIFFTOP)/tif_dir.c
SOURCES += $(TIFFTOP)/tif_dirinfo.c
SOURCES += $(TIFFTOP)/tif_dirread.c
SOURCES += $(TIFFTOP)/tif_dirwrite.c
SOURCES += $(TIFFTOP)/tif_dumpmode.c
SOURCES += $(TIFFTOP)/tif_error.c
SOURCES += $(TIFFTOP)/tif_extension.c
SOURCES += $(TIFFTOP)/tif_fax3.c
SOURCES += $(TIFFTOP)/tif_fax3sm.c
SOURCES += $(TIFFTOP)/tif_flush.c
SOURCES += $(TIFFTOP)/tif_getimage.c
SOURCES += $(TIFFTOP)/tif_jbig.c
SOURCES += $(TIFFTOP)/tif_jpeg.c
SOURCES += $(TIFFTOP)/tif_jpeg_12.c
SOURCES += $(TIFFTOP)/tif_luv.c
SOURCES += $(TIFFTOP)/tif_lzw.c
SOURCES += $(TIFFTOP)/tif_next.c
SOURCES += $(TIFFTOP)/tif_ojpeg.c
SOURCES += $(TIFFTOP)/tif_open.c
SOURCES += $(TIFFTOP)/tif_packbits.c
SOURCES += $(TIFFTOP)/tif_pixarlog.c
SOURCES += $(TIFFTOP)/tif_predict.c
SOURCES += $(TIFFTOP)/tif_print.c
SOURCES += $(TIFFTOP)/tif_read.c
SOURCES += $(TIFFTOP)/tif_strip.c
#SOURCES += $(TIFFTOP)/tif_stream.cpp
SOURCES += $(TIFFTOP)/tif_swab.c
SOURCES += $(TIFFTOP)/tif_thunder.c
SOURCES += $(TIFFTOP)/tif_tile.c
SOURCES += $(TIFFTOP)/tif_version.c
SOURCES += $(TIFFTOP)/tif_warning.c
SOURCES += $(TIFFTOP)/tif_write.c
SOURCES += $(TIFFTOP)/tif_zip.c
SOURCES += $(TIFFTOP)/tif_unix.c

else

LIB_SYS_LIBS += tiff
ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include
endif
endif # ($(TIFF_EXTERNAL),NO)
endif # ($(WITH_TIFF0),YES)




ifeq ($(WITH_BLOSC),YES)
BLOSC_EXTERNAL:=YES
ifeq ($(BLOSC_EXTERNAL),NO)

BLOSCTOP = $(APP)/bloscSrc

USR_CFLAGS += -DHAVE_ZSTD
USR_CFLAGS += -DHAVE_LZ4
USR_CFLAGS += -DHAVE_ZLIB
USR_CFLAGS += -DHAVE_SNAPPY


USR_INCLUDES += -I$(where_am_I)$(BLOSCTOP)/internal-complibs/zstd-1.3.0/

SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/common/entropy_common.c
SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/common/error_private.c
SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/common/fse_decompress.c
SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/common/pool.c
SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/common/threading.c
SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/common/xxhash.c
SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/common/zstd_common.c

SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/compress/fse_compress.c
SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/compress/zstd_compress.c
SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/compress/huf_compress.c
SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/compress/zstdmt_compress.c

SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/decompress/huf_decompress.c
SOURCES += $(BLOSCTOP)/internal-complibs/zstd-1.3.0/decompress/zstd_decompress.c

SOURCES += $(BLOSCTOP)/internal-complibs/snappy-1.1.1/snappy.cc
SOURCES += $(BLOSCTOP)/internal-complibs/snappy-1.1.1/snappy-c.cc
SOURCES += $(BLOSCTOP)/internal-complibs/snappy-1.1.1/snappy-sinksource.cc
SOURCES += $(BLOSCTOP)/internal-complibs/snappy-1.1.1/snappy-stubs-internal.cc


SOURCES += $(BLOSCTOP)/internal-complibs/lz4-1.7.5/lz4.c
SOURCES += $(BLOSCTOP)/internal-complibs/lz4-1.7.5/lz4hc.c


HEADERS += $(BLOSCTOP)/blosc/blosc.h
HEADERS += $(BLOSCTOP)/blosc/blosc-export.h

SOURCES += $(BLOSCTOP)/blosc/blosc.c
SOURCES += $(BLOSCTOP)/blosc/blosclz.c
SOURCES += $(BLOSCTOP)/blosc/shuffle-generic.c
SOURCES += $(BLOSCTOP)/blosc/bitshuffle-generic.c
SOURCES += $(BLOSCTOP)/blosc/shuffle.c



ifeq ($(BLOSC_SSE2),YES)
SOURCES += $(BLOSCTOP)/blosc/shuffle-sse2.c
SOURCES += $(BLOSCTOP)/blosc/bitshuffle-sse2.c
endif

ifeq ($(BLOSC_AVX2),YES)
SOURCES += $(BLOSCTOP)/blosc/shuffle-avx2.c 
SOURCES += $(BLOSCTOP)/blosc/bitshuffle-avx2.c
endif

else
LIB_SYS_LIBS += blosc
ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include
endif
endif # ($(BLOSC_EXTERNAL),NO)
endif # ($(WITH_BLOSC),YES)




ifeq ($(WITH_ZLIB),YES)
# We will use ADSupport ZLIB
ZLIB_EXTERNAL:=NO
ifeq ($(ZLIB_EXTERNAL),NO)

ZLIBTOP = $(APP)/zlibSrc

USR_INCLUDES += -I$(where_am_I)$(ZLIBTOP)
USR_INCLUDES += -I$(where_am_I)$(ZLIBTOP)/$(OS_Linux)
USR_INCLUDES += -I$(where_am_I)$(ZLIBTOP)/$(OS_default)

HEADERS += $(ZLIBTOP)/$(OS_default)/zlib.h
HEADERS += $(ZLIBTOP)/$(OS_Linux)/zconf.h

SOURCES += $(ZLIBTOP)/adler32.c
SOURCES += $(ZLIBTOP)/compress.c
SOURCES += $(ZLIBTOP)/crc32.c
SOURCES += $(ZLIBTOP)/deflate.c
SOURCES += $(ZLIBTOP)/gzclose.c
SOURCES += $(ZLIBTOP)/gzlib.c
SOURCES += $(ZLIBTOP)/gzread.c
SOURCES += $(ZLIBTOP)/gzwrite.c
SOURCES += $(ZLIBTOP)/infback.c
SOURCES += $(ZLIBTOP)/inffast.c
SOURCES += $(ZLIBTOP)/inflate.c
SOURCES += $(ZLIBTOP)/inftrees.c
SOURCES += $(ZLIBTOP)/trees.c
SOURCES += $(ZLIBTOP)/uncompr.c
SOURCES += $(ZLIBTOP)/zutil.c

endif # ($(ZLIB_EXTERNAL),NO)
endif # ($(WITH_ZLIB),YES)


ifeq ($(WITH_JPEG),YES)
JPEG_EXTERNAL:=YES
ifeq ($(JPEG_EXTERNAL),NO)

JPEGTOP = $(APP)/jpegSrc

USR_INCLUDES += -I$(where_am_I)$(JPEGTOP)
USR_INCLUDES += -I$(where_am_I)$(JPEGTOP)/$(OS_Linux)
USR_INCLUDES += -I$(where_am_I)$(JPEGTOP)/$(OS_default)

HEADERS += $(JPEGTOP)/$(OS_default)/jpeglib.h 
HEADERS += $(JPEGTOP)/$(OS_Linux)/jconfig.h 
HEADERS += $(JPEGTOP)/$(OS_Linux)/jmorecfg.h 
HEADERS += $(JPEGTOP)/$(OS_default)/jerror.h 



SOURCES += $(JPEGTOP)/jaricom.c 
SOURCES += $(JPEGTOP)/jcapimin.c 
SOURCES += $(JPEGTOP)/jcapistd.c 
SOURCES += $(JPEGTOP)/jcarith.c 
SOURCES += $(JPEGTOP)/jccoefct.c 
SOURCES += $(JPEGTOP)/jccolor.c
SOURCES += $(JPEGTOP)/jcdctmgr.c 
SOURCES += $(JPEGTOP)/jchuff.c 
SOURCES += $(JPEGTOP)/jcinit.c 
SOURCES += $(JPEGTOP)/jcmainct.c 
SOURCES += $(JPEGTOP)/jcmarker.c 
SOURCES += $(JPEGTOP)/jcmaster.c
SOURCES += $(JPEGTOP)/jcomapi.c 
SOURCES += $(JPEGTOP)/jcparam.c 
SOURCES += $(JPEGTOP)/jcprepct.c 
SOURCES += $(JPEGTOP)/jcsample.c 
SOURCES += $(JPEGTOP)/jctrans.c 
SOURCES += $(JPEGTOP)/jdapimin.c
SOURCES += $(JPEGTOP)/jdapistd.c 
SOURCES += $(JPEGTOP)/jdarith.c 
SOURCES += $(JPEGTOP)/jdatadst.c 
SOURCES += $(JPEGTOP)/jdatasrc.c 
SOURCES += $(JPEGTOP)/jdcoefct.c 
SOURCES += $(JPEGTOP)/jdcolor.c
SOURCES += $(JPEGTOP)/jddctmgr.c 
SOURCES += $(JPEGTOP)/jdhuff.c 
SOURCES += $(JPEGTOP)/jdinput.c 
SOURCES += $(JPEGTOP)/jdmainct.c 
SOURCES += $(JPEGTOP)/jdmarker.c 
SOURCES += $(JPEGTOP)/jdmaster.c
SOURCES += $(JPEGTOP)/jdmerge.c 
SOURCES += $(JPEGTOP)/jdpostct.c 
SOURCES += $(JPEGTOP)/jdsample.c 
SOURCES += $(JPEGTOP)/jdtrans.c 
SOURCES += $(JPEGTOP)/jerror.c 
SOURCES += $(JPEGTOP)/jfdctflt.c
SOURCES += $(JPEGTOP)/jfdctfst.c 
SOURCES += $(JPEGTOP)/jfdctint.c
SOURCES += $(JPEGTOP)/jidctflt.c 
SOURCES += $(JPEGTOP)/jidctfst.c 
SOURCES += $(JPEGTOP)/jidctint.c 
SOURCES += $(JPEGTOP)/jquant1.c
SOURCES += $(JPEGTOP)/jquant2.c 
SOURCES += $(JPEGTOP)/jutils.c 
SOURCES += $(JPEGTOP)/jmemmgr.c
SOURCES += $(JPEGTOP)/jmemnobs.c

SOURCES += $(JPEGTOP)/decompressJPEG.c

else
LIB_SYS_LIBS += jpeg
ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include
endif
endif # ($(JPEG_EXTERNAL),NO)
endif # ($(WITH_JPEG),YES)


ifeq ($(WITH_NETCDF),YES)
NETCDF_EXTERNAL:=YES
ifeq ($(NETCDF_EXTERNAL),NO)

NETCDFTOP = $(APP)/netCDFSrc

USR_INCLUDES += -I$(where_am_I)$(NETCDFTOP)/inc
USR_INCLUDES += -I$(where_am_I)$(NETCDFTOP)/libsrc
USR_INCLUDES += -I$(where_am_I)$(NETCDFTOP)/libdispatch
USR_INCLUDES += -I$(where_am_I)$(NETCDFTOP)/$(OS_Linux)
USR_INCLUDES += -I$(where_am_I)$(NETCDFTOP)/$(OS_default)

USR_CFLAGS += -DHAVE_CONFIG_H

HEADERS += $(NETCDFTOP)/inc/netcdf.h

SOURCES += $(NETCDFTOP)/libsrc/v1hpg.c
SOURCES += $(NETCDFTOP)/libsrc/putget.c
SOURCES += $(NETCDFTOP)/libsrc/attr.c
SOURCES += $(NETCDFTOP)/libsrc/nc3dispatch.c
SOURCES += $(NETCDFTOP)/libsrc/nc3internal.c
SOURCES += $(NETCDFTOP)/libsrc/var.c
SOURCES += $(NETCDFTOP)/libsrc/dim.c
SOURCES += $(NETCDFTOP)/libsrc/ncx.c
SOURCES += $(NETCDFTOP)/libsrc/nc_hashmap.c
SOURCES += $(NETCDFTOP)/libsrc/lookup3.c
SOURCES += $(NETCDFTOP)/libsrc/ncio.c
SOURCES += $(NETCDFTOP)/libsrc/memio.c
SOURCES += $(NETCDFTOP)/libsrc/posixio.c

SOURCES += $(NETCDFTOP)/libdispatch/dparallel.c
SOURCES += $(NETCDFTOP)/libdispatch/dcopy.c
SOURCES += $(NETCDFTOP)/libdispatch/dfile.c
SOURCES += $(NETCDFTOP)/libdispatch/ddim.c
SOURCES += $(NETCDFTOP)/libdispatch/datt.c
SOURCES += $(NETCDFTOP)/libdispatch/dattinq.c
SOURCES += $(NETCDFTOP)/libdispatch/dattput.c
SOURCES += $(NETCDFTOP)/libdispatch/dattget.c
SOURCES += $(NETCDFTOP)/libdispatch/derror.c
SOURCES += $(NETCDFTOP)/libdispatch/dvar.c
SOURCES += $(NETCDFTOP)/libdispatch/dvarget.c
SOURCES += $(NETCDFTOP)/libdispatch/dvarput.c
SOURCES += $(NETCDFTOP)/libdispatch/dvarinq.c
SOURCES += $(NETCDFTOP)/libdispatch/dinternal.c
SOURCES += $(NETCDFTOP)/libdispatch/ddispatch.c
SOURCES += $(NETCDFTOP)/libdispatch/dutf8.c
SOURCES += $(NETCDFTOP)/libdispatch/nclog.c
SOURCES += $(NETCDFTOP)/libdispatch/dstring.c
SOURCES += $(NETCDFTOP)/libdispatch/ncuri.c
SOURCES += $(NETCDFTOP)/libdispatch/nclist.c
SOURCES += $(NETCDFTOP)/libdispatch/ncbytes.c
SOURCES += $(NETCDFTOP)/libdispatch/nchashmap.c
SOURCES += $(NETCDFTOP)/libdispatch/nctime.c
SOURCES += $(NETCDFTOP)/libdispatch/nc.c
SOURCES += $(NETCDFTOP)/libdispatch/nclistmgr.c
SOURCES += $(NETCDFTOP)/libdispatch/drc.c
SOURCES += $(NETCDFTOP)/libdispatch/dauth.c
SOURCES += $(NETCDFTOP)/libdispatch/doffsets.c
SOURCES += $(NETCDFTOP)/libdispatch/dwinpath.c
SOURCES += $(NETCDFTOP)/libdispatch/dutil.c
SOURCES += $(NETCDFTOP)/libdispatch/utf8proc.c

SOURCES += $(NETCDFTOP)/liblib/nc_initialize.c
else

LIB_SYS_LIBS += netcdf
ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include
endif
endif # ($(NETCDF_EXTERNAL),NO)

endif # ($(WITH_NETCDF),YES)


CBFTOP = $(APP)/cbfSrc


HEADERS += $(CBFTOP)/cbf_ad.h
HEADERS += $(CBFTOP)/cbf_tree_ad.h
HEADERS += $(CBFTOP)/cbf_context_ad.h
HEADERS += $(CBFTOP)/cbf_file_ad.h
HEADERS += $(CBFTOP)/global_ad.h
HEADERS += $(CBFTOP)/md5_ad.h

SOURCES += $(CBFTOP)/cbf.c
SOURCES += $(CBFTOP)/cbf_alloc.c
SOURCES += $(CBFTOP)/cbf_ascii.c
SOURCES += $(CBFTOP)/cbf_binary.c
SOURCES += $(CBFTOP)/cbf_byte_offset.c
SOURCES += $(CBFTOP)/cbf_canonical.c
SOURCES += $(CBFTOP)/cbf_codes.c
SOURCES += $(CBFTOP)/cbf_compress.c
SOURCES += $(CBFTOP)/cbf_context.c
SOURCES += $(CBFTOP)/cbf_file.c
SOURCES += $(CBFTOP)/cbf_getopt.c
SOURCES += $(CBFTOP)/cbf_lex.c
SOURCES += $(CBFTOP)/cbf_packed.c
SOURCES += $(CBFTOP)/cbf_predictor.c
SOURCES += $(CBFTOP)/cbf_read_binary.c
SOURCES += $(CBFTOP)/cbf_read_mime.c
SOURCES += $(CBFTOP)/cbf_simple.c
SOURCES += $(CBFTOP)/cbf_string.c
SOURCES += $(CBFTOP)/cbf_stx.c
SOURCES += $(CBFTOP)/cbf_tree.c
SOURCES += $(CBFTOP)/cbf_uncompressed.c
SOURCES += $(CBFTOP)/cbf_write.c
SOURCES += $(CBFTOP)/cbf_write_binary.c
SOURCES += $(CBFTOP)/cbf_ws.c
SOURCES += $(CBFTOP)/md5c.c



db: 

.PHONY: db 


vlibs:

.PHONY: vlibs

