# e3-ADSupport

This module is intended as integration of the EPICS ADSupport into ESS e3 environment

## Current status

The following module have been integrated:

* netCDF
* szip
* zlib
* HDF5 and HDLF_HL
* jpeg
* tiff
* xml2 (disabled, Issues)
* nexus
* GraphicsMagick (partially supported, see Issues)

## Configuration compilation and installation

```
$ git clone https://github.com/icshwi/e3-ADSupport.git
$ cd e3-ADSupport
$ make build install
```

Try to load the library to verify that is properly installed and without _"Undefined Symbols"_ 

```
$ iocsh.bash -r ADSupport,1.3.0
......
require ADSupport,1.3.0
Module ADSupport version 1.3.0 found in /epics/modules/ADSupport/1.3.0/
Loading library /epics/modules/ADSupport/1.3.0/R3.15.5/lib/linux-x86_64/libADSupport.so
Loaded ADSupport version 1.3.0
ADSupport has no dbd file
...
############################################################################
## EPICS R3.15.5-EEE-3.15.5-patch
## EPICS Base built Jan 10 2018
############################################################################
iocRun: All initialization complete

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