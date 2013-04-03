function [C,repetition_duration] = overlaid_vel_nulling_and_bilateral_vel_nulling
% C needs fields experiment, closed_loop and initial_alignment
% 
% Will do the telethon version of vel nulling (using my methods) and a
% bilateral version of vel nulling, as per MR's request.

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
    
    overlaid_pats = 1:3;
    bilat_pats = 7:9;
    
    for pat_type = 1:2
        
        if pat_type == 1
            pats = overlaid_pats;
            null_speed_func = 2; % the constant side, ccw
            test_speed_funcs = [3 5 7 9 11]; % the test side, cw
            test_shift = +1;
            null_shift = -1;
        else
            pats = bilat_pats;
            null_speed_func = 1; % the constant side, cw
            test_speed_funcs = [4 6 8 10 12]; % the test side, ccw
            test_shift = -1;
            null_shift = +1;
        end
        
        % Pos funcs:
        % 4cw 4ccw .33cw .33ccw 1.33cw 1.33ccw 4.33cw 4.33ccw 10.66cw 10.66ccw 16cw 16ccw
        
        for test_speed_func = test_speed_funcs
            
            % Get the symmetric conditions right
            for pat = pats
                
                for sym_pair = 1:2
                    
                    if sym_pair == 1
                        
                        C.experiment(cond_num).PatternID        = pat; %#ok<*AGROW>
                        C.experiment(cond_num).PatternName      = patterns{pat};
                        
                        C.experiment(cond_num).PosFunctionX     = [1 null_speed_func];
                        C.experiment(cond_num).PosFuncNameX     = position_functions{null_speed_func};
                        tmp=regexpi(position_functions{null_speed_func},'\SAMP_RATE_','split');
                        C.experiment(cond_num).FuncFreqX        = str2double(tmp{2}(1:3));
                        
                        C.experiment(cond_num).PosFunctionY 	= [2 test_speed_func];
                        C.experiment(cond_num).PosFuncNameY     = position_functions{test_speed_func};
                        tmp=regexpi(position_functions{test_speed_func},'\SAMP_RATE_','split');
                        C.experiment(cond_num).FuncFreqY 		= str2double(tmp{2}(1:3));
                        
                    elseif sym_pair == 2
                        
                        C.experiment(cond_num).PatternID        = pat+3; % each pattern ind + 3 is the reverse...
                        C.experiment(cond_num).PatternName      = patterns{pat+3};
                        
                        C.experiment(cond_num).PosFunctionX     = [1 test_speed_func+test_shift]; % swapped x and y
                        C.experiment(cond_num).PosFuncNameX     = position_functions{test_speed_func+test_shift};
                        tmp=regexpi(position_functions{test_speed_func+test_shift},'\SAMP_RATE_','split');
                        C.experiment(cond_num).FuncFreqX        = str2double(tmp{2}(1:3));
                        
                        C.experiment(cond_num).PosFunctionY 	= [2 null_speed_func+null_shift]; % swapped x and y
                        C.experiment(cond_num).PosFuncNameY     = position_functions{null_speed_func+null_shift};
                        tmp=regexpi(position_functions{null_speed_func+null_shift},'\SAMP_RATE_','split');
                        C.experiment(cond_num).FuncFreqY 		= str2double(tmp{2}(1:3));
                        
                    end

                    C.experiment(cond_num).Gains            = [0 0 0 0];
                    C.experiment(cond_num).Mode             = [4 4];
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