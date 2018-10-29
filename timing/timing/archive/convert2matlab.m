

lists = {'02' '04' '06' '07' '11' '13' '14' '15' '17' '18'};

order = zeros(50,3,10)
for i = 1:length(lists)
list = readtable(['cardmid-0' lists{i} '.txt']);
ind = find(strcmp(list.Var5, 'NULL'));
list(ind,:)=[];
jitter = [ones(17,1); (ones(16,1)+1); (ones(17,1)+2)];
jitter=jitter(randperm(50));
order(:,:,i) = [list.Var2 list.Var1 jitter];
[sum(order(:,1,i)==1) sum(order(:,1,i)==2) sum(order(:,1,i)==3) sum(order(:,1,i)==4) sum(order(:,1,i)==5)]
end

