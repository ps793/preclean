Creator: Luke Guerdan
Matlab release: R2015_a

================ DESCRIPTION =================
The included Matlab programs provide an automated and standardized system of import and formatting raw data files for the ambulatory assessment of alcohol craving study.

The term "precleaning" is used to refer to this automated process.

Generally, the functionality can be broken into 3 areas:
1) File import
    - import_acc .m
    - import_indications.m
    - import_summary.m

2) File processing/formatting
    - Accallign.m
    - pre cleanfile.m

3) Testing/verification
    - combine.m
    - filemerge.m
    - Preclean_Test.m
    - subdir.m


================ INCLUDED FUNCTIONS =================

import_acc.m

This function imports raw belt data files as 5 vectors.
Date, Time, Lat Acceleration, Long Acceleration, Vert Acceleration



import_indications.m

This function imports the indications file partially, only reading the necessary features and extracting them as a table in the workspace.

'Date_M_d_yyyy_','Time_HH_mm_ss_000_','LowHRConfidence','HRConfidence','LowBRConfidence','BRConfidence'



import_summary.m

This function imports the summary file partially, only reading the necessary features and extracting them as a table in the workspace.

'Date_M_d_yyyy_','Time_HH_mm_ss_000_','LowHRConfidence','HRConfidence','LowBRConfidence','BRConfidence'


import_preclean.m

This function is used to import precleaned files from the previous implementation and compare with the new one. It is not used in the primary data pipeline.


Accallign.m

This function is used to reduce the sampling frequency of the accelerometer file from 25 measurements/second to one measurement/second.



precleanfile.m

This function is the primary step in this portion of the date cleanin pipeline.
It takes the accelerometer file path, indications file path, and summary file path as arguments, and returns a workspace variable formatted as a table.

================ UTILITY SCRIPTS ================
The following script files are used to increase the efficiency of the calling the preclean file function, but are not formally included in the workflow.


subdir.m

Similarly to the 'dir' MATLAB command, subdir.m allows for recursive file search, and returns a table of file names, sizes, and other file attributes found within the directory/subdirectories.


filemerge.m

This function allows for vertical combination of each file from the day.

================ WORKFLOW ================

1:  prefleanfile calls import functions (summary, accelerometer,indications), then calls the calling function to adjust the accelerometer data.

2: preclean then compresses the accelerometer data to five second intervals, or keeps it at one second intervals, depending on the raw data frequency.

3: Once these are complete, a new table is formed based on a horizontal combination of the three raw files.

4: precleanfile then performs basic data filtering, and converts sensor values beyond a certain threshold to NAN.

5: Finally, separate files through the day are combined vertically to output a complete day worth of raw data.





















