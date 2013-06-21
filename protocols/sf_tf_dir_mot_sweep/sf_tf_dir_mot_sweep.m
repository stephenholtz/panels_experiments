function [C,repetition_duration] = sf_tf_dir_mot_sweep
% C needs fields experiment, interspersal and initial_alignment
%

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
    pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

    % Start a few variables for below
    cfg_num = 1;

    cond_num = 1;
    total_ol_dur = 0;
    default_frequency = 50;
    ol_duration = 2.25;
    cl_duration = 1.65;

    %LEFT_v_grat_RIGHT_v1Hzflk
    %LEFT_v1Hzflk_RIGHT_v_grat
    %LEFT_blank_RIGHT_v1Hzflk
    %LEFT_v1Hzflk_RIGHT_blank
for stim_type = 1:4
    switch stim_type
        case 1
            % Motion on both sides
            pat_nums = [1 10 19 28 37];
        case 2
            % Motion on one side
            pat_nums = [2 3 11 12 20 21 29 30 38 39];
        case 3
            % Motion on one side flicker on other
            pat_nums = [4 5 13 14 22 23 31 32 40 41];
        case 4
            % Flicker on one side
            pat_nums = [6 7 15 16 24 25 33 34 42 43 44 45];
    end

    for pat_num = pat_nums
        num_frames = -1+str2double((regexp(patterns{pat_num},'(?<=NUM_FRAMES_)\d{3}','match')));
        switch num_frames
            case 4
                func_nums = [1:8]; %#ok<*NBRAK>
            case 8
                func_nums = [9:16];
            case 12
                func_nums = [17:24];
            case 16
                func_nums = [25:32];
            case 24
                func_nums = [33:40];
            case 32
                func_nums = [41:48];
            case 48
                func_nums = [49:56];
            otherwise
                error 'num_frames does not match position functions'
        end

        if stim_type == 4
            % the flicker conditions only need positive directions
            func_nums = func_nums(2:2:end); 
        end

        for func_num = func_nums

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
            C.experiment(cond_num).Duration         = ol_duration;
            C.experiment(cond_num).note             = '';

            % Keep track of how long this experiment will be
            total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration + .1;

            % Increment the condition number
            cond_num = cond_num + 1;
        end
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
