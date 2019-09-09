# e3-ADSupport

This is the ESS customized single library (ADSupport) in order to integrate ADCore and others modules. However, due to E3 building system, we cannot use them as a single module due to the E3 building system and its compilicated dependency within ADSupport. Thus, in order to keep a single module, we have to use Linux system libraries as much as possible. In addition, we exclude `GraphicsMagick`. 


## Support Libraries as the e3 ADSupport module

```
Library     |  USE   |  WHERE
XML2        |  YES   |  External (System lib)
NETCDF      |  YES   |  External (System lib)
JPEG        |  YES   |  External (System lib)
BLOSC       |  YES   |  External (System lib)
TIFF        |  YES   |  External (System lib)
HDF5        |  YES   |  External (System lib)
ZLIB        |  YES   |  ADSupport
SZIP        |  YES   |  ADSupport
BITSHUFFLE  |  YES   |  ADSupport
NEXUS       |  YES   |  ADSupport
```

Therefore, system with ADSupport should have the following system libraries:
* xml2
* blosc
* netcdf
* jpeg
* tiff
* hdf5

On Debian 10, one should use the following command to install packages:
```
apt install libxml2 libxml2-dev \
    libnetcdf-dev libnetcdf13 \
    libjpeg-dev libjpeg62 \
    libblosc-dev libblosc1 \
    libtiff-dev libtiff5 libtiff5-dev \
    libhdf5-dev 
```

## xml2
```
SYS_LIBS += xml2
ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include/libxml2
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include/libxml2
endif
```

## HDF5 

```
LIB_SYS_LIBS += hdf5_serial
LIB_SYS_LIBS += hdf5_serial_hl

ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include/hdf5/serial
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include/hdf5/serial
endif
```
## TIFF
```
LIB_SYS_LIBS += tiff
ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include
endif
```

## BLOSC
```
LIB_SYS_LIBS += blosc
ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include
endif
```

## JPEG
```
LIB_SYS_LIBS += jpeg
ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include
endif
```

## NETCDF

```
LIB_SYS_LIBS += netcdf
ifeq ($(T_A),linux-x86_64)
USR_INCLUDES += -I/usr/include
else
USR_INCLUDES += -I$(SDKTARGETSYSROOT)/usr/include
endif
```


## ldd

