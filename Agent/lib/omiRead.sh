#!/bin/bash
#
# Testing generation of O-MI/O-DF read message
#
# Created by Kary Framling, 21 may 2015 for the write operation
# Modified by Jérémy Robert, 5 october 2016 for the read operation

#======================================================================
# Functions must be declared before being used. 


# Create InfoItem  with given name and value  
function odfInfoItem () {
	echo "<InfoItem name=\"$1\"></InfoItem>"
}

# Create Object with given name and its InfoItems and values  
function odfObject () {
	echo "<Object>"
	echo "<id>$1</id>"
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
		echo "$(odfInfoItem ${ii_array[$ix]} ${value_array[$ix]})"
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
function omiRead () {
	echo "<omi:omiEnvelope xmlns:omi=\"omi.xsd\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"omi.xsd omi.xsd\" version=\"1.0\" ttl=\"-1\"><omi:read msgformat=\"odf\"><omi:msg xmlns=\"odf.xsd\" xsi:schemaLocation=\"odf.xsd odf.xsd\">"
	echo "$(odfObjects)"
	echo "</omi:msg></omi:read></omi:omiEnvelope>"
}

#======================================================================
# Get O-DF tree as variables
source $1

echo "$(omiRead)" 