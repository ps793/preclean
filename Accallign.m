function [accseconds,seconds] = Accallign(TimeHHmmss000,LateralAcc, LongitudinalAcc, VerticalAcc)

% List unique values of time in accelerometer file and store vector of
% indexes these occur at

[accseconds,ia] = unique(TimeHHmmss000);
a = zeros(length(accseconds),1);
b = zeros(length(accseconds),1);
c = zeros(length(accseconds),1);

indexsorted = sort(ia);
accseconds = TimeHHmmss000(indexsorted);


% Take mean valuse of accelerometer files for time interval between indexes

parfor i = 1:length(accseconds)
     try
        a(i) = mean(LateralAcc(indexsorted(i):indexsorted(i + 1) -1));
        b(i) = mean(LongitudinalAcc(indexsorted(i):indexsorted(i + 1) -1));
        c(i) = mean(VerticalAcc(indexsorted(i):indexsorted(i + 1) -1));
     catch
        a(i) = mean(LateralAcc(indexsorted(i):end));
        b(i) = mean(LongitudinalAcc(indexsorted(i):end));
        c(i) = mean(VerticalAcc(indexsorted(i):end));
     end
     
end
seconds = horzcat(a,b,c);
%Return a matrix of averagaed times and time vector.
















