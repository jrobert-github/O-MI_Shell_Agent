#!/bin/bash
#
# Created by Jérémy Robert, 5 october 2016, based on Kary's code (23 may 2015)
#
# Define O-DF tree using "structurally named" variables. 


#List of "Object" at the first level of the O-DF service tree
Objects="JeremysHouse"

#List of InfoItems related to JeremysHouse
JeremysHouse_InfoItems="Location"
#List of values related to the respective above InfoItems ('Location')
JeremysHouse_values="Rue_Auguste_Prost,_Metz,_France"
#List of "Object" related to JeremysHouse (i.e., Object(s) nested within JeremysHouse)
JeremysHouse_Objects="SmartLight"

#List of InfoItems related to SmartLight
SmartLight_InfoItems="On Brightness"
#List of values related to the respective above InfoItems ('On' and 'Brightness')
SmartLight_values="false 0"

#Description of the InfoItem 'On' (to display to the user)
On_description="Switch_on/off_the_light"

#Description of the InfoItem 'Brightness' (to display to the user)
Brightness_description="Specify_the_brightness_of_the_light"
#List of Metadata related to the InfoItem 'Brightness'
Brightness_metadata="range documentation"
#List of values related to the respective above Metadata ('range' and 'documentation')
Brightness_metadata_values="[0;255] https://en.wikipedia.org/wiki/Brightness"