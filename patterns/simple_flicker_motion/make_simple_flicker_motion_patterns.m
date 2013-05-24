% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
% SLH - 2013

% Counter for iterating the pattern names, set nonzero if appending to another experiment.
if ~exist('count','var'); 
    count = 1;
end

save_directory = mfilename('fullpath');
save_directory = fileparts(save_directory);

% Add in required functions
addpath(fullfile(save_directory,'..','..'));
addpath(genpath('~/XmegaController_Matlab_V13'))

% For zero padding the names properly
pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

testing_flag    = 0;
row_compression = 0;
num_stim_cols   = 32; % only use 32 of them
num_arena_cols  = 96;
num_rows        = 32;
left_cols       = 1:36;
right_cols      = 61:96;
full_cols       = 1:96;
horiz           = 1:num_rows;

% Set up greyscale values, 3 works
gs_val = 3;
switch gs_val
    case 1
        min_gs = 0;
        mid_gs = 1;
        max_gs = 1;        
    case 2
        min_gs = 0;
        mid_gs = 1;
        max_gs = 3;
    case 3
        min_gs = 0;
        mid_gs = 3;
        max_gs = 7;
end

num_pat_inds = num_rows*num_stim_cols;
mid_gs_frame = mid_gs*ones(num_rows,num_arena_cols,1);
Pats = mid_gs_frame;

for side = 1
    if side == 1
        curr_cols = right_cols;
        side_str = 'right';
    elseif side == 2
        curr_cols = left_cols;
        side_str = 'left';
    elseif side == 3
        curr_cols = full_cols;
        side_str = 'full';
    end

    for pattern_type = 1:4
        clear pat
        switch pattern_type
            case 1
                stim_str = 'on_off_flicker';
                % ON->OFF Flicker, the dummy frame here has to be the same as the first frame
                for pol = 1:2
                    if pol == 1;
                        pat(:,:,pol,1) = max_gs*ones(num_rows,num_arena_cols);
                    elseif pol == 2;
                        pat(:,:,pol,1) = min_gs*ones(num_rows,num_arena_cols);
                    end
                end

            case 2
                stim_str = 'off_on_flicker';
                % OFF->ON Flicker
                for pol = 1:2
                    if pol == 1;
                        pat(:,:,pol,1) = min_gs*ones(num_rows,num_arena_cols);
                    elseif pol == 2;
                        pat(:,:,pol,1) = max_gs*ones(num_rows,num_arena_cols);
                    end
                end

            case 3
                stim_str = 'vert_grat_lam_45';
                % vertical grating, dummy frame again is the first frame repeated
                stripe_size = 12; % 12 is lam 45 degrees (1.875*12*2)
                base_pat = repmat([min_gs*ones(num_rows,stripe_size), max_gs*ones(num_rows,stripe_size)],1,ceil(num_arena_cols/(2*stripe_size)));
                for i = 1:stripe_size*2
                    pat(:,:,i,1) = circshift(base_pat,[0 i-1]);
                end
            case 4
                stim_str = 'empty_mid_gs_frame';
                pat(:,:,1,1) = mid_gs_frame;
        end

        % Add the stimulus to the correct side
        clear Pats
        for x = 1:size(pat,3);
            Pats(:,:,x,1) = mid_gs_frame;
            Pats(horiz,curr_cols,x,1) = pat(horiz,curr_cols,x);
        end
        dummy_frame = Pats(:,:,1,1);

        % Add noise to the dummy frame as well.
        Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);                

        num_frames_str = ['gs_' num2str(gs_val) '_NUM_FRAMES_' pad_num2str_w_zeros(size(Pats,3),3)];
        pattern_str = [num_frames_str '_' stim_str '_' side_str];
        count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
    end
end
