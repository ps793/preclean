%%%%%%accmg
acc=subdir('C:\Users\lukeguerdan\Desktop\1005 raw\*cc*-*.csv');
for i=3:size(acc,1)
    accfile(i-2,1)=cellstr(acc(i).name(1:end-5));
end;

accname=unique(accfile);

for i=1:size(accname,1)
    index=1;
    for j=3:size(acc,1)
        if strcmp(acc(j).name(1:end-5),accname(i))
            acc_class{i}(index)=cellstr(acc(j).name);
            index=index+1;
        end;
    end;
end;

%%%%%%%%%indication
indication=dir('C:\Users\pp\Desktop\1005 raw\indications');
for i=3:size(indication,1)
    indicationfile(i-2,1)=cellstr(indication(i).name(1:end-5));
end;

indicationname=unique(indicationfile);

for i=1:size(indicationname,1)
    index=1;
    for j=3:size(indication,1)
        if strcmp(indication(j).name(1:end-5),indicationname(i))
            indication_class{i}(index)=cellstr(indication(j).name);
            index=index+1;
        end;
    end;
end;

%%%%new summary
newsummary=dir('C:\Users\pp\Desktop\1005 raw\New Summary');
for i=3:size(newsummary,1)
    newsummaryfile(i-2,1)=cellstr(newsummary(i).name(1:end-5));
end;

newsummaryname=unique(newsummaryfile);

for i=1:size(newsummaryname,1)
    index=1;
    for j=3:size(newsummary,1)
        if strcmp(newsummary(j).name(1:end-5),newsummaryname(i))
            newsummary_class{i}(index)=cellstr(newsummary(j).name);
            index=index+1;
        end;
    end;
end;




for i=1:size(acc_class,2)
    for j=1:size(acc_class{i},2)
        data{i,j}=precleanfile('C:\Users\pp\Desktop\1005 raw',acc_class{i}(j),indication_class{i}(j),newsummary_class{i}(j));
    end;
end;
        





A = precleanfile('AccMG1005 12-12-14a.csv','Indications1005 12-12-14a.csv','NewSummary1005 12-12-14a.csv');
