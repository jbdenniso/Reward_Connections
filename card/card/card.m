%function MID2(isscan, subnum)
Screen('Preference', 'SkipSyncTests', 1);
global thePath; rand('state',sum(100*clock));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%subnum - subject number is 0 for practice, real number if it is a run
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subnum = input('subnumber: ');
whichrun = input('which run (1 or 2):');

% Add this at top of new scripts for maximum portability due to unified names on all systems:
KbName('UnifyKeyNames');
Screen('Preference', 'VisualDebuglevel', 3);

thePath.start = pwd;                                % starting directory
thePath.data = fullfile(thePath.start, 'data');     % path to Data directory
thePath.scripts = fullfile(thePath.start, 'scripts');
thePath.stims = fullfile(thePath.start, 'stimuli');

addpath(thePath.scripts)
addpath(thePath.stims)

% set up device number
if IsOSX
    k = GetKeyboardIndices;
else
    k = 1;
end

%%%%%% CONSTANT DECLARED VARIABLES %%%%%%%%%%%%%%%

text_size = 30;
ms=0.06;                    %duration of time post-target until responses are accepted (no keys accepted)
card_time = 1.5;
outcome_time = 1.5;
feedback_time = 1.5;

load([ thePath.start '/timing/run' num2str(whichrun) '.mat'])

%define intertrial fixation
fix_isi = run.isi2;
fix_iti = run.isi1;
trial_cond = run.cond;

backtick = '=';
mkdir(fullfile(thePath.data,num2str(subnum)));

Screen('CloseAll')

%%%SET UP SCREEN PARAMETERS FOR PTB
screens = Screen('Screens');
%Make sure this is alright
screenNumber = max(screens); HideCursor;
[Screen_X, Screen_Y]=Screen('WindowSize',screenNumber);

% USE THESE LINES FOR SET SCREEN
screenRect = [ 0 0 1024 768];
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;

[Window, Rect] =PsychImaging('OpenWindow', screenNumber, grey);
Hcenter=Rect(3)/2
Vcenter=Rect(4)/2
Screen('TextSize',Window,text_size);
Screen('FillRect', Window, 0);  % 0 = black background

% LOAD STIMULI
Instruction_1 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'/Instructions/Slide1'), 'PNG'));
Instruction_2 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'/Instructions/Slide2'), 'PNG'));
Instruction_3 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'/Instructions/Slide3'), 'PNG'));
Instruction_4 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'/Instructions/Slide4'), 'PNG'));
Instruction_5 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'/Instructions/Slide5'), 'PNG'));

[normBoundsRect, notused] = Screen('TextBounds', Window, 'loading stimuli....');
Screen('DrawText',Window, 'loading stimuli....', Hcenter-normBoundsRect(3)/2, Vcenter-normBoundsRect(4)/2, [255 255 255]);
Screen('Flip', Window);
WaitSecs(3)

Screen('DrawTexture', Window, Instruction_1);
Screen('Flip',Window);
if IsOSX
    getKey(backtick, k);                             % wait for backtick before continuing
else
    getKey(backtick);
end

Screen('DrawTexture', Window, Instruction_2);
Screen('Flip',Window);
if IsOSX
    getKey(backtick, k);                             % wait for backtick before continuing
else
    getKey(backtick);
end

Screen('DrawTexture', Window, Instruction_3);
Screen('Flip',Window);
if IsOSX
    getKey(backtick, k);                             % wait for backtick before continuing
else
    getKey(backtick);
end
Screen('DrawTexture', Window, Instruction_4);
Screen('Flip',Window);
if IsOSX
    getKey(backtick, k);                             % wait for backtick before continuing
else
    getKey(backtick);
end
Screen('DrawTexture', Window, Instruction_5);
Screen('Flip',Window);
if IsOSX
    getKey(backtick, k);                             % wait for backtick before continuing
else
    getKey(backtick);
end

%LOAD IN FIXATIONS
fix1 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'cross'), 'png'));
fix2 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'dot'), 'png'));

% LOAD CARD STIMULI
guess = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'card_guess'), 'png'));
outcome_HW = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'high_green'), 'png'));
outcome_LW = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'low_green'), 'png'));
outcome_HL = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'high_red'), 'png'));
outcome_LL = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'low_red'), 'png'));
outcome_N = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'neutral'), 'png'));
uhoh = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'uhoh'), 'png'));
card_1 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'1'), 'png'));
card_2 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'2'), 'png'));
card_3 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'3'), 'png'));
card_4 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'4'), 'png'));
card_5 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'5'), 'png'));
card_6 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'6'), 'png'));
card_7 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'7'), 'png'));
card_8 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'8'), 'png'));
card_9 = Screen('MakeTexture', Window, imread(fullfile(thePath.stims,'9'), 'png'));

