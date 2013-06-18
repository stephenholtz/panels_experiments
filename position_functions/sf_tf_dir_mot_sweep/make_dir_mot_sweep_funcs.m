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
frames_to_append = 1000;
dummy_frame_flag = 1;
func_iter = 1;

% The position functions for prog / reg / full-field motion
for pat_steps_per_stim = [4 8 12 16 24 32 48] % DONE
    for temp_freq = [.5 2 6 14]
        for direction = [-1 1]
            if direction == -1
                dir = 'neg';
            elseif direction == 1
                dir = 'pos';
            end
            steps_per_stim = pat_steps_per_stim;
            fps = temp_freq*pat_steps_per_stim;

            [func,pos_func_samp_freq] = make_determine_best_samp_rate_simple_looping_position_functions(steps_per_stim,fps,direction,dummy_frame_flag,0);

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