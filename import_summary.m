function summ = import_summary(directory)


dataArray=readtable(directory);

%% Create output variable
%summ = table(dataArray{1:end-1}, 'VariableNames', {'DateMdyyyy','TimeHHmmss','HRbpm','BRrpm','SkinTemperatureIRThermometer','BodyPosition','AmbulationStatus'});
summ = dataArray(:,{'Date_M_d_yyyy_','Time_HH_mm_ss_','HR_bpm_','BR_rpm_','SkinTemperature_IRThermometer_','BodyPosition','AmbulationStatus'});
summ.Properties.VariableNames([1 2 3 4 5])={'DateMdyyyy','TimeHHmmss','HRbpm','BRrpm','SkinTemperatureIRThermometer'};

% For code requiring serial dates (datenum) instead of datetime, uncomment
% the following line(s) below to return the imported dates as datenum(s).

% NewSummary1005121214a.DateMdyyyy=datenum(NewSummary1005121214a.DateMdyyyy);NewSummary1005121214a.TimeHHmmss=datenum(NewSummary1005121214a.TimeHHmmss);

