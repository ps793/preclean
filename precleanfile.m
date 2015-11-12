function [featureformat] = precleanfile(Accelerometer,Indications,Summary)
%%Primary formatting function. Take directory of raw accelerometer file,
%%Indications file and Summary file as an argument. Return n * 16 table 0f
%%formatted data.

%% Importing Files

%load in Accelerometer data files
%Return vector of Time (date type) and Accelerometer files (double)
[DateMdyyyy,TimeHHmmss000,LateralAcc,LongitudinalAcc,VerticalAcc] = import_acc(Accelerometer);


%load in Indication data files as a table
ind1 = import_indications(Indications);


%Load in Summary data files
summ1 = import_summary(Summary);


%% Prepare data for formatting.

%Averge and format raw accelerometer file by calling ACCallign. Return
%vector of time and N * 3 matrix of double accelerometer values.
[accseconds,seconds] = Accallign(TimeHHmmss000,LateralAcc, LongitudinalAcc, VerticalAcc);

%Use summary file time stamp as a basis for constructing the formatted
%file. Pre-allocate memory space and designate the length of the formatted
%array.

accfiveseconds = summ1{:,2};
formatlength = length(accfiveseconds);
fivesecavg = zeros(formatlength,3);

%Convert time signatures of seconds and five seconds to character arrays
%of equal length. This will allow for use of string comparison opperation to match up when the times allign.
A = char(accseconds);
B = A(:,1:8);
C = char(accfiveseconds);

%Find the positon when the accelerometer time and other file times first
%allign. Set the starting index for averging at this initial location when string compare first evaluates to true. 
for i = 1:length(accseconds)
    
   if strcmp(B(i,(1:end)),C(1,(1:end)));
        accindex = i;
        break
    end
end

%% Averaging accelerometer data.
%Because the sampling frequency of accelerometer data is still higher than
%the summary (1 sec vs. 5 sec), we need to calculate another average. Each
%5 second interval will hold the average of the previous 4 value and
%itsself. In order to do this we will create a moving window to scan
%through the length of the accelerometer file and store the results in fivesecavg.

%Establish beggening/end of moving frame.
rangemin = accindex ;
rangemax = accindex + 5;


for i = 1:formatlength
 
    if strcmp(B(accindex,(1:end)),C(i,(1:end))) == 0
    %This catches gaps in the accelerometer data. If a gap goes undetected,
    %this is an issue because it means the remainder of the day will have
    %data that is not properly aligned, and can not be analyzed.   
        newrangemin = rangemax;
        newrangemax = newrangemin;
        for p = 1:10
        %Scan the next 10 second values, if there is a gap in the timeseries data, 
        %use this index to split the time frame at this location.  
            if datenum(accseconds(newrangemax + 1)) - datenum(accseconds(newrangemax)) > 1.1574e-05
                for j = 1:3
                    fivesecavg(i,j) = mean(seconds((newrangemin:newrangemax),j));
                end;
                accindex = accindex + p;
                break
            
            else
                newrangemax = newrangemax + 1;
            end
        end
        
    else
    %Otherwise, continue as expected with averaging the files over each time frame. 
    %Increment the frame by 5 each iteration.  
        for j = 1:3
            try
                fivesecavg(i,j) = mean(seconds((rangemin:rangemax),j));
            catch
                fivesecavg(i,j) = mean(seconds((rangemin:end),j));
            end
        end
        rangemin = accindex - 4;
        rangemax = accindex;
        accindex = accindex + 5;
    end
end

% Shift the averages for the day five seconds back to match the averaging
% algorithm for the previous data. Combine the N * 3 matrix and
% corresponding time values into the ACCformated table.

fivesecavg = circshift(fivesecavg,-1,1);
ACCformated = table(accfiveseconds,fivesecavg,'VariableNames',{'TimeHHmmss000','Accraw'});

V = table2array(ACCformated(:,2));

%% Merging features together into a new table.
%Create activity feature based on magnatude of accelerometer files.
x = V(:,1);
y = V(:,2);
z = V(:,3);
magnitude = @(x,y,z) sqrt(x.^2 + y.^2 + z.^2);
activity = magnitude(x,y,z);

%Create table with formatted feutures. The result will be a N * 16 table.
featureformat = table(ACCformated{:,1}, summ1{:,5},summ1{:,6},summ1{:,7}, ind1{:,3}, ind1{:,4},ind1{:,5}, ind1{:,6}, summ1{:,2},V(:,1),V(:,2),V(:,3),summ1{:,1}, summ1{:,3}, summ1{:,4},activity ,'VariableNames',{'Time__HH_mm_ss_' 'Skin_Temperature__IR_Thermometer' 'Body_Position' 'Ambulation_Status' 'Low_HR_Confidence' 'HR_Confidence' 'Low_BR_Confidence' 'BR_Confidence' 'time' 'Lateral_Acc' 'Longitudinal_Acc' 'Vertical_Acc' 'date' 'HR' 'BR' 'activity'});


%% Filter outlier data.
%Filter out HR data with low confidence
lowHR = find(featureformat{:,6} <70);
for i = lowHR
    featureformat{i,14} = 0;
end;

%Filter out BR data with low confidence
lowBR = find(featureformat{:,8} <70);
for i = lowBR
    featureformat{i,15} = 0;
end;

%Filter outler HR data 
HR = find(featureformat{:,14} <40);
for i = HR
    featureformat{i,14} = 0;
end;

HR2 = find(featureformat{:,14} >200);
for i = HR2
    featureformat{i,14} = 0;
end;

%Filter outlier BR data
BR = find(featureformat{:,15} < 1);
for i = BR
    featureformat{i,15} = 0;
end;

%Filter outlier activity data
ACT = find(featureformat{:,16} > 1500);
for i = ACT
    featureformat{i,16} = 0;
end;



