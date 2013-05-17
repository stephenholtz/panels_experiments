% Make all of the position functions for the simple looping stimuli
% these have to make sense for dummy frame patterns everything will
% be in the x channel.
%

save_directory = mfilename('fullpath');
save_directory = fileparts(save_directory);

% Add in required functions (strangely)
addpath(fullfile(save_directory,'..','..'));

pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

% All 'steps_per_stim' refer to the pattern without a dummy frame

% prog/reg 4 pix            = 8
% prog/reg 8 pix            = 16
% prog/reg 4 pix 1hz flk    = 16
% prog/reg 8 pix 1hz flk    = 32
% prog/reg 4 pix 2hz flk    = 16
% prog/reg 8 pix 2hz flk    = 32

% prog/reg rp 4 pix         = 8
% prog/reg rp 8 pix         = 16
% prog/reg rp 4 pix 1hz flk = 16
% prog/reg rp 8 pix 1hz flk = 32
% prog/reg rp 4 pix 2hz flk = 16
% prog/reg rp 8 pix 2hz flk = 32

% all block scrambled       = 96

% edge sweep                = 41
% full edge sweep           = 83

dummy_frame_flag = 1;
func_iter = 1;

% The position functions for the edges
for steps_per_stim = [41,83] % DONE
    for fps = [150,225,300]
        for direction = [-1 1]
            if direction == -1
                dir = 'neg';
            elseif direction == 1
                dir = 'pos';
            end
            [func,pos_func_samp_freq] = make_determine_best_samp_rate_simple_looping_position_functions(steps_per_stim,fps,direction,dummy_frame_flag);

            pos_func_samp_freq_name = pad_num2str_w_zeros(pos_func_samp_freq,4);
            
            step_name = pad_num2str_w_zeros(steps_per_stim,3);
            step_name = regexprep(num2str(step_name),'\.','p');
            
            temp_freq_name = pad_num2str_w_zeros(fps,3);
            temp_freq_name = regexprep(num2str(temp_freq_name),'\.','p');

            func_name = ['steps_per_pat_' step_name '_FPS_' temp_freq_name '_DIR_' dir '_SAMPRATE_' pos_func_samp_freq_name '_w_dummy_frame'];

            func_iter = save_panels_position_function(save_directory,func_name,func,func_iter);
            clear func func_name
        end
    end
end

% The position functions for prog / reg / full-field motion
for pat_steps_per_stim = [8,16,32,96,96*2] % DONE
    for temp_freq = [3,6,12]
        for direction = [-1 1]
            if direction == -1
                dir = 'neg';
            elseif direction == 1
                dir = 'pos';
            end
            % the 96 case is special, needs to loop through 96 positions,
            % but at the frame rate as if it were periodic after only 8, 16
            % frames.
            if pat_steps_per_stim == 96
                fps = temp_freq*8;
                steps_per_stim = 96;
            elseif pat_steps_per_stim == 96*2
                fps = temp_freq*16;
                steps_per_stim = 96;
            else
                steps_per_stim = pat_steps_per_stim;
                fps = temp_freq*pat_steps_per_stim;
            end
            [func,pos_func_samp_freq] = make_determine_best_samp_rate_simple_looping_position_functions(steps_per_stim,fps,direction,dummy_frame_flag);

            pos_func_samp_freq_name = pad_num2str_w_zeros(pos_func_samp_freq,4);
            
            step_name = pad_num2str_w_zeros(steps_per_stim,3);
            step_name = regexprep(num2str(step_name),'\.','p');
            
            temp_freq_name = pad_num2str_w_zeros(temp_freq,3);
            temp_freq_name = regexprep(num2str(temp_freq_name),'\.','p');

            func_name = ['steps_per_pat_' step_name '_TF_' temp_freq_name '_DIR_' dir '_SAMPRATE_' pos_func_samp_freq_name '_w_dummy_frame'];

            func_iter = save_panels_position_function(save_directory,func_name,func,func_iter);
            clear func func_name
        end
    end
end

% The position functions for the reverse phi motion (different speeds than rest)
for steps_per_stim = [8,16,32] % DONE
    for temp_freq = [.75,2,5]
        for direction = [-1 1]
            if direction == -1
                dir = 'neg';
            elseif direction == 1
                dir = 'pos';
            end
            
            fps = temp_freq*steps_per_stim;
            [func,pos_func_samp_freq] = make_determine_best_samp_rate_simple_looping_position_functions(steps_per_stim,fps,direction,dummy_frame_flag);

            pos_func_samp_freq_name = pad_num2str_w_zeros(pos_func_samp_freq,4);
            
            step_name = pad_num2str_w_zeros(steps_per_stim,3);
            step_name = regexprep(num2str(step_name),'\.','p');
            
            temp_freq_name = pad_num2str_w_zeros(temp_freq,3);
            temp_freq_name = regexprep(num2str(temp_freq_name),'\.','p');

            func_name = ['steps_per_pat_' step_name '_TF_' temp_freq_name '_DIR_' dir '_SAMPRATE_' pos_func_samp_freq_name '_w_dummy_frame'];

            func_iter = save_panels_position_function(save_directory,func_name,func,func_iter);
            clear func func_name
        end
    end
end

% The position functions for the triangle flicker
steps_per_stim = 23; % DONE
for temp_freq = [.75,2,6,12]
    for direction = [-1 1]
        if direction == -1
            dir = 'neg';
        elseif direction == 1
            dir = 'pos';
        end
        
        fps = temp_freq*steps_per_stim;
        [func,pos_func_samp_freq] = make_determine_best_samp_rate_simple_tri_wave_pos_funcs(steps_per_stim,fps,direction,dummy_frame_flag);

        pos_func_samp_freq_name = pad_num2str_w_zeros(pos_func_samp_freq,4);
        
        step_name = pad_num2str_w_zeros(steps_per_stim,3);
        step_name = regexprep(num2str(step_name),'\.','p');
        
        temp_freq_name = pad_num2str_w_zeros(temp_freq,3);
        temp_freq_name = regexprep(num2str(temp_freq_name),'\.','p');

        func_name = ['steps_per_pat_' step_name '_TF_' temp_freq_name '_DIR_' dir '_SAMPRATE_' pos_func_samp_freq_name '_w_dummy_frame'];

        func_iter = save_panels_position_function(save_directory,func_name,func,func_iter);
        clear func func_name
    end
end
