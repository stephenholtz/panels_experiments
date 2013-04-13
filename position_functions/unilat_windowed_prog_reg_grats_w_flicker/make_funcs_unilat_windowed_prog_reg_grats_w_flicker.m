%%%%% THIS IS NOT USED DUE TO CONTROLLER PROBLEMS, FOR A QUICK FIX THE
%%%%% REGULAR MODE 0 AND GAINS IS FAR MORE REASONABLE THAN USING A SET
%%%%% UPDATE FREQUENCY AND THE RESULTING STRANGE SET OF AVAILABLE SPEEDS...
% Make all of the position functions for the simple looping stimuli
save_directory = '/Users/stephenholtz/panels_experiments/position_functions/unilat_windowed_prog_reg_grats_w_flicker';

pos_func_samp_freq = 145;
spatial_freqs = [4 12]*2;
goal_temp_freqs = [.5  4  8];
dummy_frame_flag = 1;
func_iter = 1;

for spat_freq = spatial_freqs
    for temp_freq = goal_temp_freqs
        for direction = [1 -1]

            [func,actual_temp_freq] = make_simple_looping_position_functions(spat_freq,temp_freq,pos_func_samp_freq,direction,dummy_frame_flag);
            
            if mod(actual_temp_freq,1)
                temp_freq_name = regexprep(num2str(actual_temp_freq),'\.','pt');
            else
                temp_freq_name = num2str(actual_temp_freq);
            end
            
            if direction == -1
                dir = 'ccw';
            elseif direction == 1
                dir = 'cw';
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
    for temp_freq = goal_temp_freqs
        for spacing = 1:2
            [func,actual_temp_freq] = make_simple_looping_position_functions(spat_freq,temp_freq,pos_func_samp_freq,direction,dummy_frame_flag);
            
            func = ~mod(func,2)+dummy_frame_flag;
            
            if mod(actual_temp_freq,1)
                temp_freq_name = regexprep(num2str(actual_temp_freq),'\.','pt');
            else
                temp_freq_name = num2str(actual_temp_freq);
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
