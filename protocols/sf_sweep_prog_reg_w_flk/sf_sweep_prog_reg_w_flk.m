function [C,repetition_duration] = sf_sweep_prog_reg_w_flk
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
    pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

    % Start a few variables for below
    cfg_num = 1;
    
    cond_num = 1;
    total_ol_dur = 0;
    default_frequency = 50;
    ol_duration = 1.5;
    cl_duration = 2.25;
    
    % To make symmetrical partner conditions easier to find
    % cond_str_l{1} = left side string for cw condition
    % cond_str_l{1} = right side string for cw condition
    % cond_str_r{2} = left side string for ccw condition
    % cond_str_r{2} = right side string for ccw condition
    % cond_dir{1} = the x position direction for the cw condition
    % cond_dir{2} = the x position direction for the ccw condition
    %
    % ....
    
    for stim_type = 1:4
        clear cond_str_* cond_dirs
        
        % Basically declare all elements of a few for loops in the switch
        % and then loop through to make the stimuli.
        switch stim_type
            case 1
                % Flicker only
                tfs = [2 6 18];
                sfs = [4 16]*2;
                
                cond_str_l{1} = 'blank';
                cond_str_r{1} = 'v_flk';
                cond_dirs{1} = 'pos';
                
                cond_str_l{2} = 'v_flk';
                cond_str_r{2} = 'blank';
                cond_dirs{2} = 'pos';
                
            case 2
                % Unilateral Motion only
                tfs = [2 6 18];
                sfs = [2 4 6 8 12 16]*2;
                
                cond_str_l{1} = 'blank';
                cond_str_r{1} = 'v_grt';
                cond_dirs{1} = 'pos';
                
                cond_str_l{2} = 'v_grt';
                cond_str_r{2} = 'blank';
                cond_dirs{2} = 'neg';
                
                cond_str_l{3} = 'v_grt';
                cond_str_r{3} = 'blank';
                cond_dirs{3} = 'pos'; 
                
                cond_str_l{4} = 'blank';
                cond_str_r{4} = 'v_grt';
                cond_dirs{4} = 'neg';               
                
            case 3
                % Motion and flicker
                tfs = [2 6 18];
                sfs = [2 4 6 8 12 16]*2;
                
                cond_str_l{1} = 'v_flk';
                cond_str_r{1} = 'v_grt';
                cond_dirs{1} = 'pos';
                
                cond_str_l{2} = 'v_grt';
                cond_str_r{2} = 'v_flk';
                cond_dirs{2} = 'neg';
                
                cond_str_l{3} = 'v_grt';
                cond_str_r{3} = 'v_flk';
                cond_dirs{3} = 'pos';
                
                cond_str_l{4} = 'v_flk';
                cond_str_r{4} = 'v_grt';
                cond_dirs{4} = 'neg';
                
            case 4
                % Bilateral motion
                tfs = [2 6 18];
                sfs = [2 4 6 8 12 16]*2;
                
                cond_str_l{1} = 'v_grt';
                cond_str_r{1} = 'v_grt';
                cond_dirs{1} = 'pos';
                
                cond_str_l{2} = 'v_grt';
                cond_str_r{2} = 'v_grt';
                cond_dirs{2} = 'neg';
                
        end
        
        for sf = sfs
            for tf = tfs
                for cond = 1:numel(cond_dirs)
                    
                    % Match the pattern
                    num_px = sf/2;
                    pat_num = find(cellfun(@(x) strcmp(x([22:26 28:37 39:49]),['PX_' pad_num2str_w_zeros(num_px,2) 'LEFT_' cond_str_l{cond} 'RIGHT_' cond_str_r{cond}]), patterns));
                    if numel(pat_num) ~=1
                        error('not found')
                    end
                    
                    C.experiment(cond_num).PatternID        = pat_num; %#ok<*AGROW>
                    C.experiment(cond_num).PatternName      = patterns{pat_num};
                    C.experiment(cond_num).Mode             = [4 0];
                    C.experiment(cond_num).InitialPosition  = [1 1];
                    
                    % Match the position function
                    func_num = find(cellfun(@(x) strcmp(x([23:28 30:35 37:43]),['SF_' pad_num2str_w_zeros(sf,3) 'TF_' pad_num2str_w_zeros(tf,3) 'DIR_' cond_dirs{cond}]), position_functions));
                    if numel(func_num) ~=1
                        error('not found')
                    end
                    
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
    end

%===Set up closed_loop values==============================================
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