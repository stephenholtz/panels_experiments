function [C,repetition_duration] = misc_prog_reg_stims
% C needs fields: experiment, closed_loop and initial_alignment

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
    ol_duration = 2.0;
    cl_duration = 2.0;

    % Edges:
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

    % randomized blocks: for some reason these patterns do not load onto
    % the panels correctly...
    for pat_num = 25:30 
        clear func_nums
        if (pat_num < 28) 
            % the '96' patterns are lam 30
            func_nums = 31:36; 
        else
            % the '192' patterns are lam 60 
            func_nums = 37:42;
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

    % triangle wave flicker:
    for pat_num = [31 32]
        clear func_nums
        func_nums = 61:2:68;
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
            C.experiment(cond_num).Duration         = ol_duration;
            C.experiment(cond_num).note             = '';
            % Keep track of how long this experiment will be
            total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration + .1;
            % Increment the condition number
            cond_num = cond_num + 1;           
        end
    end

    % for the reverse phi stuff (lower speeds)
    for pat_num = 58:60
        clear func_nums
        tmp=regexp(patterns{pat_num},'\NUM_FRAMES_','split');
        num_frames = str2double(tmp{2}(1:3))-1;
        if (pat_num >= 56 || pat_num <= 58)
            if num_frames == 16
                % RP 8  pixel stimuli no flicker OK
                func_nums = 49:54;
            else
                error('Func Num Problem!')
            end
        else
            error('Func Num Problem!')
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
            C.experiment(cond_num).Duration         = ol_duration;
            C.experiment(cond_num).note             = '';
            % Keep track of how long this experiment will be
            total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration + .1;
            % Increment the condition number
            cond_num = cond_num + 1;           
        end
    end

    % all the rest of the prog / reg stims:
    for pat_num = [33:37 40:43 47:51 54:57 61:63 75:77 89:91 103:105]
        clear func_nums
        tmp=regexp(patterns{pat_num},'\NUM_FRAMES_','split');
        num_frames = str2double(tmp{2}(1:3))-1;
        if (pat_num >= 33 && pat_num <= 43) || (pat_num >= 61 && pat_num <= 63) || (pat_num >= 89 && pat_num <= 91)            
            if num_frames == 8
                % 4 pixel stimuli no flicker
                func_nums = 13:18;
            elseif num_frames == 16
                % 4 pixel stimuli with flicker
                func_nums = 19:24;
            else
                error('Func Num Problem!')
            end
            if pat_num == 36 || pat_num == 37 || pat_num == 38 || pat_num == 39 
                % flicker by itself only goes in one 'direction' here
                func_nums = func_nums(2:2:end);
            end
        elseif (pat_num >= 47 && pat_num <= 57) || (pat_num >= 75 && pat_num <= 77) || (pat_num >= 103 && pat_num <= 105)
            if num_frames == 16
                % 8 pixel stimuli no flicker
                func_nums = 19:24;
            elseif num_frames == 32
                % 8 pixel stimuli with flicker
                func_nums = 25:30;
            else
                error('Func Num Problem!')
            end
            if pat_num == 50 || pat_num == 51 || pat_num == 52 || pat_num == 53
                % flicker by itself only goes in one 'direction' here
                func_nums = func_nums(2:2:end);
            end
        else
            error('Func Num Problem!')
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
            C.experiment(cond_num).Duration         = ol_duration;
            C.experiment(cond_num).note             = '';
            % Keep track of how long this experiment will be
            total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration + .1;
            % Increment the condition number
            cond_num = cond_num + 1;           
        end
    end
    
%===Set up closed_loop values==============================================
    C.closed_loop.DisplayType = 'controller';    
    C.closed_loop.PatternID   = numel(patterns);
    C.closed_loop.PatternName = patterns(numel(patterns));
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
    C.closed_loop.PanelCfgNum    = cfg_num;
    C.closed_loop.PanelCfgName   = panel_cfgs{cfg_num};
    C.closed_loop.Duration       = cl_duration;
    C.closed_loop.Voltage        = 0; % Very important!
    
%===Set up initial_alignment values========================================
    C.initial_alignment = C.closed_loop;
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
    
    total_dur = total_ol_dur + numel(C.experiment)*C.closed_loop.Duration;
    repetition_duration = total_dur/60;

end
