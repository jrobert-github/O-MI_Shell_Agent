#!/bin/bash
#
# Created by Jérémy Robert, 5 october 2016
#
# Update O-DF tree using your odf service tree defined in the file define_odf.sh, and 
#the new values defined in the file define_omi.sh

source ../define_omi.sh

if [[ $# != 0 ]] ;
then

while (true)
do
curl $server -H "Content-Type:text/xml" --data "`../lib/omiWrite.sh ../define_values.sh`"
sleep $1
done

else
curl $server -H "Content-Type:text/xml" --data "`../lib/omiWrite.sh ../define_values.sh`"
fi
