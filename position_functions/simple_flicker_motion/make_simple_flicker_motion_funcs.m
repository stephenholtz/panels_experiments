% Make all of the position functions for the simple looping stimuli
% these have to make sense for dummy frame patterns everything will
% be in the x channel.
%
save_directory = mfilename('fullpath');
save_directory = fileparts(save_directory);

% Add in required functions (strangely)
addpath(fullfile(save_directory,'..','..'));
pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

% Amount of time before and after the stimulus
time_before_stim = 2;
time_during_stim = 2;
time_after_stim = 4;
use_high_samp_rate_flag = 0;
dummy_frame_flag = 1;
func_iter = 1;
% The position functions for prog / reg / flicker
for pat_steps_per_stim = [2,24] % DONE
    for temp_freq = [.5,2,6]
        for direction = [-1 1]
            if direction == -1
                dir = 'neg';
            elseif direction == 1
                dir = 'pos';
            end
            % the 96 case is special, needs to loop through 96 positions,
            % but at the frame rate as if it were periodic after only 8, 16
            % frames.
            steps_per_stim = pat_steps_per_stim;
            fps = temp_freq*pat_steps_per_stim;

            [base_func,pos_func_samp_freq] = make_determine_best_samp_rate_simple_looping_position_functions(steps_per_stim,fps,direction,dummy_frame_flag,use_high_samp_rate_flag);

            pos_func_samp_freq_name = pad_num2str_w_zeros(pos_func_samp_freq,4);
 
            step_name = pad_num2str_w_zeros(steps_per_stim,3);
            step_name = regexprep(num2str(step_name),'\.','p');

            temp_freq_name = pad_num2str_w_zeros(temp_freq,3);
            temp_freq_name = regexprep(num2str(temp_freq_name),'\.','p');

            samps_bef = time_before_stim*pos_func_samp_freq;
            samps_dur = time_during_stim*pos_func_samp_freq;
            samps_aft = time_after_stim*pos_func_samp_freq;

            % time bef and aft are the dummy frame, time dur is a loop through the func
            func_bef = 0*ones(1,samps_bef);
            for i = (1:samps_dur)-1
                func_dur(i+1) = base_func(1+mod(i,numel(base_func)));
            end
            func_aft = 0*ones(1,samps_aft);
            func = [func_bef func_dur func_aft]; 

            func_name = ['steps_per_pat_' step_name '_SPD_' temp_freq_name '_DIR_' dir '_SAMPRATE_' pos_func_samp_freq_name '_samps_bef_' pad_num2str_w_zeros(samps_bef,4) '_dur_' pad_num2str_w_zeros(samps_dur,4) '_aft_' pad_num2str_w_zeros(samps_aft,4)];

            func_iter = save_panels_position_function(save_directory,func_name,func,func_iter);
            clear func func_name
        end
    end
end
