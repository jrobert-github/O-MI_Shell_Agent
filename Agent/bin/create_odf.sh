#!/bin/bash
#
# Created by Jérémy Robert, 5 october 2016
#
# Create O-DF tree using your odf service tree defined in the file define_odf.sh. 
#

source ../define_omi.sh

curl $server -H "Content-Type:text/xml" --data "`../lib/omiWrite.sh ../define_odf.sh`"