function [C,repetition_duration] = jct_telethon
% C needs fields experiment, closed_loop and initial_alignment
% 
% up and down presented unilaterally to see if I can get turning or
% potential comparison

%===Gather all the contents of the SD card=================================
    
    func_loc=mfilename('fullpath');
    SD_card = fullfile(func_loc,'..','SD_card_contents');

    patterns = dir([SD_card filesep 'Pattern*']);
    patterns = {patterns.name};

    position_functions = dir([SD_card filesep 'position_function*']);
    position_functions = {position_functions.name};

    panel_cfgs = dir([SD_card filesep 'cfg*']);
    panel_cfgs = {panel_cfgs.name};
    
%===Make the conditions====================================================
    
% Start a few variables for below
cond_num = 1;
total_ol_dur = 0;
default_frequency = 50;
ol_duration = 2.5;
cl_duration = 3;

% from telethon_vel_nulling_conditions_9_14
% These are all of the velocity nulling conditions (30 of them)
% 1
C.experiment(cond_num).PatternID = 6;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [4 0 -48 0 ];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 2
C.experiment(cond_num).PatternID = 6;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-4 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 3
C.experiment(cond_num).PatternID = 7;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [4 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 4
C.experiment(cond_num).PatternID = 7;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-4 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 5
C.experiment(cond_num).PatternID = 8;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [4 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 6
C.experiment(cond_num).PatternID = 8;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-4 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 7
C.experiment(cond_num).PatternID = 6;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [16 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 8
C.experiment(cond_num).PatternID = 6;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-16 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 9
C.experiment(cond_num).PatternID = 7;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [16 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 10
C.experiment(cond_num).PatternID = 7;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-16 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 11
C.experiment(cond_num).PatternID = 8;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [16 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 12
C.experiment(cond_num).PatternID = 8;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-16 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 13
C.experiment(cond_num).PatternID = 6;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [64 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 14
C.experiment(cond_num).PatternID = 6;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-64 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 15
C.experiment(cond_num).PatternID = 7;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [64 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 16
C.experiment(cond_num).PatternID = 7;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-64 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 17
C.experiment(cond_num).PatternID = 8;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [64 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 18
C.experiment(cond_num).PatternID = 8;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-64 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 19
C.experiment(cond_num).PatternID = 6;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [128 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 20
C.experiment(cond_num).PatternID = 6;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-128 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 21
C.experiment(cond_num).PatternID = 7;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [128 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 22
C.experiment(cond_num).PatternID = 7;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-128 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 23
C.experiment(cond_num).PatternID = 8;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [128 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 24
C.experiment(cond_num).PatternID = 8;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-128 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 25
C.experiment(cond_num).PatternID = 6;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [192 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 26
C.experiment(cond_num).PatternID = 6;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-192 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 27
C.experiment(cond_num).PatternID = 7;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [192 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 28
C.experiment(cond_num).PatternID = 7;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-192 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 29
C.experiment(cond_num).PatternID = 8;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [192 0 -48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 30
C.experiment(cond_num).PatternID = 8;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-192 0 48 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 

% from telethon_tuning_shorter_conditions_9_14 (16 conditions)
% here are the lam = 45 full field rotation 
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [4 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [-4 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [-24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [-72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [144 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [-144 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% here are the low contrast rotations
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [-48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 4];
C.experiment(cond_num).Gains = [48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 4];
C.experiment(cond_num).Gains = [-48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 5];
C.experiment(cond_num).Gains = [48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 5];
C.experiment(cond_num).Gains = [-48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 

% from telethon_tuning_conditions_9_14 (was 40 conditions)
% here are the lam = 30 full field rotations
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [4 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-4 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [144 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-144 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% lam = 60 full field rotation
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [4 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-4 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [144 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 2;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-144 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_12_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 3;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [4 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_13_expansion_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 3;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-4 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_13_expansion_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 3;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_13_expansion_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 3;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_13_expansion_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% These conditions were formerly duplicates of several contrast rotaions
% already run above... AFTER 8/17/2012 they were changed to an equal number
% of different conditions...
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [-48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 4];
C.experiment(cond_num).Gains = [48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 4];
C.experiment(cond_num).Gains = [-48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 5];
C.experiment(cond_num).Gains = [48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 4;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 5];
C.experiment(cond_num).Gains = [-48 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_14_rotation_contrasts_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 

% Rest of the rotations from telethon_tuning_conditions_9_14
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [8 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-8 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [-72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [8 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-8 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 5;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-72 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_15_rp_rotation_sf_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 

% from telethon_small_field_conditions_9_14  (18 conditions)
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 7];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_1.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 8];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_2.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 9];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_1.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 10];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_2.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 11];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_1.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 12];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_2.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 2];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 7];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_1.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 2];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 8];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_2.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 2];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 9];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_1.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 2];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 10];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_2.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 2];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 11];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_1.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 2];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 12];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_2.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 3];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 7];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_1.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 3];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 8];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_2.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 3];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 9];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_1.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 3];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 10];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_2.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 3];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 11];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_1.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 10;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [47 3];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 12];
C.experiment(cond_num).PatternName = 'Pattern_20_4wide_stripes_48P_RC.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_2.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
% from telethon_optic_flow_condition_9_14 (12 conditions)
C.experiment(cond_num).PatternID = 16;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 3];
C.experiment(cond_num).PatternName = 'Pattern_26_lift_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 16;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 4];
C.experiment(cond_num).PatternName = 'Pattern_26_lift_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 17;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 3];
C.experiment(cond_num).PatternName = 'Pattern_27_pitch_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 17;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 4];
C.experiment(cond_num).PatternName = 'Pattern_27_pitch_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 18;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 3];
C.experiment(cond_num).PatternName = 'Pattern_28_roll_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 18;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 4];
C.experiment(cond_num).PatternName = 'Pattern_28_roll_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 19;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 3];
C.experiment(cond_num).PatternName = 'Pattern_29_sideslip_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 19;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 4];
C.experiment(cond_num).PatternName = 'Pattern_29_sideslip_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 20;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 3];
C.experiment(cond_num).PatternName = 'Pattern_30_thrust_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 20;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 4];
C.experiment(cond_num).PatternName = 'Pattern_30_thrust_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 21;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 3];
C.experiment(cond_num).PatternName = 'Pattern_31_yaw_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 
C.experiment(cond_num).PatternID = 21;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [0 0 0 0];
C.experiment(cond_num).Mode = [4 0];
C.experiment(cond_num).PosFunctionX = [1 4];
C.experiment(cond_num).PatternName = 'Pattern_31_yaw_gs2.mat';
C.experiment(cond_num).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 

