Catch up the Community EPICS module Makefiles
===

It is combersome that we have to track down the entire Community EPICS module Makefile(S).
This script helps users to identify which files are introduced in newer version, and which 
files are discarded in older version. 

There is no the prefect way to do this, I know. But it helped me to see which files in which 
subdirectories are changed according to newer revisions. 


## Example

ADSupport R1-7 introduced the following more sub directories :
```
* hdf5PluginSrc
* cbfSrc
* bitshuffleSrc
```
Thus, we have to edit `tools/mk_cmpr.bash` in order to add the following lines:
```
hdr_src_compare "${TOP}" "${APPTOP}/bitshuffleSrc/" "BITSHUFFLETOP"
hdr_src_compare "${TOP}" "${APPTOP}/hdf5PluginSrc/" "HDF5PLUGINTOP"
hdr_src_compare "${TOP}" "${APPTOP}/cbfSrc/"        "CBFTOP"
```
Of cource, we don't define anything in ADSupport.Makefile such as
```
BITSHUFFLETOP
HDF5PLUGINTOP
CBFTOP
```
However, it doesn't matter because they are new in R1-7.


## Run 

```
bash tools/mk_cmpr.bash

* /home/jhlee/e3-3.15.6/e3-ADSupport/tools/../ADSupport/supportApp/hdf5Src/ 
** Header Files ...          <epics   >e3
43,45d42
< blosc_filter.h
< lz4_h5filter.h
< bshuf_h5filter.h

** Source Files ...          <epics   >e3
286,287d285
< bshuf_h5filter.c
< H5Zlz4.c


* /home/jhlee/e3-3.15.6/e3-ADSupport/tools/../ADSupport/supportApp/bitshuffleSrc/ 
** Header Files ...          <epics   >e3
1,3d0
< bitshuffle.h
< bitshuffle_core.h
< lz4.h

** Source Files ...          <epics   >e3
1,4d0
< bitshuffle.c
< bitshuffle_core.c
< iochain.c
< lz4.c


* /home/jhlee/e3-3.15.6/e3-ADSupport/tools/../ADSupport/supportApp/hdf5PluginSrc/ 
** Source Files ...          <epics   >e3
1,6d0
< blosc_filter.c
< blosc_plugin.c
< bshuf_h5filter.c
< bshuf_h5plugin.c
< H5Zlz4.c
< lz4_h5plugin.c


* /home/jhlee/e3-3.15.6/e3-ADSupport/tools/../ADSupport/supportApp/cbfSrc/ 
** Header Files ...          <epics   >e3
1,6d0
< cbf_ad.h
< cbf_tree_ad.h
< cbf_context_ad.h
< cbf_file_ad.h
< global_ad.h
< md5_ad.h

** Source Files ...          <epics   >e3
1,25d0
< cbf.c
< cbf_alloc.c
< cbf_ascii.c
< cbf_binary.c
< cbf_byte_offset.c
< cbf_canonical.c
< cbf_codes.c
< cbf_compress.c
< cbf_context.c
< cbf_file.c
< cbf_getopt.c
< cbf_lex.c
< cbf_packed.c
< cbf_predictor.c
< cbf_read_binary.c
< cbf_read_mime.c
< cbf_simple.c
< cbf_string.c
< cbf_stx.c
< cbf_tree.c
< cbf_uncompressed.c
< cbf_write.c
< cbf_write_binary.c
< cbf_ws.c
< md5c.c

```


## Analyze the output

```
* /home/jhlee/e3-3.15.6/e3-ADSupport/tools/../ADSupport/supportApp/hdf5Src/ 
** Header Files ...          <epics   >e3
43,45d42
< blosc_filter.h
< lz4_h5filter.h
< bshuf_h5filter.h

** Source Files ...          <epics   >e3
286,287d285
< bshuf_h5filter.c
< H5Zlz4.c
```

So, R1-7, we have three new potential header files and two new potential source files in 
the EPICS Community EPICS ADSupport source codes. 

We have to clean up them one by one. 
