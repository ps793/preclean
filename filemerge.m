%%Run file preclean for each segment of day and manually combine files
%%vertically

    
A = precleanfile(acc(2).name,ind(1).name,sum(1).name);
B = precleanfile(acc(3).name,ind(2).name,sum(2).name);
C = precleanfile(acc(4).name,ind(3).name,sum(3).name);
D = precleanfile(acc(5).name,ind(4).name,sum(4).name);
Preclean121114 = vertcat(A,B,C,D);
Preclean121114_test = import_preclean(pre(1).name);


A = precleanfile(acc(7).name,ind(5).name,sum(5).name);
B = precleanfile(acc(8).name,ind(6).name,sum(6).name);
Preclean121214 = vertcat(B);
Preclean121214_test = import_preclean(pre(3).name);


A = precleanfile(acc(10).name,ind(8).name,sum(8).name);
B = precleanfile(acc(11).name,ind(9).name,sum(9).name);
C = precleanfile(acc(12).name,ind(10).name,sum(10).name);
D = precleanfile(acc(13).name,ind(11).name,sum(11).name);
Preclean121314 = vertcat(A,B,C,D);
Preclean121314_test = import_preclean(pre(5).name);


A = precleanfile(acc(15).name,ind(13).name,sum(13).name);
B = precleanfile(acc(16).name,ind(14).name,sum(14).name);
C = precleanfile(acc(17).name,ind(15).name,sum(15).name);
Preclean121414 = vertcat(A,B,C);
Preclean121414_test = import_preclean(pre(7).name);

A = precleanfile(acc(19).name,ind(17).name,sum(17).name);
B = precleanfile(acc(20).name,ind(18).name,sum(18).name);
C = precleanfile(acc(21).name,ind(19).name,sum(19).name);
D = precleanfile(acc(22).name,ind(20).name,sum(20).name);
Preclean121514 = vertcat(A,B,C,D);
Preclean121514_test = import_preclean(pre(9).name);

A = precleanfile(acc(25).name,ind(22).name,sum(23).name);
B = precleanfile(acc(26).name,ind(23).name,sum(24).name);
C = precleanfile(acc(27).name,ind(24).name,sum(25).name);
D = precleanfile(acc(28).name,ind(25).name,sum(26).name);
Preclean121614 = vertcat(A,B,C,D);
Preclean121614_test = import_preclean(pre(11).name);

A = precleanfile(acc(30).name,ind(26).name,sum(28).name);
B = precleanfile(acc(31).name,ind(27).name,sum(29).name);
C = precleanfile(acc(32).name,ind(28).name,sum(30).name);
D = precleanfile(acc(33).name,ind(29).name,sum(31).name);
Preclean121714 = vertcat(A,B,C,D);
Preclean121714_test = import_preclean(pre(14).name);

Preclean121814 = precleanfile(acc(35).name,ind(30).name,sum(32).name);
Preclean121814_test = import_preclean(pre(16).name);




acc =subdir('*AccMG*-*.csv');
ind = subdir('*ind*.csv');
sum = subdir('*um*.csv');
pre = subdir('*clean*.csv');



A = Preclean121314_test{2:end,1};
A = char(A);
B = A(:,1:8);

C = char(accfiveseconds)
























