%%Run file preclean for each segment of day and manually combine files
%%vertically

    
A = precleanfile('C:\Users\pp\Desktop\1005 raw','AccMG#1005 12-11-14a.csv','Indications#1005 12-11-14a.csv','NewSummary#1005 12-11-14a.csv');
B = precleanfile('C:\Users\pp\Desktop\1005 raw','AccMG#1005 12-12-14b.csv','Indications#1005 12-12-14b.csv','NewSummary#1005 12-12-14b.csv');

C = vertcat(A,B);

figure
plot(C{:,16})
title('Activity')
axis([0 12000 600 1000])

figure
plot(C{:,10:12})
title('Accelerometers')
axis([0 12000 -2000 2000])


figure
plot(Test{:,11:13})
title('Test Accelerometer')
axis([0 12000 -2000 2000])

figure
plot(Test{:,17})
title('Test Activity')
axis([0 12000 600 1000])