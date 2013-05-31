% Make all of the position functions for the simple looping stimuli
% these have to make sense for dummy frame patterns everything will
% be in the x channel.

save_directory = mfilename('fullpath');
save_directory = fileparts(save_directory);

% Add in required functions (strangely)
addpath(fullfile(save_directory,'..','..'));

pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);
dummy_frame_flag = 1;
func_iter = 1;

% Regular reverse phi position functions (zero phase delay)
for steps_per_stim = [8,16]
    for fps = steps_per_stim*[1,4,8]
        for direction = [-1 1]
            if direction == -1
                dir = 'neg';
            elseif direction == 1
                dir = 'pos';
            end
            [func,pos_func_samp_freq] = make_determine_best_samp_rate_simple_looping_position_functions(steps_per_stim,fps,direction,dummy_frame_flag);
    end
end

% Phase delay position functions (nonzero phase delay)
pos_func_samp_freq = 1000;
for steps_per_stim = [16,32]
    for fps = [75,150,300]
        for direction = [-1 1]
            if direction == -1
                dir = 'neg';
            elseif direction == 1
                dir = 'pos';
            end

            func = [func repmat(func(end),1,frames_to_append)];

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