```
 ldd /epics/base-7.0.3/require/3.1.0/siteLibs/linux-x86_64/libADSupport.so.1.9.0 
	linux-vdso.so.1 (0x00007fffc2ed9000)
	libhdf5_serial.so.103 => /lib/x86_64-linux-gnu/libhdf5_serial.so.103 (0x00007f6cbd77a000)
	libhdf5_serial_hl.so.100 => /lib/x86_64-linux-gnu/libhdf5_serial_hl.so.100 (0x00007f6cbd754000)
	libxml2.so.2 => /lib/x86_64-linux-gnu/libxml2.so.2 (0x00007f6cbd5ab000)
	libtiff.so.5 => /lib/x86_64-linux-gnu/libtiff.so.5 (0x00007f6cbd52c000)
	libblosc.so.1 => /lib/libblosc.so.1 (0x00007f6cbd51c000)
	libjpeg.so.62 => /lib/x86_64-linux-gnu/libjpeg.so.62 (0x00007f6cbd2b1000)
	libnetcdf.so.13 => /lib/x86_64-linux-gnu/libnetcdf.so.13 (0x00007f6cbd170000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f6cbd14f000)
	librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007f6cbd145000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f6cbd140000)
	libstdc++.so.6 => /lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f6cbcfbc000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f6cbce37000)
	libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f6cbce1d000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f6cbcc5c000)
	libsz.so.2 => /lib/x86_64-linux-gnu/libsz.so.2 (0x00007f6cbca59000)
	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f6cbc83b000)
	libicui18n.so.63 => /lib/x86_64-linux-gnu/libicui18n.so.63 (0x00007f6cbc560000)
	libicuuc.so.63 => /lib/x86_64-linux-gnu/libicuuc.so.63 (0x00007f6cbc38f000)
	libicudata.so.63 => /lib/x86_64-linux-gnu/libicudata.so.63 (0x00007f6cba99f000)
	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f6cba977000)
	libwebp.so.6 => /lib/x86_64-linux-gnu/libwebp.so.6 (0x00007f6cba70e000)
	libzstd.so.1 => /lib/x86_64-linux-gnu/libzstd.so.1 (0x00007f6cba66e000)
	libjbig.so.0 => /lib/x86_64-linux-gnu/libjbig.so.0 (0x00007f6cba460000)
	liblz4.so.1 => /lib/x86_64-linux-gnu/liblz4.so.1 (0x00007f6cba43f000)
	libsnappy.so.1 => /lib/x86_64-linux-gnu/libsnappy.so.1 (0x00007f6cba237000)
	libcurl-gnutls.so.4 => /lib/x86_64-linux-gnu/libcurl-gnutls.so.4 (0x00007f6cba1a9000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f6cbdbd5000)
	libaec.so.0 => /lib/x86_64-linux-gnu/libaec.so.0 (0x00007f6cb9fa1000)
	libnghttp2.so.14 => /lib/x86_64-linux-gnu/libnghttp2.so.14 (0x00007f6cb9f79000)
	libidn2.so.0 => /lib/x86_64-linux-gnu/libidn2.so.0 (0x00007f6cb9f58000)
	librtmp.so.1 => /lib/x86_64-linux-gnu/librtmp.so.1 (0x00007f6cb9d3b000)
	libssh2.so.1 => /lib/x86_64-linux-gnu/libssh2.so.1 (0x00007f6cb9d0d000)
	libpsl.so.5 => /lib/x86_64-linux-gnu/libpsl.so.5 (0x00007f6cb9cfa000)
	libnettle.so.6 => /lib/x86_64-linux-gnu/libnettle.so.6 (0x00007f6cb9cc2000)
	libgnutls.so.30 => /lib/x86_64-linux-gnu/libgnutls.so.30 (0x00007f6cb9b16000)
	libgssapi_krb5.so.2 => /lib/x86_64-linux-gnu/libgssapi_krb5.so.2 (0x00007f6cb9ac7000)
	libkrb5.so.3 => /lib/x86_64-linux-gnu/libkrb5.so.3 (0x00007f6cb99e7000)
	libk5crypto.so.3 => /lib/x86_64-linux-gnu/libk5crypto.so.3 (0x00007f6cb99b3000)
	libcom_err.so.2 => /lib/x86_64-linux-gnu/libcom_err.so.2 (0x00007f6cb99ad000)
	libldap_r-2.4.so.2 => /lib/x86_64-linux-gnu/libldap_r-2.4.so.2 (0x00007f6cb9959000)
	liblber-2.4.so.2 => /lib/x86_64-linux-gnu/liblber-2.4.so.2 (0x00007f6cb9948000)
	libunistring.so.2 => /lib/x86_64-linux-gnu/libunistring.so.2 (0x00007f6cb97c2000)
	libhogweed.so.4 => /lib/x86_64-linux-gnu/libhogweed.so.4 (0x00007f6cb9789000)
	libgmp.so.10 => /lib/x86_64-linux-gnu/libgmp.so.10 (0x00007f6cb9706000)
	libgcrypt.so.20 => /lib/x86_64-linux-gnu/libgcrypt.so.20 (0x00007f6cb95e8000)
	libp11-kit.so.0 => /lib/x86_64-linux-gnu/libp11-kit.so.0 (0x00007f6cb94b9000)
	libtasn1.so.6 => /lib/x86_64-linux-gnu/libtasn1.so.6 (0x00007f6cb92a6000)
	libkrb5support.so.0 => /lib/x86_64-linux-gnu/libkrb5support.so.0 (0x00007f6cb9295000)
	libkeyutils.so.1 => /lib/x86_64-linux-gnu/libkeyutils.so.1 (0x00007f6cb928e000)
	libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007f6cb9274000)
	libsasl2.so.2 => /lib/x86_64-linux-gnu/libsasl2.so.2 (0x00007f6cb9257000)
	libgpg-error.so.0 => /lib/x86_64-linux-gnu/libgpg-error.so.0 (0x00007f6cb9234000)
	libffi.so.6 => /lib/x86_64-linux-gnu/libffi.so.6 (0x00007f6cb9228000)
```
