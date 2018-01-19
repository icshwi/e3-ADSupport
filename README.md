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
* xml2 (disabled, see Issues)
* nexus

## Configuration compilation and installation

```
$ git clone https://github.com/icshwi/e3-ADSupport.git
$ cd e3-ADSupport
$ make build install
```

## Issues

There are some conflicts when the library __is built when xml2 is enabled__. For this reason xml2 support is currently __disabled__.