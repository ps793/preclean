%%Plot activity and Accelerometer

figure
plot(Preclean33115{:,16})
title('Activity')
axis([0 12000 600 1000])

figure
plot(Preclean33115{:,10:12})
title('Accelerometers')
axis([0 12000 -2000 2000])


figure
plot(Preclean33115_test{:,10:12})
title('Test Accelerometer')
axis([0 12000 -2000 2000])

figure
plot(Preclean33115_test{:,16})
title('Test Activity')
axis([0 12000 600 1000])

%% Correlation Coeffecients for HR, BR, Activity, Skin Temp

% Skin Temp
SkintmpCorr = corr(Preclean33115{:,2},Preclean33115_test{:,2})

% Activity
A = Preclean33115{:,16};
B = Preclean33115_test{:,16};
C = horzcat(A,B);
ActivityCorr = corrcoef(C,'rows','pairwise')

% Heart Rate
A = Preclean33115{:,14};
B = Preclean33115_test{:,14};
B = str2double(B);
C = horzcat(A,B);
HRCorr = corrcoef(C,'rows','pairwise')

% Breath Rate
A = Preclean33115{:,15};
B = Preclean33115_test{:,15};
B = str2double(B);
C = horzcat(A,B);
BHRCorr = corrcoef(C,'rows','pairwise')