low_cards = [card_1 card_2 card_3 card_4];
high_cards = [card_6 card_7 card_8 card_9];

[normBoundsRect, notused] = Screen('TextBounds', Window,'Get Ready for the Experiment!' );
Screen('DrawText',Window, 'Get Ready for the Experiment!', Hcenter-normBoundsRect(3)/2,Vcenter-normBoundsRect(4)/2,[255 255 255]);
Screen('Flip', Window);

%%%%%%%%%%%%%%%%%%%%%%%% BEGIN TRIAL LOOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% record run start time (post disdaqs) CHECK ON WHEN IT SENDS TRIGGER

if IsOSX
    getKey(backtick, k);                             % wait for backtick before continuing
else
    getKey(backtick);
end

runST = GetSecs;
Screen('DrawTexture', Window, fix1);
Screen('Flip', Window);
WaitSecs(4);


for t = 1:length(trial_cond)
    
    Screen('DrawTexture', Window, guess);
    Screen('Flip', Window);
    [keys, RT] = recordKeysNoBT(GetSecs, card_time, k, backtick);
    Screen('DrawTexture', Window, fix2);
    Screen('Flip', Window);
    WaitSecs(fix_isi(t))
    
 if  sum(strcmp(keys(1), {'1' '2'})) < 1
        
        Screen('DrawTexture', Window, uhoh);
        Screen('Flip', Window);  
        WaitSecs(outcome_time)
        Screen('DrawTexture', Window, outcome_N);
        Screen('Flip', Window);  
        WaitSecs(feedback_time)
 else
    if trial_cond(t) == 1
        if strcmp(keys(1),'1')
            disp_card = Shuffle(low_cards);
            disp_card = disp_card(1);
        elseif strcmp(keys(1), '2')
            disp_card = Shuffle(high_cards);
            disp_card = disp_card(1);
        end
        imgsize=size(disp_card)
        Screen('DrawTexture', Window, disp_card);
        Screen('Flip', Window);
        WaitSecs(outcome_time)        
        Screen('DrawTexture', Window, outcome_HW);
        Screen('Flip', Window);
        WaitSecs(feedback_time)
    elseif trial_cond(t) == 2
        if strcmp(keys(1),'1')
            disp_card = Shuffle(high_cards);
            disp_card = disp_card(1);
        elseif strcmp(keys(1), '2')
            disp_card = Shuffle(low_cards);
            disp_card = disp_card(1);
        end
        Screen('DrawTexture', Window, disp_card);
        Screen('Flip', Window);
        WaitSecs(outcome_time)
        Screen('DrawTexture', Window, outcome_HL);
        Screen('Flip', Window);
        WaitSecs(feedback_time)
    elseif trial_cond(t) == 3
        if strcmp(keys(1),'1')
            disp_card = Shuffle(low_cards);
            disp_card = disp_card(1);
        elseif strcmp(keys(1), '2')
            disp_card = Shuffle(high_cards);
            disp_card = disp_card(1);
        end
        Screen('DrawTexture', Window, disp_card);
        Screen('Flip', Window);
        WaitSecs(outcome_time)
        Screen('DrawTexture', Window, outcome_LW);
        Screen('Flip', Window);
        WaitSecs(feedback_time)
    elseif trial_cond(t) == 4
        if strcmp(keys(1),'1')
            disp_card = Shuffle(high_cards);
            disp_card = disp_card(1);
        elseif strcmp(keys(1), '2')
            disp_card = Shuffle(low_cards);
            disp_card = disp_card(1);
        end
        Screen('DrawTexture', Window, disp_card);
        Screen('Flip', Window);
        WaitSecs(outcome_time);
        Screen('DrawTexture', Window, outcome_LL);
        Screen('Flip', Window);
        WaitSecs(feedback_time)
    elseif trial_cond(t) == 5
        Screen('DrawTexture', Window, card_5);
        Screen('Flip', Window);
        WaitSecs(outcome_time)
        Screen('DrawTexture', Window, outcome_N);
        Screen('Flip', Window);
        WaitSecs(feedback_time)
    end
 end
    Screen('DrawTexture', Window, fix1);
    Screen('Flip', Window);
    WaitSecs(fix_iti(t)) ;
    output.response(t) = keys(1);
    output.RTs(t) = RT(1);
end

save([thePath.data '/' num2str(subnum) '/card.mat'], 'output')

sca;
