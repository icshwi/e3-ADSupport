# e3-ADSupport

This is the ESS customized single library (ADSupport) in order to integrate ADCore and others modules. However, the current limitations (not-supported) will be considered to use them.


## Current status

The following libraries are supported as the one ADSupport library :

* netCDF
* jpeg
* zlib
* szip
* tiff
* blosc
* hdf5 and hdf5_hl
* nexus

The following libs are not supported :
* xml2
* GraphicsMagick

## Configuration compilation and installation

```
$ git clone https://github.com/icshwi/e3-ADSupport.git
$ cd e3-ADSupport
$ git checkout target_path_test
$ make init
$ make patch
$ make build
$ make install 
```

Try to load the library to verify that is properly installed and without _"Undefined Symbols"_ 

```
$ iocsh.bash -r ADSupport,1.4.0
......
require ADSupport,1.4.0
Module ADSupport version 1.4.0 found in /testing/epics/base-3.15.5/require/0.0.0/siteMods/ADSupport/1.4.0/
Loading library /testing/epics/base-3.15.5/require/0.0.0/siteMods/ADSupport/1.4.0/lib/linux-x86_64/libADSupport.so
Loaded ADSupport version 1.4.0
ADSupport has no dbd file
Loading module info records for ADSupport

...
iocInit
Starting iocInit
############################################################################
## EPICS R3.15.5-EEE-3.15.5-patch
## EPICS Base built Feb 21 2018
############################################################################

```

## Issues

### XML2
There are some conflicts when the library __is built when xml2 is enabled__. For this reason xml2 support is currently __disabled__.

### GraphicsMagick 

The GraphicsMagick support consists in 12 sub modules. Not all them have been integrated or disabled due to conflict between names or due to the very complex directory structure of some submodules. This is the current status:

| Sub-module | Dependencies | Status |
|------------|--------------|--------|
| bzlib | | __NAME CONFLICTS -> DISABLED__ |
| lcms  | | OK |
| ttf   | | __NOT FULLY INTEGRATED (COMPLEX DIRECTORY STRUCTURE)__ |
| wmf	| | OK |
| webp  | | OK |
| jp2   | | __NOT INTEGRATED (COMPLEX DIRECTORY STRUCTURE)__ |
| jbig  | | OK |
| png   | bzlib | OK |
| magick | zlib lcms ttf | __NAME CONFLICTS -> DISABLED__ |
| coders | zlib big jp2 magick png ttf webp wmf | __NAME CONFLICTS -> DISABLED__ |
| filters | magick ttf | OK |
| Magick++ | magick coders | OK |

Due to incomplete sub-modules, some depenencies cannot be satisfied and the GraphicsMagick support is __disabled__ for now.
