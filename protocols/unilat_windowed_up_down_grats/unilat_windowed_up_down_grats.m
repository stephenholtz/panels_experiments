function [C,repetition_duration] = unilat_windowed_up_down_grats
% C needs fields experiment, interspersal and initial_alignment
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
    default_frequency = 200;
    ol_duration = 2;
    cl_duration = 3;
    
    for spat_freq_set = 1:3
   
        if spat_freq_set == 1
            pat_grp = 1:4;
            func_grp = 1:6;
        elseif spat_freq_set == 2
            pat_grp = (1:4)+4 ;
            func_grp = (1:6)+6;
        elseif spat_freq_set == 3
            pat_grp = (1:4)+4+4;
            func_grp = (1:6)+6+6;
        end
    
    for func = func_grp
    
    % Get the symmetric conditions right
        for pat = pat_grp

            C.experiment(cond_num).PatternID        = pat; %#ok<*AGROW>
            C.experiment(cond_num).PatternName      = patterns{pat};

            C.experiment(cond_num).PosFunctionX     = [1 func];
            C.experiment(cond_num).PosFuncNameX     = position_functions{func};
            tmp=regexpi(position_functions{func},'\SAMP_RATE_','split');
            C.experiment(cond_num).FuncFreqX        = str2double(tmp{2}(1:3));
            
            C.experiment(cond_num).PosFunctionY 	= [2 0];
            C.experiment(cond_num).PosFuncNameY     = 'none';
            C.experiment(cond_num).FuncFreqY 		= default_frequency;

            C.experiment(cond_num).Gains            = [0 0 0 0];
            C.experiment(cond_num).Mode             = [4 0];
            C.experiment(cond_num).InitialPosition  = [1 1]; % [1 1] are both dummy frames.
            C.experiment(cond_num).Duration         = ol_duration;
            C.experiment(cond_num).note             = '';

            % Keep track of how long this experiment will be
            total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration + .02;

            % Increment the condition number
            cond_num = cond_num + 1;
        end
    end
    end
%===Set up interspersal values==============================================
    C.interspersal.PatternID      = numel(patterns);
    C.interspersal.PatternName    = patterns(numel(patterns));
    C.interspersal.Mode           = [1 0];
    C.interspersal.InitialPosition= [49 1];
    C.interspersal.Gains          = [-12 0 0 0];
    C.interspersal.PosFunctionX   = [1 0];
    C.interspersal.PosFunctionY   = [2 0];
    C.interspersal.FuncFreqY      = default_frequency;
    C.interspersal.FuncFreqX 	 = default_frequency;
    C.interspersal.PosFuncLoc     = 'none';            
    C.interspersal.PosFuncNameX   = 'none';
    C.interspersal.PosFuncNameY   = 'none';
    C.interspersal.PanelCfgNum    = 1;
    C.interspersal.PanelCfgName   = panel_cfgs{1};
    C.interspersal.Duration       = cl_duration;
    C.interspersal.Voltage        = 0; % Very important!
    
%===Set up initial_alignment values========================================
    C.initial_alignment = C.interspersal;

%===Assign voltage values to the experimental conditions===================

    encoded_vals = linspace(.1,9.9,numel(C.experiment));
    for cond_num = 1:numel(C.experiment)
        C.experiment(cond_num).Voltage        = encoded_vals(cond_num);
        C.experiment(cond_num).PanelCfgNum    = 1;
        C.experiment(cond_num).PanelCfgName   = panel_cfgs{1};
        C.experiment(cond_num).PosFuncLoc     = SD_card;
        C.experiment(cond_num).PatternLoc     = SD_card;
    end
    
    total_dur = total_ol_dur + numel(C.experiment)*C.interspersal.Duration;
    repetition_duration = total_dur/60;

end
