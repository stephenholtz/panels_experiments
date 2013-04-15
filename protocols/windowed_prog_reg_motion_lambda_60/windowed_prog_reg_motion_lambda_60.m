function [C,repetition_duration] = windowed_prog_reg_motion_lambda_60
% C needs fields experiment, closed_loop and initial_alignment
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
    
    % Start a few variables for below
    cond_num = 1;
    total_ol_dur = 0;
    default_frequency = 200;
    ol_duration = 1.5;
    cl_duration = 2.75;
    
    % position function that makes sure all sitmuli use mode 4 4
    %blank_func_ind = numel(position_functions);
    %flicker_pos_funcs = 13:24;
    spatial_freq = 8*2;
    temp_freqs = [.5 4 8 16];
    gain_grp = spatial_freq*temp_freqs;
    pat_grp = 1:24;
    
    for pat = pat_grp
        for gain = gain_grp
            for direction = [-1 1]
                C.experiment(cond_num).PatternID        = pat; %#ok<*AGROW>
                C.experiment(cond_num).PatternName      = patterns{pat};
                C.experiment(cond_num).Mode             = [0 0];
                C.experiment(cond_num).InitialPosition  = [1 1];
                C.experiment(cond_num).PosFunctionX     = [1 0];
                C.experiment(cond_num).PosFuncNameX     = 'none';
                C.experiment(cond_num).FuncFreqX        = default_frequency;
                C.experiment(cond_num).PosFunctionY     = [2 0];
                C.experiment(cond_num).PosFuncNameY     = 'none';
                C.experiment(cond_num).FuncFreqY        = default_frequency;
                C.experiment(cond_num).Gains            = [direction*gain 0 direction*gain 0];
                C.experiment(cond_num).Duration         = ol_duration;
                C.experiment(cond_num).note             = '';
                % Keep track of how long this experiment will be
                total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration + .02;

                % Increment the condition number
                cond_num = cond_num + 1;
            end
        end
    end
%===Set up closed_loop values==============================================
    C.closed_loop.PatternID      = numel(patterns);
    C.closed_loop.PatternName    = patterns(numel(patterns));
    C.closed_loop.Mode           = [1 0];
    C.closed_loop.InitialPosition= [49 1];
    C.closed_loop.Gains          = [-12 0 0 0];
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
    end
    
    total_dur = total_ol_dur + numel(C.experiment)*C.closed_loop.Duration;
    repetition_duration = total_dur/60;

end