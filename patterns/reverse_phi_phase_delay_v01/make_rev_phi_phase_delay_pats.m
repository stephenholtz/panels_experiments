% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
%
% SLH - 2013

% Make reverse phi phase delay patterns, a new pattern for each flicker
% so I can load them all to the panels.

% Save time while testing.
testing_flag = 0;
% Row compression is not necessary, all fit onto panels memory without it
row_compression = 1;
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

% The size of the stripes in pixels (like from before)
stripe_sizes = [4 8];
stripe_speeds = [1,4,8];

num_rows = 4;
num_cols = 96;

% Counter for iterating the pattern names, set nonzero if appending to another experiment.
count = 1;
if ~exist('count','var'); 
    count = 1;
end

dummy_frame = mid_gs_value*ones(num_rows,96);
pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

for stripe_size = stripe_sizes
    px_str = ['PX_' pad_num2str_w_zeros(stripe_size,2)];
    pol_1_grat = repmat([low_gs_value*ones(num_rows,stripe_size),mid_gs_value*ones(num_rows,stripe_size)],1,ceil(num_cols/(2*stripe_size)));
    pol_2_grat = repmat([high_gs_value*ones(num_rows,stripe_size),mid_gs_value *ones(num_rows,stripe_size)],1,ceil(num_cols/(2*stripe_size)));

    for flicker_offset = 1:3
        clear Pats
        switch flicker_offset
            case 1
                offset_str = 'flick_bef';
                ind = 1;
                for i = 1:2:stripe_size*2
                    Pats(:,:,ind,1) = circshift(pol_1_grat,[0 i-1]);
                    ind = ind + 1;
                    Pats(:,:,ind,1) = circshift(pol_2_grat,[0 i-1]);
                    ind = ind + 1;
                    Pats(:,:,ind,1) = circshift(pol_2_grat,[0 i]);
                    ind = ind + 1;
                    Pats(:,:,ind,1) = circshift(pol_1_grat,[0 i]);
                    ind = ind + 1;
                end
            case 2
                offset_str = 'flick_dur';
                ind = 1;
                for i = 1:stripe_size*2
                    if mod(i,2)
                        Pats(:,:,ind,1) = circshift(pol_1_grat,[0 i-1]);
                        ind = ind + 1;
                    else
                        Pats(:,:,ind,1) = circshift(pol_2_grat,[0 i-1]);
                        ind = ind + 1;
                    end
                end
            case 3
                offset_str = 'flick_aft';
                ind = 1;
                for i = 1:2:stripe_size*2
                    Pats(:,:,ind,1) = circshift(pol_1_grat,[0 i-1]);
                    ind = ind + 1;
                    Pats(:,:,ind,1) = circshift(pol_1_grat,[0 i]);
                    ind = ind + 1;
                    Pats(:,:,ind,1) = circshift(pol_2_grat,[0 i-1]);
                    ind = ind + 1;
                    Pats(:,:,ind,1) = circshift(pol_2_grat,[0 i]);
                    ind = ind + 1;
                end
        end

        % Add noise to the dummy frame as well.
        Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);

        num_frames_str = ['NUM_FRAMES_' pad_num2str_w_zeros(size(Pats,3),3)];
        pattern_str = ['rev_phi_phase_del_' num_frames_str '_' px_str '_' offset_str];
        count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
    end
end
