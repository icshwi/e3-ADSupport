# 01_tiff_extern_rename.p0.patch

The same EXTERN exists in jpegSrc and tiffSrc. Decided to create a patch for tiffSrc

```
In file included from ../supportApp/jpegSrc//os/default/jpeglib.h:27:0,
                 from ../supportApp/tiffSrc/tif_jpeg.c:88:
../supportApp/jpegSrc//os/Linux/jmorecfg.h:248:0: warning: "EXTERN" redefined
 #define EXTERN(type)  extern type
 ^
In file included from ../supportApp/tiffSrc/tiffiop.h:66:0,
                 from ../supportApp/tiffSrc/tif_jpeg.c:30:
../supportApp/tiffSrc//os/default/tiffio.h:91:0: note: this is the location of the previous definition
 #  define EXTERN extern 
 ^
``` 
* created by Jeong Han Lee, han.lee@esss.se
* Tuesday, April 10 14:05:09 CEST 2018
