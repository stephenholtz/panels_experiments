function [C,repetition_duration] = slow_rf_mot_flick_v1
% imaging protocol
% C needs to have fields:  initial_alignment, experiment, interpsersal
% This experiment will not use the interspersal period, and only rely 
% on stimuli with long static periods. 
%#ok<*NBRAK>
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
    pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]); %#ok<*NASGU>

    % Start a few variables for below
    cfg_num = 1;
    cond_num = 1;
    total_ol_dur = 0;
    default_frequency = 50;

    initial_time = 4; % 4 seconds pre stimulus
    
    stimulus_duration = 16.2; 
    for stim_type = 1:4
        switch stim_type
            case 1
                % Flickers
                pat_nums = [20:29];
                func_nums = [1];
                stimulus_duration = [12.2];
            case 2
                % Moving grating
                pat_nums = [1];
                func_nums = [2:3];
                stimulus_duration = [16];
            case 3
                % Moving grating
                pat_nums = [2];
                func_nums = [4:5];
                stimulus_duration = [16];
        end
        
        for pat_num = pat_nums
            for func_num = func_nums % all of the edge speeds (position functions)
                C.experiment(cond_num).DisplayType      = 'panels';
                C.experiment(cond_num).PatternID        = pat_num; %#ok<*AGROW>
                C.experiment(cond_num).PatternName      = patterns{pat_num};
                C.experiment(cond_num).Mode             = [4 0];
                C.experiment(cond_num).InitialPosition  = [1 1];
                C.experiment(cond_num).PosFunctionX     = [1 func_num];
                C.experiment(cond_num).PosFuncNameX     = position_functions{func_num};
                tmp=regexp(position_functions{func_num},'\SAMPRATE_','split');
                C.experiment(cond_num).FuncFreqX        = str2double(tmp{2}(1:4));
                % Y position function is not useable
                C.experiment(cond_num).PosFunctionY     = [2 0];
                C.experiment(cond_num).PosFuncNameY     = 'none';
                C.experiment(cond_num).FuncFreqY        = default_frequency;
                C.experiment(cond_num).Gains            = [0 0 0 0];
                C.experiment(cond_num).Duration         = stimulus_duration;
                C.experiment(cond_num).note             = '';
                % Keep track of how long this experiment will be
                total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration + .3;
                % Increment the condition number
                cond_num = cond_num + 1;
            end
        end
    end
    % Do the Bars / Edges a little differently
    bar_edge_fps = 4;
    pat_func_pairs(1,:) = [4:19];
    %pat_func_pairs(2,:) = [14 14 15 15 16 16 17 17 14 14 15 15 16 16 17 17];
    pat_func_pairs(2,:) = [ 6 6 7 7 8 8 9 9 6 6 7 7 8 8 9 9];
    for i = 1:size(pat_func_pairs,2)
        pat_num = pat_func_pairs(1,i);
        func_num = pat_func_pairs(2,i);
        
        C.experiment(cond_num).DisplayType      = 'panels';
        C.experiment(cond_num).PatternID        = pat_num; %#ok<*AGROW>
        C.experiment(cond_num).PatternName      = patterns{pat_num};
        C.experiment(cond_num).Mode             = [4 0];
        C.experiment(cond_num).InitialPosition  = [1 1];
        C.experiment(cond_num).PosFunctionX     = [1 func_num];
        C.experiment(cond_num).PosFuncNameX     = position_functions{func_num};
        tmp=regexp(position_functions{func_num},'\SAMPRATE_','split');
        C.experiment(cond_num).FuncFreqX        = str2double(tmp{2}(1:4));
        % Y position function is not useable
        C.experiment(cond_num).PosFunctionY     = [2 0];
        C.experiment(cond_num).PosFuncNameY     = 'none';
        C.experiment(cond_num).FuncFreqY        = default_frequency;
        C.experiment(cond_num).Gains            = [0 0 0 0];
        tmp=regexp(position_functions{func_num},'\_per_pat_','split');
        stimulus_duration = initial_time + (str2double(tmp{2}(1:3))/bar_edge_fps)*1.2;
        C.experiment(cond_num).Duration         = stimulus_duration;
        C.experiment(cond_num).note             = '';
        % Keep track of how long this experiment will be
        total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration + .3;
        % Increment the condition number
        cond_num = cond_num + 1;
    end      

%===Set up interspersal values==============================================
    % This will not be used as interspersal anymore (just initial_alignment) 
    C.interspersal.DisplayType = 'controller';    
    C.interspersal.PatternID   = numel(patterns);
    C.interspersal.PatternName = patterns{C.interspersal.PatternID};
    C.interspersal.Mode           = [0 0];
    C.interspersal.InitialPosition= [1 1];
    C.interspersal.Gains          = [0 0 0 0];
    C.interspersal.PosFunctionX   = [1 0];
    C.interspersal.PosFunctionY   = [2 0];
    C.interspersal.FuncFreqY      = default_frequency;
    C.interspersal.FuncFreqX 	  = default_frequency;
    C.interspersal.PosFuncLoc     = 'none';            
    C.interspersal.PosFuncNameX   = 'none';
    C.interspersal.PosFuncNameY   = 'none';
    C.interspersal.PanelCfgNum    = cfg_num;
    C.interspersal.PanelCfgName   = panel_cfgs{cfg_num};
    C.interspersal.Duration       = 1;
    C.interspersal.Voltage        = 0; % Very important!

%===Set up initial_alignment values========================================
    C.initial_alignment = C.interspersal;

%===Assign voltage values to the experimental conditions===================
    encoded_vals = linspace(.1,9.9,numel(C.experiment));
    for cond_num = 1:numel(C.experiment)
        C.experiment(cond_num).Voltage        = encoded_vals(cond_num);
        C.experiment(cond_num).PanelCfgNum    = cfg_num; % 
        C.experiment(cond_num).PanelCfgName   = panel_cfgs{cfg_num};
        C.experiment(cond_num).PosFuncLoc     = SD_card;
        C.experiment(cond_num).PatternLoc     = SD_card;
    end
    total_dur = total_ol_dur;
    repetition_duration = total_dur/60;

end
