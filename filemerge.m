%%Run file preclean for each segment of day and manually combine files
%%vertically

    
A = precleanfile(acc(2).name,Ind(1).name,Sum(1).name);
B = precleanfile(acc(3).name,Ind(2).name,Sum(2).name);
C = precleanfile(acc(4).name,Ind(3).name,Sum(3).name);
D = precleanfile(acc(5).name,Ind(4).name,Sum(4).name);




A = precleanfile(acc(4).name,Ind(4).name,Sum(4).name);
B = precleanfile(acc(4).name,Ind(4).name,Sum(4).name);
Preclean40315 = vertcat(A,B);


Preclean40515 = precleanfile(acc(6).name,Ind(7).name,Sum(7).name);


Preclean40115_test = importpreclean(pre(3).name);

acc =subdir('*AccMG*-*.csv');
ind = subdir('*ind*.csv');
sum = subdir('*um*.csv');
pre = subdir('*clean*.csv');
