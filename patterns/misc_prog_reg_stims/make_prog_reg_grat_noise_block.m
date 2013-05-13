% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
%
% SLH - 2013

% This script will make the regular prog/reg gratings, with noise,
% and with flicker (and the full field grating)

% Save time while testing.
testing_flag = 1;
% Row compression is not necessary, all fit onto panels memory without it
row_compression = 0; 
% Use this so conversion to sine wave is easier later (more values)
gs_val = 3;

mid_gs_value = 3;
high_gs_value = 7;
low_gs_value = 0;

save_directory = mfilename('fullpath');
save_directory = fileparts(save_directory);

% Add in required functions
addpath(fullfile(save_directory,'..','..'));
addpath(genpath('~/XmegaController_Matlab_V13'))

% The size of the stripes in pixels
stripe_sizes = [4 8];
num_rows = 32;
num_cols = 96;

% Counter for iterating the pattern names, set nonzero if appending to another experiment.
if ~exist('count','var'); 
    count = 1;
end

dummy_frame = mid_gs_value*ones(num_rows,96);

% [ x(left)  y(right) ]
% 1 blank
% 2 bars (vertical)
% 3 alternating flickering bars (1:1 Hz)
% 4 alternating flickering bars (4:1 Hz)
pattern_combinations = [1 2;...
                        2 1;...
                        1 3;...
                        3 1;...
                        1 4;...
                        4 1;...
                        2 3;...
                        3 2;...
                        2 4];
pattern_combination_str = {'blank','v_grt','v1flk','v4flk'};
pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

left_cols = 7:40; % -142.5->15, 15->142.5
right_cols = 49:82; % 0->142.5
full_cols = 7:82; % -142.5->142.5
horiz = 1:num_rows;

for noise_level = 1:3
    if noise_level == 1
        noise_str = 'no_noise'; % 0% noise, on normal stims
    elseif noise_level == 2
        noise_str = '17_noise'; % 25% noise, on normal stims
    elseif noise_level == 3
        noise_str = '50_noise'; % 50% noise, on normal stims
    end
