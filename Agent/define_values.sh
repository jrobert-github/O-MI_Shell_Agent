#!/bin/bash
#
# Created by Jérémy Robert, 5 october 2016
#
# Define O-DF tree using "structurally named" variables. 

source ../define_odf.sh

str=$(curl 192.168.0.13/api/XM4Os8PVq8dp2LZxMIvR7ntFxMaWg3BwsPx0XJTp/lights/1)
val_On=$(echo $str | jq -r '.state.on')
val_Bri=$(echo $str | jq -r '.state.bri')

SmartLight_values="$val_On $val_Bri"
