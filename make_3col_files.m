load('timing.mat'); % loads order variable

designs = 10;
conditions = 5;

for d = 1:designs
    outputdir = fullfile('output',sprintf('des-%02d',d));
    mkdir(outputdir);
    for c = 1:conditions
        eventA_onsets = order(order(:,1,d)==c,2,d);
        eventB_onsets = eventA_onsets + order(order(:,1,d)==c,3,d) + 1;
        ones_col = ones(length(eventA_onsets),1);
        eventA = [eventA_onsets ones_col ones_col];
        eventB = [eventB_onsets ones_col ones_col];
        eventA_f = fullfile(outputdir,['condition' num2str(c) 'A.txt']);
        eventB_f = fullfile(outputdir,['condition' num2str(c) 'B.txt']);
        dlmwrite(eventA_f,eventA,'delimiter','\t');
        dlmwrite(eventB_f,eventB,'delimiter','\t');
    end
end
