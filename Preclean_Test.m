function[SkintmpCorr, ActivityCorr, HRCorr, BHRCorr] = Preclean_Test(precleaned,test)
%%Plot activity and Accelerometer

figure
plot(precleaned{:,16})
title('Activity')
axis([0 12000 600 1000])

figure
plot(precleaned{:,10:12})
title('Accelerometers')
axis([0 12000 -2000 2000])


figure
plot(test{:,10:12})
title('Test Accelerometer')
axis([0 12000 -2000 2000])

figure
plot(test{:,16})
title('Test Activity')
axis([0 12000 600 1000])

%% Correlation Coeffecients for HR, BR, Activity, Skin Temp

% Skin Temp
A = precleaned{:,2};
B = test{:,2};
C = horzcat(A,B);
SkintmpCorr = corrcoef(C,'rows','pairwise')

% Activity
A = precleaned{:,16};
B = test{:,16};
C = horzcat(A,B);
ActivityCorr = corrcoef(C,'rows','pairwise')

% Heart Rate
A = precleaned{:,14};
B = test{:,14};
B = str2double(B);
C = horzcat(A,B);
HRCorr = corrcoef(C,'rows','pairwise')

% Breath Rate
A = precleaned{:,15};
B = test{:,15};
B = str2double(B);
C = horzcat(A,B);
BHRCorr = corrcoef(C,'rows','pairwise')






