% Make all of the position functions for the simple looping stimuli
save_directory = '/Users/stephenholtz/panels_experiments/position_functions/overlaid_vel_nulling_and_bilateral_vel_nulling';

% Speeds to use, the null_speed = 48;
speeds = [48 4 16 64 128 192];
spatial_freq = 12;
temp_freq_list = speeds/spatial_freq;
dummy_frame_flag = 1;
func_iter = 1;

for temp_freq = temp_freq_list            
    for direction = [-1 1]

        [func,pos_func_samp_freq] = make_determine_best_simple_looping_position_functions(spatial_freq,temp_freq,direction,dummy_frame_flag);
        
        if mod(temp_freq,1)
            temp_freq_name = regexprep(num2str(temp_freq),'\.','pt');
        else
            temp_freq_name = num2str(temp_freq);
        end

        if direction == -1
            dir = 'cw';
        elseif direction == 1
            dir = 'ccw';
        end
        
        if numel(num2str(pos_func_samp_freq)) < 2
            pos_func_samp_freq_name = ['00' num2str(pos_func_samp_freq)];
        elseif numel(num2str(pos_func_samp_freq)) < 3
            pos_func_samp_freq_name = ['0' num2str(pos_func_samp_freq)];        
        else
            pos_func_samp_freq_name = num2str(pos_func_samp_freq);        
        end

        func_name = ['spat_freq_' num2str(spatial_freq) 'Hz_temp_freq_' temp_freq_name 'Hz_at_SAMP_RATE_' pos_func_samp_freq_name '_dir_' dir];

        func_iter = save_panels_position_function(save_directory,func_name,func,func_iter);

        clear func_name

    end
end