% from telethon_onoff_conditions_9_14 (8 conditions)
%
C.experiment(cond_num).PatternID = 12;
C.experiment(cond_num).Duration = ol_duration;% 3;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [3 0 1 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_22_expansion_on_foeleft_48_RC_telethon.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 13;
C.experiment(cond_num).Duration = ol_duration;% 3;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [3 0 1 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_23_expansion_on_foeright_48_RC_telethon.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 14;
C.experiment(cond_num).Duration = ol_duration;% 3;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [3 0 1 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_24_expansion_off_foeleft_48_RC_telethon.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 15;
C.experiment(cond_num).Duration = ol_duration;% 3;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [3 0 1 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_25_expansion_off_foeright_48_RC_telethon.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 11;
C.experiment(cond_num).Duration = ol_duration;% 3;
C.experiment(cond_num).InitialPosition = [1 1];
C.experiment(cond_num).Gains = [32 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_21_on_off_motion_telethon_pattern_8wide.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 11;
C.experiment(cond_num).Duration = ol_duration;% 3;
C.experiment(cond_num).InitialPosition = [1 2];
C.experiment(cond_num).Gains = [-32 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_21_on_off_motion_telethon_pattern_8wide.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 11;
C.experiment(cond_num).Duration = ol_duration;% 3;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [32 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_21_on_off_motion_telethon_pattern_8wide.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 11;
C.experiment(cond_num).Duration = ol_duration;% 3;
C.experiment(cond_num).InitialPosition = [1 4];
C.experiment(cond_num).Gains = [-32 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_21_on_off_motion_telethon_pattern_8wide.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 

%
% from telethon_bilateral_conditions_9_14 (12 conditions)
C.experiment(cond_num).PatternID = 22;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [8 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_32_rotation_left_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 23;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-8 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_33_rotation_right_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 23;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [8 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_33_rotation_right_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 22;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-8 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_32_rotation_left_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 22;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_32_rotation_left_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 23;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_33_rotation_right_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 23;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_33_rotation_right_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 22;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-24 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_32_rotation_left_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 22;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [96 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_32_rotation_left_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 23;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-96 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_33_rotation_right_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
%
C.experiment(cond_num).PatternID = 23;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [96 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_33_rotation_right_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 
C.experiment(cond_num).PatternID = 22;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 3];
C.experiment(cond_num).Gains = [-96 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_32_rotation_left_half_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 

% 4 Hz Flicker (slightly faster than Duistermars et al 2012) (2 conditions)
% 
C.experiment(cond_num).PatternID = 24;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 1]; % Left Side
C.experiment(cond_num).Gains = [8 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_34_flicker_halves_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 
% 
C.experiment(cond_num).PatternID = 24;
C.experiment(cond_num).Duration = ol_duration;% 2.5;
C.experiment(cond_num).InitialPosition = [1 2]; % Right Side
C.experiment(cond_num).Gains = [8 0 0 0];
C.experiment(cond_num).Mode = [0 0];
C.experiment(cond_num).PosFunctionX = [1 0];
C.experiment(cond_num).PatternName = 'Pattern_34_flicker_halves_gs3.mat';
C.experiment(cond_num).PosFuncNameX = 'none';
total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration;cond_num = cond_num + 1; 

% Small object tracking new in the 2012 protocol (8 conditions)
% maintain the voltage values...
cond_num = cond_num + 8;

%===Set up closed_loop values==============================================
    C.closed_loop.PatternID      = 1;
    C.closed_loop.PatternName    = 'Pattern_11_8wide_bothcontrasts_stripes_c49_telethon.mat';
    C.closed_loop.Mode           = [1 0];
    C.closed_loop.InitialPosition= [49 1];
    C.closed_loop.Gains          = [-14 0 0 0];
    C.closed_loop.PosFunctionX   = [1 0];
    C.closed_loop.PosFunctionY   = [2 0];
    C.closed_loop.FuncFreqY      = default_frequency;
    C.closed_loop.FuncFreqX 	 = default_frequency;
    C.closed_loop.PosFuncLoc     = 'none';            
    C.closed_loop.PosFuncNameX   = 'none';
    C.closed_loop.PosFuncNameY   = 'none';
    C.closed_loop.PanelCfgNum    = 1;
    C.closed_loop.PanelCfgName   = panel_cfgs{1};
    C.closed_loop.Duration       = cl_duration;
    C.closed_loop.Voltage        = 0; % Very important!
    
%===Set up initial_alignment values========================================
    C.initial_alignment = C.closed_loop;

%===Assign voltage values to the experimental conditions===================

    encoded_vals = linspace(.1,9.9,numel(C.experiment));
    for cond_num = 1:numel(C.experiment)
        C.experiment(cond_num).Voltage        = encoded_vals(cond_num);
        C.experiment(cond_num).PanelCfgNum    = 1;
        C.experiment(cond_num).PanelCfgName   = panel_cfgs{1};
        C.experiment(cond_num).PosFuncLoc     = SD_card;
        C.experiment(cond_num).PatternLoc     = SD_card;
        C.experiment(cond_num).FuncFreqY      = default_frequency;
        C.experiment(cond_num).FuncFreqX      = default_frequency;
        C.experiment(cond_num).PosFunctionY   = [2 0];
        C.experiment(cond_num).PosFuncNameY   = 'none';
    end
    
    total_dur = total_ol_dur + numel(C.experiment)*C.closed_loop.Duration;
    repetition_duration = total_dur/60;

end