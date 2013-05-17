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

testing_flag = 0;
row_compression = 0;
num_cols = 96;
num_rows = 32;
left_cols = 7:40; % -142.5->15, 15->142.5
right_cols = 49:82; % 0->142.5
full_cols = 7:82; % -142.5->142.5
horiz = 1:num_rows;

% Set up greyscale values
% gs_val = 3;
% min_gs = 0;
% mid_gs = 3;
% max_gs = 7;
% Use gs 2
gs_val = 2;
min_gs = 0;
mid_gs = 1;
max_gs = 3;

num_pat_inds = num_rows*num_cols;
dummy_frame = mid_gs*ones(num_rows,num_cols,1);
Pats = dummy_frame;

for stripe_lam = [30 60]

    % Figure out how many blocks there are
    n_px = stripe_lam/2 /3.75;

    num_block_rows = num_rows/n_px;
    num_block_cols = num_cols/n_px;

    % Make half of the blocks on and half off, then shuffle them around
    num_blocks = num_block_rows*num_block_cols;
    block_ind_vals = [min_gs*ones(1,num_blocks/2) max_gs*ones(1,num_blocks/2)];
    block_ind_vals = block_ind_vals(randperm(num_blocks));

    % Reshape and blow up the matrix to arena size
    block_matrix = reshape(block_ind_vals,num_block_rows,num_block_cols);
    block_matrix = kron(block_matrix,ones(n_px,n_px));

    for side = 1:3
        clear Pats

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

        for pos = 1:num_cols % this is periodic wrt the whole arena
            Pats(:,:,pos) = dummy_frame; %#ok<*SAGROW>
            temp_block_matrix = circshift(block_matrix,[0 pos-1]);
            Pats(1:num_rows,curr_cols,pos) = temp_block_matrix(1:num_rows,curr_cols);
        end

        num_frames_str = ['NUM_FRAMES_' pad_num2str_w_zeros(size(Pats,3),3) '_'];
        pattern_str = [num_frames_str 'block_randomized_lam_' num2str(stripe_lam) '_' side_str];
        Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);
        count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
    end
end
