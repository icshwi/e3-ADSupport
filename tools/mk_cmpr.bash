#!/bin/bash
#
#  Copyright (c)  2019  Jeong Han Lee
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
#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Monday, April 15 13:55:53 CEST 2019
#   version : 0.0.2


declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"
declare -gr SC_LOGDATE="$(date +%y%m%d%H%M)"



function hdr_src_compare
{
    local e3_top=$1;shift;
    local epics_src_top=$1; shift;
    local e3_makefile_src_top_string=$1; shift;
    
    local appendix="<epics   >e3";
    

    HDR_DIFF=$(diff <(cat ${epics_src_top}/Makefile |grep -e "INC +=" -e "INC_Linux +="  | rev | cut -d'=' -f 1 | rev | sed -e 's/^[[:space:]]*//') <(cat ${e3_top}/*.Makefile |grep "HEADERS += \$($e3_makefile_src_top_string)" | rev | cut -d'/' -f 1 | rev |sed -e 's/^[[:space:]]*//'))

    
    SRC_DIFF=$(diff <(cat ${epics_src_top}/Makefile |grep -e "SRCS +=" -e "SRCS_Linux +=" | rev | cut -d'=' -f 1 | rev | sed -e 's/^[[:space:]]*//') <(cat ${e3_top}/*.Makefile |grep "SOURCES += \$($e3_makefile_src_top_string)" | rev | cut -d'/' -f 1 | rev |sed -e 's/^[[:space:]]*//'))
    
    if [ "$HDR_DIFF" ]; then
	printf "\n"
	printf "* %s \n" "$epics_src_top"
	printf "** Header Files ...  %20s\n" "$appendix"
	echo "${HDR_DIFF}"
	printf "\n"
    fi
    
    if [ "$SRC_DIFF" ]; then
	if [ ! "$HDR_DIFF" ]; then
	    printf "\n* %s \n" "$epics_src_top"
	fi
	printf "** Source Files ...  %20s\n" "$appendix"
	echo "${SRC_DIFF}"
	printf "\n"
    fi
    
}


TOP=${SC_TOP}/..
APPTOP=${TOP}/ADSupport/supportApp

hdr_src_compare "${TOP}" "${APPTOP}/bloscSrc/"   "BLOSCTOP"
hdr_src_compare "${TOP}" "${APPTOP}/hdf5_hlSrc/" "HDF5HLTOP"
hdr_src_compare "${TOP}" "${APPTOP}/hdf5Src/"    "HDF5TOP"
hdr_src_compare "${TOP}" "${APPTOP}/jpegSrc/"    "JPEGTOP"
hdr_src_compare "${TOP}" "${APPTOP}/netCDFSrc/"  "NETCDFTOP"
hdr_src_compare "${TOP}" "${APPTOP}/nexusSrc/"   "NEXUSTOP"
hdr_src_compare "${TOP}" "${APPTOP}/szipSrc/"    "SZIPTOP"
hdr_src_compare "${TOP}" "${APPTOP}/tiffSrc/"    "TIFFTOP"
hdr_src_compare "${TOP}" "${APPTOP}/zlibSrc/"    "ZLIBTOP"

# #hdr_src_compare "${APPTOP}/hdf5PluginSrc/" "HDF5HLTOPNETCDFTOP"
# #hdr_src_compare "${APPTOP}/xml2Src/" "XML2TOP"
# #hdr_src_compare "${APPTOP}/bitshuffleSrc/" "NETCDFTOP"
# #hdr_src_compare "${APPTOP}/cbfSrc/" "NETCDFTOP"
# #hdr_src_compare "${APPTOP}/GraphicsMagickSrc/" "GMTOP"
































#epics_src=$1

# e3-ADSupport/ADSupport/supportApp/netCDFSrc/Makefile

# epics_src_temp=$(mktemp -q) 

# cat ${epics_src}/Makefile |grep SRCS | rev | cut -d'=' -f 1 | rev | sed -e 's/^[[:space:]]*//' > $epics_src_temp
# e3_src_temp=$(mktemp -q)
# #cat *.Makefile |grep "SOURCES += \$($e3_src)" | rev | cut -d'/' -f 1 | rev | sed -e "s|^|LIB_SRCS += |" > ${e3_src_temp}
# cat *.Makefile |grep "SOURCES += \$($e3_src_top)" | rev | cut -d'/' -f 1 | rev |sed -e 's/^[[:space:]]*//' > ${e3_src_temp}

# # printf "Do you see the difference between \n";
# # printf "1) %40s, file %s \n" "${epics_src}" "${epics_src_temp}"
# # printf "2) %40s, file %s \n" "${e3_src_top}" "${e3_src_temp}"
# # printf "diff ${epics_src_temp} ${e3_src_temp}\n"
# # printf ">>>> begin\n";
# diff ${epics_src_temp} ${e3_src_temp}
# #printf ">>>> end \n"




# epics_hdr_temp=$(mktemp -q) 

# cat ${epics_src}/Makefile |grep INC | rev | cut -d'=' -f 1 | rev | sed -e 's/^[[:space:]]*//' > $epics_hdr_temp
# e3_hdr_temp=$(mktemp -q)
# cat *.Makefile |grep "HEARDERS += \$($e3_src_top)" | rev | cut -d'/' -f 1 | rev |sed -e 's/^[[:space:]]*//' > ${e3_hdr_temp}

# printf "Do you see the difference between \n";
# printf "1) %40s, file %s \n" "${epics_src}" "${epics_hdr_temp}"
# printf "2) %40s, file %s \n" "${e3_src_top}" "${e3_hrd_temp}"
# printf "diff ${epics_hdr_temp} ${e3_hdr_temp}\n"
# printf ">>>> begin\n";
# diff ${epics_hdr_temp} ${e3_hdr_temp}
#printf ">>>> end \n"

