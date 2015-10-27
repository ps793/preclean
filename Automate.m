

A = dir('AccMG*');
B = dir('Indications*');
C = dir('NewSummary*');

S = [A(:).datenum].'; 
[~,S] = sort(S);
AccSort = {A(S).name};

S = [B(:).datenum].'; 
[~,S] = sort(S);
IndicationsSort = {B(S).name};

S = [C(:).datenum].'; 
[~,S] = sort(S);
SummarySort = {C(S).name};



if mod((length(A) + length(B) + length(C)),3)
    warning('Unequal number of data files for day')
else
    File_num = length(A);
end