for stripe_size = stripe_sizes %Stripe sizes 30,60 degs
    px_str = ['PX_' pad_num2str_w_zeros(stripe_size,2)];
    % Determine how large temporary pattern should be
    N_temp_pat_rows = num_rows;
    N_temp_pat_cols = 96;
    
    for pat_comb_row = 1:size(pattern_combinations,1)
        
        clear pat
        for side = 1:2
            if side == 1
                side_str = 'left';
            elseif side == 2
                side_str = 'right';
            end

            % Left side / right side 
            base_pat = []; 
            switch pattern_combinations(pat_comb_row,side)
                case 1

                    % blank (have two blank frames so looping for flicker
                    for i = 1:8
                        pat.(side_str)(:,:,i,1) = mid_gs_value * ones(N_temp_pat_rows,N_temp_pat_cols);
                    end
               case 2

                    % vertical grating
                    base_pat = repmat([low_gs_value*ones(N_temp_pat_rows,stripe_size), high_gs_value*ones(N_temp_pat_rows,stripe_size)],1,ceil(N_temp_pat_cols/(2*stripe_size)));
                    for i = 1:stripe_size*2
                        pat.(side_str)(:,:,i,1) = circshift(base_pat,[0 i-1]);
                    end
                 case 3

                    % vertical flicker at 1x the TF
                    pol=1;
                    for i = 1:stripe_size*2
                        if ~mod(i,stripe_size)
                            pol = 2;
                        end

                        if pol == 1;
                             pat.(side_str)(:,:,i,1) = repmat([low_gs_value *ones(N_temp_pat_rows,stripe_size),high_gs_value*ones(N_temp_pat_rows,stripe_size)],1,ceil(N_temp_pat_cols/(2*stripe_size)));
                        elseif pol == 2;
                            pat.(side_str)(:,:,i,1) = repmat([high_gs_value*ones(N_temp_pat_rows,stripe_size),low_gs_value *ones(N_temp_pat_rows,stripe_size)],1,ceil(N_temp_pat_cols/(2*stripe_size)));
                        end
                    end
                case 4

                    % vertical flicker at 4x the TF
                    pol=1;
                    for i = 1:stripe_size*2
                        if ~mod(i,stripe_size/4)
                            if pol == 1
                                pol = 2;
                            elseif pol == 2;
                                pol = 1;
                            end
                        end

                        if pol == 1;
                             pat.(side_str)(:,:,i,1) = repmat([low_gs_value *ones(N_temp_pat_rows,stripe_size),high_gs_value*ones(N_temp_pat_rows,stripe_size)],1,ceil(N_temp_pat_cols/(2*stripe_size)));
                        elseif pol == 2;
                            pat.(side_str)(:,:,i,1) = repmat([high_gs_value*ones(N_temp_pat_rows,stripe_size),low_gs_value *ones(N_temp_pat_rows,stripe_size)],1,ceil(N_temp_pat_cols/(2*stripe_size)));
                        end
                    end
            end
        end

        % Fix the offset of the patterns to make them more symmetrical
        if stripe_size == 4
            for i = 1:size(pat.left,3)
                pat.left(:,:,i) = circshift(pat.left(:,:,i),[0 1]);
            end
            for i = 1:size(pat.right,3)
                pat.right(:,:,i) = circshift(pat.right(:,:,i),[0 3]);
            end
        elseif stripe_size == 8
            for i = 1:size(pat.left,3)
                pat.left(:,:,i) = circshift(pat.left(:,:,i),[0 11]);
            end
            for i = 1:size(pat.right,3)
                pat.right(:,:,i) = circshift(pat.right(:,:,i),[0 5]);
            end
        end

        % Pattern_###_PX_###_LEFT_(h/v_grt/flk,blank)_RIGHT_(...).mat
        l_str = ['LEFT_' pattern_combination_str{pattern_combinations(pat_comb_row,1)}];
        r_str = ['RIGHT_' pattern_combination_str{pattern_combinations(pat_comb_row,2)}];
        pattern_str = ['windowed_' noise_str '_' px_str '_' l_str '_' r_str];

        % Loop until both of the sides have completed
        clear Pats
        l_loop_sz = size(pat.left,3);
        r_loop_sz = size(pat.right,3);
        if l_loop_sz > r_loop_sz
            for x = 1:l_loop_sz
                Pats(:,:,x,1) = dummy_frame; %#ok<*SAGROW>
                Pats(horiz,left_cols,x,1) = pat.left(horiz,left_cols,x);
                Pats(horiz,right_cols,x,1) = pat.right(horiz,right_cols,mod(x,2)+1);
            end
        elseif r_loop_sz > l_loop_sz
            for x = 1:r_loop_sz
                Pats(:,:,x,1) = dummy_frame;
                Pats(horiz,left_cols,x,1) = pat.left(horiz,left_cols,mod(x,2)+1);
                Pats(horiz,right_cols,x,1) = pat.right(horiz,right_cols,x);
            end
        elseif l_loop_sz == r_loop_sz
            for x = 1:r_loop_sz
                Pats(:,:,x,1) = dummy_frame;
                Pats(horiz,left_cols,x,1) = pat.left(horiz,left_cols,x);
                Pats(horiz,right_cols,x,1) = pat.right(horiz,right_cols,x);
            end            
        end

        % Add noise to the dummy frame as well.
        Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);

        % deal with the noise 
        num_pat_inds = num_rows*num_cols;
        if noise_level ~= 1
            if noise_level == 2
                num_noise_inds = num_pat_inds/6;
            elseif noise_level == 3
                num_noise_inds = num_pat_inds/2;
            end

            for i = 1:size(Pats,3)
                temp_pat = Pats(:,:,i);

                % Make a noise pattern
                noise_pat = randi(high_gs_value,num_pat_inds,1)-1;
                
                % Take a random set of inds
                noise_inds = randperm(num_pat_inds);
                noise_inds = noise_inds(1:num_noise_inds)';

                % Take the rest of inds from the pattern
                pat_inds = ones(num_pat_inds,1);
                pat_inds(noise_inds) = 0;
                pat_inds = find(pat_inds==1);

                % Combine the patterns and reshape into a frame
                combined_pat = zeros(num_pat_inds,1);
                combined_pat(noise_inds) = noise_pat(noise_inds);
                combined_pat(pat_inds) = temp_pat(pat_inds);

                Pats(:,:,i) = reshape(combined_pat,num_rows,num_cols);
            end
        end

        count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
    end
end
end
