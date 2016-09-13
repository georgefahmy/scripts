# scripts

This readme will explain how to set up matlab paths and scripts for use with your own computer.

Make sure to git pull the latest from the repo.

First step to using the scripts is to set the correct paths to the 
functions/scripts.
Select 'HOME' from the top tab in the matlab window. 
Then select 'Set Path'.
This will open up a window with a list of the paths used by matlab.
Select 'Add Folder' and choose the folder that you cloned the repo in.

For example:

'~/Documents/projects/scripts/src/'
'~/Documents/projects/scripts/functions/'


Once these two folders are added in the window, select 'Save' and 'Close'.

You are now ready to run the matlab analysis scripts!

##########
The primary script is <flight.m> and will call all required functions to 
import flight data into matlab for analyis.

In order to begin analyzing data the first step will be to set the default 
path in the <loaddata.m> function. 

Open <loaddata.m> and change this line

<startdir = '/Users/georgeKespry/Documents/Projects/Matlab/Data/'>

to "startdir = '~/<mypath_to_my_data_folder>'" and set it to your data directory. 

Once this is done, then you are good to go!

##########
plotting data

open the <plots.m> to see a preset list of available plotting scripts.
the data that is imported is done so in structure form. 
example:

emb_mgmt = 
recv_timestamp: [7835x1 double]
timestamp: [7835x1 double]
bms_voltage: [1306x1 double]
bms_current: [1306x1 double]
bms_pack_temperature: [1306x1 double]
bms_integrated_current: [1305x1 double]
bms_power: [1306x1 double]

The usage of structure allows for extremely organized data storage.

To call the vector stored in the struct use dot notation 
example:

emb_mgmt.recv_timestamp
or
emb_mgmt.bms_power

Doing either of these will call the variable recv_timestamp or bms_power 
from within the struct emb_mgmt. This allows for the organization of each 
telemtry file in its own struct.

list of available variables:

'att_con_telem'
'att_rate_con_telem'
'baro'
'command_interface_status'
'con_con_config'
'controller_watchdog_plan'
'emb_command'
'emb_controller'
'emb_estimator'
'emb_mgmt'
'emb_sensor'
'emb_state'
'gps_state'
'gps_ubx_nav_pvt'
'gps_ubx_nav_svinfo'
'high_controller_time_stats'
'lidar'
'mission_progress'
'path_queue'
'path_target'
'pos_con_config'
'pos_con_telemetry'
'sensor_x86'
'system_monitor'
'system_monitor_process_stats'
'meta'

This is the standard variable set that is recorded by the drone's computer.
All of these are structs.

A convient way to plot a variable from a struct is to use the <plotter.m> 
script it will open a window with available structs to plot. The User can 
select a struct and then select a single (or multiple) variable(s) from 
that struct. the script will then plot those variables vs time in a window,
with legend, and lables. 

If multple structs want to be plotted for comparison, for example, 
emb_state and gps_state, the <plotter.m> function can be run a twice in a 
row, and a small window will prompt the user if they would like to plot 
data on the same graph. This is useful for quickly plotting gps and 
embedded data.

##########
This is the basic intro to using the matlab scripts. The uses are endless, 
however this is a good place to start.