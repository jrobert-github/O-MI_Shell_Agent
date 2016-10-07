#!/bin/bash
#
# Testing genaration of O-MI/O-DF write message
#
# Created by Kary Framling, 21 may 2015
# Modified by Jérémy Robert, 5 october 2016

#======================================================================
# Functions must be declared before being used. 


# Create Metadata  with given name and value  
function odfMetadata () {
	echo "<InfoItem name=\"$1\"><value unixTime=\"`date +%s`\">$2</value></InfoItem>"
}

# Create InfoItem  with given name and value  
function odfInfoItem () {
	echo "<InfoItem name=\"$1\"><description>$3</description>"
	ii_metadaa=$1"_metadata"
	set -f
	ii_metadata_array=(${!ii_metadaa})
	obj_array=(${!obj_list})
	metadata_value_list=$1"_metadata_values"
	set -f
	metadata_value_array=(${!metadata_value_list})
	echo "<MetaData>"
	for ((ix=0;ix<${#ii_metadata_array[*]};ix+=1)); do 
		echo "$(odfMetadata ${ii_metadata_array[$ix]} ${metadata_value_array[$ix]})"
	done
	echo " </MetaData>"
	echo "<value unixTime=\"`date +%s`\">$2</value></InfoItem>"
}

# Create Object with given name and its InfoItems and values  
function odfObject () {
	echo "<Object>"
	echo "<id>$1</id>"
	obj_descr=$1"_description"
	set -f
	obj_descr_array=(${!obj_descr})
	echo "<description>$obj_descr_array</description>"
	ii_list=$1"_InfoItems"
	set -f
	ii_array=(${!ii_list})
	value_list=$1"_values"
	set -f
	value_array=(${!value_list})
	obj_list=$1"_Objects"
	set -f
	obj_array=(${!obj_list})
	for ((ix=0;ix<${#ii_array[*]};ix+=1)); do 
		ii_descr=${ii_array[$ix]}"_description"
		ii_descr_array=(${!ii_descr})
		echo "$(odfInfoItem ${ii_array[$ix]} ${value_array[$ix]} $ii_descr_array)"
	done
	for ((ix=0;ix<${#obj_array[*]};ix+=1)); do 
		echo "$(odfObject ${obj_array[$ix]})"
	done
	echo "</Object>"
}

# Create Objects from list of Object names (given as argument $1) or from top-level "Objects" variable if no argument
function odfObjects () {
	if [[ -z "$1" ]]
	then o=${Objects}
	else o=${1}
	fi
        echo "<Objects>"
	for x in ${o}; do 
		echo "$(odfObject ${x})"
	done
	echo "</Objects>"
}

# Create a "write" O-MI message
function omiWrite () {
	echo "<omi:omiEnvelope xmlns:omi=\"omi.xsd\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"omi.xsd omi.xsd\" version=\"1.0\" ttl=\"-1\"><omi:write msgformat=\"odf\"><omi:msg xmlns=\"odf.xsd\" xsi:schemaLocation=\"odf.xsd odf.xsd\">"
	echo "$(odfObjects)"
	echo "</omi:msg></omi:write></omi:omiEnvelope>"
}

#======================================================================
# Get O-DF tree as variables
source $1

echo "$(omiWrite)" 