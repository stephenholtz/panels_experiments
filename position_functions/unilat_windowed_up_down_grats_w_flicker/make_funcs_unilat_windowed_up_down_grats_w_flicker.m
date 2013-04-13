%%%%% REGULAR MODE 0 AND GAINS IS FAR MORE REASONABLE THAN USING A SET
%%%%% UPDATE FREQUENCY AND THE RESULTING STRANGE SET OF AVAILABLE SPEEDS...
% Make all of the position functions for the simple looping stimuli
save_directory = '/Users/stephenholtz/panels_experiments/position_functions/unilat_windowed_up_down_grats_w_flicker';

% Speeds to use, the null_speed = 48;
spatial_freqs = [2 8]*2;
temp_freqs = [.5  4  8];
dummy_frame_flag = 1;
func_iter = 1;

for spat_freq = spatial_freqs
    for temp_freq = temp_freqs
        for direction = [-1 1]

            [func,pos_func_samp_freq] = make_determine_best_samp_rate_simple_looping_position_functions(spat_freq,temp_freq,direction,dummy_frame_flag);
            
            if mod(temp_freq,1)
                temp_freq_name = regexprep(num2str(temp_freq),'\.','pt');
            else
                temp_freq_name = num2str(temp_freq);
            end

            if direction == -1
                dir = 'up';
            elseif direction == 1
                dir = 'down';
            end

            if numel(num2str(pos_func_samp_freq)) < 2
                pos_func_samp_freq_name = ['00' num2str(pos_func_samp_freq)];
            elseif numel(num2str(pos_func_samp_freq)) < 3
                pos_func_samp_freq_name = ['0' num2str(pos_func_samp_freq)];        
            else
                pos_func_samp_freq_name = num2str(pos_func_samp_freq);        
            end

            func_name = ['spat_freq_' num2str(spat_freq*3.75) '_temp_freq_' temp_freq_name 'Hz_at_SAMP_RATE_' pos_func_samp_freq_name '_dir_' dir];

            func_iter = save_panels_position_function(save_directory,func_name,func,func_iter);

            clear func_name

        end
    end
end

% Make the position functions for the flicker...
for spat_freq = spatial_freqs
    for temp_freq = temp_freqs
        for spacing = 1:2
            [func,pos_func_samp_freq] = make_determine_best_samp_rate_simple_looping_position_functions(spat_freq,temp_freq,direction,dummy_frame_flag);
            
            % Need to correct for spat freq.....
            func = ~mod(func,2)+dummy_frame_flag;

            if mod(temp_freq,1)
                temp_freq_name = regexprep(num2str(temp_freq),'\.','pt');
            else
                temp_freq_name = num2str(temp_freq);
            end

            if numel(num2str(pos_func_samp_freq)) < 2
                pos_func_samp_freq_name = ['00' num2str(pos_func_samp_freq)];
            elseif numel(num2str(pos_func_samp_freq)) < 3
                pos_func_samp_freq_name = ['0' num2str(pos_func_samp_freq)];        
            else
                pos_func_samp_freq_name = num2str(pos_func_samp_freq);        
            end

            func_name = ['flicker_to_match_spat_freq_' num2str(spat_freq*3.75) '_temp_freq_' temp_freq_name 'Hz_at_SAMP_RATE_' pos_func_samp_freq_name];

            func_iter = save_panels_position_function(save_directory,func_name,func,func_iter);
        end
    end
end

% This does not work...
% func_name = 'blank_for_dummy_frame_at_SAMP_RATE_001';
% func = 1;
% func_iter = 999;
% func_iter = save_panels_position_function(save_directory,func_name,func,func_iter);
