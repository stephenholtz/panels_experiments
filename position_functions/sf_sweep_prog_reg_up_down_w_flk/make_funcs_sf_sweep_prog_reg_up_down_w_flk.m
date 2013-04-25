% Make all of the position functions for the simple looping stimuli
%
% position_function_###_SF_###_TF_###_DIR_(pos/neg)_SAMPRATE_####_w_dummy_frame.mat

save_directory = mfilename('fullpath');
save_directory = fileparts(save_directory);

% Add in required functions
addpath(fullfile(save_directory,'..','..'));

% Prog/Reg
% sfs = 2 4 6 8 12 16 *2
% Up/Down
% sfs = 2 4 6 10 12 *2
% Flicker
% sfs = 1 *2
spatial_freqs = [2 4 6 8 12 16]*2;

% Temp Freqs for both are the same
temp_freqs = [2 6 18];
dummy_frame_flag = 1;
func_iter = 1;

pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

for spat_freq = spatial_freqs
    for temp_freq = temp_freqs
        for direction = [1 -1]

            [func,pos_func_samp_freq] = make_determine_best_samp_rate_simple_looping_position_functions(spat_freq,temp_freq,direction,dummy_frame_flag);
            
            if direction == -1
                dir = 'neg';
            elseif direction == 1
                dir = 'pos';
            end
            
            pos_func_samp_freq_name = pad_num2str_w_zeros(pos_func_samp_freq,4);
            
            spat_freq_name = pad_num2str_w_zeros(spat_freq,3);
            spat_freq_name = regexprep(num2str(spat_freq_name),'\.','p');
            
            temp_freq_name = pad_num2str_w_zeros(temp_freq,3);
            temp_freq_name = regexprep(num2str(temp_freq_name),'\.','p');
            
            func_name = ['SF_' spat_freq_name '_TF_' temp_freq_name '_DIR_' dir '_SAMPRATE_' pos_func_samp_freq_name '_w_dummy_frame'];
            
            func_iter = save_panels_position_function(save_directory,func_name,func,func_iter);

            clear func func_name
        end
    end
end