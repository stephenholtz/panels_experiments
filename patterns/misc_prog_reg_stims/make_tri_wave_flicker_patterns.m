% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
% SLH - 2013

% This will make a triangle flicker-ish stimulus
% A random noise stimulus will increase and decrease in 
% average inensity on one half of the arena

% Counter for iterating the pattern names, set nonzero if appending to another experiment.
if ~exist('count','var'); 
    count = 1;
end

save_directory = mfilename('fullpath');
save_directory = fileparts(save_directory);

% For zero padding the names properly
pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

% Add in required functions
addpath(fullfile(save_directory,'..','..'));
addpath(genpath('~/XmegaController_Matlab_V13'))

testing_flag = 0;
row_compression = 0;
num_cols = 96;
num_rows = 32;
left_cols = 7:40; % -142.5->15, 15->142.5
right_cols = 49:82; % 0->142.5
full_cols = 7:82; % -142.5->142.5
horiz = 1:num_rows;

gs_val = 3;
min_gs = 0;
mid_gs = 3;
max_gs = 7;

num_pat_inds = num_rows*num_cols;
dummy_frame = mid_gs*ones(num_rows,num_cols,1);


for side = 1:2
    
    Pats = dummy_frame;
    
    if side == 1
        curr_cols = right_cols;
        side_str = 'right';
    else
        curr_cols = left_cols;
        side_str = 'left';
    end

    iter = 1;
    for mean_intensity = 1:.25:6.5
        rand_bkg = randi(8,num_pat_inds,1)-1;
        combined_pat = reshape(rand_bkg,num_rows,num_cols);

        % Random distribution with mean (i-1) and std...
        flicker_inds = round(mean_intensity-1 + 1*randn(numel(left_cols)*num_rows,1));
        flicker_inds(flicker_inds > max_gs) = max_gs;
        flicker_inds(flicker_inds < min_gs) = min_gs;
        combined_pat(1:num_rows,curr_cols) = reshape(flicker_inds,num_rows,numel(left_cols));
        
        Pats(:,:,iter) = combined_pat;
        clear combined_pat;
        
        iter = iter + 1;
    end
    
    Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);
    num_frames_str = ['NUM_FRAMES_' pad_num2str_w_zeros(size(Pats,3),3) '_'];
    pattern_str = [num_frames_str 'triangle_wave_noise_flicker_' side_str];
    count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
end
