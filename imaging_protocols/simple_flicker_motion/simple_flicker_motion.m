function [C,repetition_duration] = simple_flicker_motion
% imaging protocol
% C needs to have fields:  initial_alignment, experiment, interpsersal

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

    % Stimulus setup: 
    % The interspersal is a period when I am not 
    % imaging anything, stimulus dir is when I am imaging and includes
    % periods of time before and after the 'actual' stimulus is 
    % presented.
    stimulus_duration = 6.25;
    interspersal_duration = 6.25;

    for pat_num = 1:3 % all flicker patterns (right side of fly)
        clear func_nums
        if sum(pat_num == [1 2])
            % On and off flicker only need one direction
            func_nums = [2 4 6]; 
            steps_per_pat = 2;
        else
            % The prog / reg sweeps are neg / pos pos funcs
            func_nums = [7:2:12 8:2:12];
            steps_per_pat = 25;
        end
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

%===Set up interspersal values==============================================
    C.interspersal.DisplayType = 'controller';    
    C.interspersal.PatternID   = 4;
    C.interspersal.PatternName = patterns(4);
    C.interspersal.Mode           = [0 0];
    C.interspersal.InitialPosition= [1 1];
    C.interspersal.Gains          = [0 0 0 0];
    C.interspersal.PosFunctionX   = [1 0];
    C.interspersal.PosFunctionY   = [2 0];
    C.interspersal.FuncFreqY      = default_frequency;
    C.interspersal.FuncFreqX 	 = default_frequency;
    C.interspersal.PosFuncLoc     = 'none';            
    C.interspersal.PosFuncNameX   = 'none';
    C.interspersal.PosFuncNameY   = 'none';
    C.interspersal.PanelCfgNum    = cfg_num;
    C.interspersal.PanelCfgName   = panel_cfgs{cfg_num};
    C.interspersal.Duration       = interspersal_duration;
    C.interspersal.Voltage        = 0; % Very important!

%===Set up initial_alignment values========================================
    C.initial_alignment = C.interspersal;
    C.initial_alignment.PatternID   = numel(patterns);
    C.initial_alignment.PatternName = patterns(numel(patterns));

%===Assign voltage values to the experimental conditions===================
    encoded_vals = linspace(.1,9.9,numel(C.experiment));
    for cond_num = 1:numel(C.experiment)
        C.experiment(cond_num).Voltage        = encoded_vals(cond_num);
        C.experiment(cond_num).PanelCfgNum    = cfg_num; % 
        C.experiment(cond_num).PanelCfgName   = panel_cfgs{cfg_num};
        C.experiment(cond_num).PosFuncLoc     = SD_card;
        C.experiment(cond_num).PatternLoc     = SD_card;
    end
    total_dur = total_ol_dur + numel(C.experiment)*C.interspersal.Duration;
    repetition_duration = total_dur/60;

end
