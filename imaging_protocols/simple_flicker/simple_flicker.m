function [C,repetition_duration] = simple_flicker
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
    stimulus_duration = 10;
    interspersal_duration = 10;

    for pat_num = 1:24 % all of the edge pattern numbers
        clear func_nums
        if sum(pat_num == [5 6 11 12 17 18 23 24])
            % The full sweeps are longer functions
            % the + or - in x is needed for cw ccw
            func_nums = 8:2:12; 
            steps_per_pat = 83;
        else
            % The prog / reg sweeps are shorter functions
            % the pattern has prog or reg, so all are + in x
            func_nums = 2:2:6;
            steps_per_pat = 41;
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
            tmp=regexp(position_functions{func_num},'\FPS_','split');
            fps= str2double(tmp{2}(1:3));
            % add in an extra time segment to get responses after the stimulus is 'over'
            C.experiment(cond_num).Duration         = steps_per_pat/fps + .2;
            C.experiment(cond_num).note             = '';
            % Keep track of how long this experiment will be
            total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration + .1;
            % Increment the condition number
            cond_num = cond_num + 1;           
        end
    end

%===Set up interspersal values==============================================
    C.interspersal.DisplayType = 'controller';    
    C.interspersal.PatternID   = numel(patterns);
    C.interspersal.PatternName = patterns(numel(patterns));
    C.interspersal.Mode           = [1 0];
    C.interspersal.InitialPosition= [49 1];
    C.interspersal.Gains          = [-14 0 0 0];
    C.interspersal.PosFunctionX   = [1 0];
    C.interspersal.PosFunctionY   = [2 0];
    C.interspersal.FuncFreqY      = default_frequency;
    C.interspersal.FuncFreqX 	 = default_frequency;
    C.interspersal.PosFuncLoc     = 'none';            
    C.interspersal.PosFuncNameX   = 'none';
    C.interspersal.PosFuncNameY   = 'none';
    C.interspersal.PanelCfgNum    = cfg_num;
    C.interspersal.PanelCfgName   = panel_cfgs{cfg_num};
    C.interspersal.Duration       = cl_duration;
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

