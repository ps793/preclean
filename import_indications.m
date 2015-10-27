function ind = import_indications(directory,filename)

%directory=ind_directory;
%filename='Indications1005 12-12-14a.csv';
full_filename=fullfile(directory,filename);
dataArray=readtable(full_filename);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
%ind = table(dataArray, 'VariableNames', {'DateMdyyyy','TimeHHmmss000','LowHRConfidence','HRConfidence','LowBRConfidence','BRConfidence'});
ind = dataArray(:,{'Date_M_d_yyyy_','Time_HH_mm_ss_000_','LowHRConfidence','HRConfidence','LowBRConfidence','BRConfidence'});
ind.Properties.VariableNames([1 2])={'DateMdyyyy','TimeHHmmss000'};

% For code requiring serial dates (datenum) instead of datetime, uncomment
% the following line(s) below to return the imported dates as datenum(s).

% Indications1005121214a.DateMdyyyy=datenum(Indications1005121214a.DateMdyyyy);

