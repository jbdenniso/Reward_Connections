load('timing.mat'); % loads order variable

designs = 10;
conditions = 5;

for d = 1:designs
    outputdir = fullfile('output',sprintf('des-%02d',d));
    mkdir(outputdir);
    
    mid_outcome = [];
    card_decision = [];
    for c = 1:conditions
        
        % MID (anticipation)
        ant_onsets = order(order(:,1,d)==c,2,d);
        out_onsets = ant_onsets + order(order(:,1,d)==c,3,d) + 1;
        ones_col = ones(length(ant_onsets),1);
        anticipation = [ant_onsets order(order(:,1,d)==c,3,d) ones_col];
        ant_f = fullfile(outputdir,['mid_ant_c' num2str(c) '.txt']);
        dlmwrite(ant_f,anticipation,'delimiter','\t');
        mid_outcome = [mid_outcome; [out_onsets ones_col ones_col]];
        
        % Card Task (consumption)
        dec_onsets = order(order(:,1,d)==c,2,d);
        out_onsets = dec_onsets + order(order(:,1,d)==c,3,d) + 1;
        ones_col = ones(length(ant_onsets),1);
        outcomes = [out_onsets ones_col ones_col];
        dec_f = fullfile(outputdir,['card_out_c' num2str(c) '.txt']);
        dlmwrite(dec_f,outcomes,'delimiter','\t');
        card_decision = [card_decision; [dec_onsets ones_col ones_col]];
        
    end
    rand_feedback = randperm(length(mid_outcome));
    mid_outcome_pos = mid_outcome(rand_feedback(1:33),:);
    mid_outcome_neg = mid_outcome(rand_feedback(34:50),:);
    mid_outcome_pos_f = fullfile(outputdir,'mid_out_pos.txt');
    mid_outcome_neg_f = fullfile(outputdir,'mid_out_neg.txt');
    dlmwrite(mid_outcome_pos_f,mid_outcome_pos,'delimiter','\t');
    dlmwrite(mid_outcome_neg_f,mid_outcome_neg,'delimiter','\t');
    
    card_decision_f = fullfile(outputdir,'card_guess.txt');
    dlmwrite(card_decision_f,card_decision,'delimiter','\t');
    
end
