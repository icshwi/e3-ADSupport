# e3-ADSupport

This is the ESS customized single library (ADSupport) in order to integrate ADCore and others modules. However, due to E3 building system, we cannot use them as a single module. Thus, in order to keep a single module, we have to exclude the following two libraries support from ADSupport: `xml2` and `GraphicsMagick`


## Support Libraries as the e3 ADSupport module

* netCDF
* jpeg
* zlib
* szip
* tiff
* blosc
* hdf5 and hdf5_hl
* nexus

## External Library 
If one would like to use xml2 within CentOS (of course libxml2 package should be installed), or ESS Yocto Linux, one should use the following configuration in each module makefile. 

```
ifeq ($(T_A),linux-ppc64e6500)
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include/libxml2
else ifeq ($(T_A),linux-corei7-poky)
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include/libxml2
else
USR_INCLUDES += -I/usr/include/libxml2
endif

LIB_SYS_LIBS += xml2	
```

## NOT Test GraphicsMagick 
GraphicsMagick has its own up-to-date version of `zlib.h`. So, we exclude it from a single ADSupport. And the externel or system library test will be done later. Currently, there is no requirement for it. 

## Patch file is needed if `JPEG_EXTERNAL:=NO`

* tiff and jpegsrc has the same `EXTERN` name. Thus, if one would like to use `JPEG_EXTERNAL:=NO`. `make patch` is mandatory. By default, `JPEG_EXTERNAL:=YES`

## Configuration compilation and installation

```
$ git clone https://github.com/icshwi/e3-ADSupport.git
$ cd e3-ADSupport
$ make init
$ make patch
$ make build
$ make install 
```
