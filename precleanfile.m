function [featureformat] = precleanfile(Accelerometer,Indications,Summary)


%load in Accelerometer data files
[DateMdyyyy,TimeHHmmss000,LateralAcc,LongitudinalAcc,VerticalAcc] = import_acc(Accelerometer);

%load in Indication data files
ind1 = import_indications(Indications);

%Load in Summary data files
summ1 = import_summary(Summary);


%%Averge and format raw accelerometer file by calling ACC allign acc1 file by calling 
[accseconds,seconds] = Accallign(TimeHHmmss000,LateralAcc, LongitudinalAcc, VerticalAcc);

accfiveseconds = summ1{:,2};
formatlength = length(accfiveseconds);
fivesecavg = zeros(formatlength,3);

A = char(accseconds);
B = A(:,1:8);
C = char(accfiveseconds);

for i = 1:length(accseconds)
    
   if strcmp(B(i,(1:end)),C(1,(1:end)));
        accindex = i;
        break
    end
end
rangemin = accindex ; 
rangemax = accindex + 5;


for i = 1:formatlength
    
    if strcmp(B(accindex,(1:end)),C(i,(1:end))) == 0
        
        newrangemin = rangemax;
        newrangemax = newrangemin;
        for p = 1:10
          
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

fivesecavg = circshift(fivesecavg,-1,1);
ACCformated = table(accfiveseconds,fivesecavg,'VariableNames',{'TimeHHmmss000','Accraw'});

V = table2array(ACCformated(:,2));

%Create activity feature based on magnatude of accelerometer files
x = V(:,1);
y = V(:,2);
z = V(:,3);
magnitude = @(x,y,z) sqrt(x.^2 + y.^2 + z.^2);
activity = magnitude(x,y,z);

%Create table with formatted feutures
featureformat = table(ACCformated{:,1}, summ1{:,5},summ1{:,6},summ1{:,7}, ind1{:,3}, ind1{:,4},ind1{:,5}, ind1{:,6}, summ1{:,2},V(:,1),V(:,2),V(:,3),summ1{:,1}, summ1{:,3}, summ1{:,4},activity ,'VariableNames',{'Time__HH_mm_ss_' 'Skin_Temperature__IR_Thermometer' 'Body_Position' 'Ambulation_Status' 'Low_HR_Confidence' 'HR_Confidence' 'Low_BR_Confidence' 'BR_Confidence' 'time' 'Lateral_Acc' 'Longitudinal_Acc' 'Vertical_Acc' 'date' 'HR' 'BR' 'activity'});

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



