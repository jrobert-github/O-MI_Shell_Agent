#!/bin/bash
#
# Created by Jérémy Robert, 5 october 2016
#
# Update the state of the device every time we read an InfoItem's value
#

source ../define_omi.sh

if [[ $# != 0 ]] ;
then

while (true)
do
xmlresponse=$(curl $server -H "Content-Type:text/xml" --data "`../lib/omiRead.sh ../define_odf.sh`")
#---- Extract the odf part from the xml response
xmlodf=$(echo $xmlresponse | awk -v FS="(<Objects>|</Objects>)" '{print $2}')
#---- Parse the odf part for extracting the value for the InfoItem 'On' and 'Brightness'
val_Bri=$(echo $xmlodf | xmllint --xpath "string(//InfoItem[@name='Brightness'])" -)
val_On=$(echo $xmlodf | xmllint --xpath "string(//InfoItem[@name='On'])" -)
#---- Prepare JSON and send it to Philips Hue Light
SmartLight_values='{"on": '$val_On',"bri": '$val_Bri'}'
curl 192.168.0.13/api/XM4Os8PVq8dp2LZxMIvR7ntFxMaWg3BwsPx0XJTp/lights/1/state -X PUT --data "${SmartLight_values}"
sleep $1
done

else
xmlresponse=$(curl $server -H "Content-Type:text/xml" --data "`../lib/omiRead.sh ../define_odf.sh`")
#---- Extract the odf part from the xml response
xmlodf=$(echo $xmlresponse | awk -v FS="(<Objects>|</Objects>)" '{print $2}')
#---- Parse the odf part for extracting the value for the InfoItem 'On' and 'Brightness'
val_Bri=$(echo $xmlodf | xmllint --xpath "string(//InfoItem[@name='Brightness'])" -)
val_On=$(echo $xmlodf | xmllint --xpath "string(//InfoItem[@name='On'])" -)
#---- Prepare JSON and send it to Philips Hue Light
SmartLight_values='{"on": '$val_On',"bri": '$val_Bri'}'
curl 192.168.0.13/api/XM4Os8PVq8dp2LZxMIvR7ntFxMaWg3BwsPx0XJTp/lights/1/state -X PUT --data "${SmartLight_values}"
fi
