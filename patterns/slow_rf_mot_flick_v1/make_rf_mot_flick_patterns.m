% Make patterns to look for receptive fields and directional asymmetries
% These patterns mimic those used in the 2013 Clandinin lab paper
%
% The arena is a 96 x 48 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
%
% SLH - 2013

% All of these patterns will have a dummy frame (frame 1) followed by
% stimulus frames 2:end. Position functions determine the speed for these
% patterns.

% Stupid warnings
%#ok<*NBRAK>
%#ok<*SAGROW>

% Set up save directory (this m file's directory)
save_directory = mfilename('fullpath');
save_directory = fileparts(save_directory);

% Add in required functions
addpath(fullfile(save_directory,'..','..'));
addpath(genpath('~/XmegaController_Matlab_V13'))

% For zero padding the names properly
pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

% Save time while testing.
testing_flag = 0;
% Row compression is not necessary for all
row_compression = 0;  

% The gs value for the experiment
gs_val = 3;
mid_gs_value = 3;
high_gs_value = 7;
low_gs_value = 0;

% Size of the arena
num_cols = 96;

% These are not symmetrical (only testing right, so let visual extent go into left side)
left_cols = 1:40;
right_cols = 41:96;

% Pattern iterator
count = 1;

%=Make sine/square wave grating============================================
grat_type = 'square_wave';
base_pattern_name = [grat_type '_'];

sfs = [30 60 90];
col_widths = sfs/(2*3.75);
row_compression = 1;
num_rows = 4;
for col_width = col_widths
    clear Pats pat
    switch grat_type
        case 'sine_wave'
            base_wave = [];
        case 'square_wave'
            base_wave = repmat([high_gs_value*ones(num_rows,col_width) low_gs_value*ones(num_rows,col_width)],1,num_cols/col_width*2);
        otherwise
            error(['grat_type ' grat_type ' is not an option'])
    end

    % Complete one cycle of the stimulus per pattern
    pat.dummy_frame = mid_gs_value*ones(num_rows,num_cols);

    if col_width == 4
        base_wave = circshift(base_wave,[0 2]);
    elseif col_width == 8
        base_wave = circshift(base_wave,[0 0]);
    elseif col_width == 12
        base_wave = circshift(base_wave,[0 2]);
    end
    
    for i = 1:col_width*2
        pat.right(:,:,i,1) = circshift(base_wave,[0 i-1]);
    end

    for i = 1:size(pat.right,3)
        Pats(:,:,i)  = pat.dummy_frame; 
        Pats(:,right_cols,i) = pat.right(:,right_cols,i,1);
    end

    n_frames = size(Pats,3);
    pattern_str = [pad_num2str_w_zeros(n_frames,3) '_frames_' grat_type '_' num2str(col_width) 'px_wide' '_w_dummy_frame'];
    % Add the dummy frame
    Pats = add_dummy_frame_to_pattern(Pats,pat.dummy_frame,'x',1);
    Pats(:,right_cols,1) = pat.right(:,right_cols,1);
    
    % Save the pattern
    count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
end

%=Make single stripes that move on the right hand side of the arena========

% Both Polarities
for pol = 1:2
    switch pol
        case 1
            pol_str = 'ON';
            frg_val = high_gs_value;
            bkg_val = mid_gs_value;
        case 2
            pol_str = 'OFF';
            frg_val = low_gs_value;
            bkg_val = mid_gs_value;
    end
    stripe_size = 3;
    
    % Left, Right, Up, Down w/ 'Edges' and Stripes
    for dir = 1:8
        clear Pats pat
        switch dir
            case 1
                row_compression = 1;
                num_rows = 4;
                dummy_frame = mid_gs_value*ones(num_rows,num_cols);
                dir_str = 'prog';
                bar_str = 'edge';
                frame = 1;
                for x = 1:numel(right_cols)
                    Pats(:,:,frame) = circshift([frg_val*ones(num_rows,x) bkg_val*ones(num_rows,num_cols-x)],[0 right_cols(1)]);
                    frame = frame + 1;
                end
                for frame = 1:size(Pats,3)
                    Pats(:,:,frame) = circshift(Pats(:,:,frame),[0 -1]);
                    Pats(:,left_cols,frame) = dummy_frame(:,left_cols);
                end
            case 2
                row_compression = 1;
                num_rows = 4;
                dummy_frame = mid_gs_value*ones(num_rows,num_cols);
                dir_str = 'reg';
                bar_str = 'edge';
                frame = 1;
                for x = 1:numel(right_cols)
                    Pats(:,:,frame) = circshift([bkg_val*ones(num_rows,num_cols-x) frg_val*ones(num_rows,x)],[0 num_cols]);
                    frame = frame + 1;
                end
                for frame = 1:size(Pats,3)
                    Pats(:,:,frame) = circshift(Pats(:,:,frame),[0 0]);
                    Pats(:,left_cols,frame) = dummy_frame(:,left_cols);
                end
            case 3
                row_compression = 0;
                num_rows = 32;
                dummy_frame = mid_gs_value*ones(num_rows,num_cols);
                dir_str = 'down';
                bar_str = 'edge';
                frame = 1;
                for x = 0:num_rows
                    Pats(:,:,frame) = [frg_val*ones(x,num_cols); bkg_val*ones(num_rows-x,num_cols)];
                    frame = frame + 1;
                end
                for frame = 1:size(Pats,3)
                    Pats(:,left_cols,frame) = dummy_frame(:,left_cols);
                end
            case 4
                row_compression = 0;
                num_rows = 32;
                dummy_frame = mid_gs_value*ones(num_rows,num_cols);
                dir_str = 'up';
                bar_str = 'edge';
                frame = 1;
                for x = 0:num_rows
                    Pats(:,:,frame) = [bkg_val*ones(num_rows-x,num_cols); frg_val*ones(x,num_cols)];
                    frame = frame + 1;
                end
                for frame = 1:size(Pats,3)
                    Pats(:,left_cols,frame) = dummy_frame(:,left_cols);
                end
            case 5
                row_compression = 1;
                num_rows = 4;
                dummy_frame = mid_gs_value*ones(num_rows,num_cols);
                dir_str = 'prog';
                bar_str = 'bar';
                base_stripe_pat = [frg_val*ones(num_rows,stripe_size) bkg_val*ones(num_rows,num_cols-stripe_size)];
                frame = 1;
                for x = right_cols(1)-stripe_size:right_cols(end)+stripe_size
                    Pats(:,:,frame) = circshift(base_stripe_pat,[0 x]);
                    frame = frame + 1;
                end
                for frame = 1:size(Pats,3)
                    Pats(:,left_cols,frame) = dummy_frame(:,left_cols);
                end
            case 6
                row_compression = 1;
                num_rows = 4;
                dummy_frame = mid_gs_value*ones(num_rows,num_cols);
                dir_str = 'reg';
                bar_str = 'bar';
                base_stripe_pat = [bkg_val*ones(num_rows,num_cols-stripe_size) frg_val*ones(num_rows,stripe_size)];
                frame = 1;
                for x = right_cols(end)+stripe_size:-1:right_cols(1)-stripe_size
                    Pats(:,:,frame) = circshift(base_stripe_pat,[0 x]);
                    frame = frame + 1;
                end
                for frame = 1:size(Pats,3)
                    Pats(:,left_cols,frame) = dummy_frame(:,left_cols);
                end
            case 7
                row_compression = 0;
                num_rows = 32;
                dummy_frame = mid_gs_value*ones(num_rows,num_cols);
                dir_str = 'down';
                bar_str = 'bar';
                base_stripe_pat = [frg_val*ones(stripe_size,num_cols); bkg_val*ones(num_rows,num_cols)];
                frame = 1;
                for x = 1:num_rows+stripe_size
                    pat(:,:,frame) = circshift(base_stripe_pat,[x-1 0]);
                    frame = frame + 1;
                end
                for frame = 1:size(pat,3)
                    Pats(:,:,frame) = pat(stripe_size+1:num_rows+stripe_size,1:num_cols,frame);
                    Pats(:,left_cols,frame) = dummy_frame(:,left_cols);
                end
            case 8
                row_compression = 0;
                num_rows = 32;
                dummy_frame = mid_gs_value*ones(num_rows,num_cols);
                dir_str = 'up';
                bar_str = 'bar';
                base_stripe_pat = [bkg_val*ones(num_rows,num_cols); frg_val*ones(stripe_size,num_cols)];
                frame = 1;
                for x = num_rows+stripe_size:-1:1
                    pat(:,:,frame) = circshift(base_stripe_pat,[x 0]);
                    frame = frame + 1;
                end
                for frame = 1:size(pat,3)
                    Pats(:,:,frame) = pat(1:num_rows,1:num_cols,frame);
                    Pats(:,left_cols,frame) = dummy_frame(:,left_cols);
                end
        end
        
        n_frames = size(Pats,3);
        pattern_str = [pad_num2str_w_zeros(n_frames,3) '_frames_' pol_str '_' dir_str '_' bar_str '_w_dummy_str'];
        
        % Add the dummy frame
        Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);
        % Save the pattern
        count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
    end
end

%==Make full field flicker stimuli and  partial field flicker stimuli======
% Working - !
row_compression = 1;
num_rows = 4;
for pol = 1:2
    switch pol
        case 1
            % ON(2)-MID(2)-ON(2)-MID(2)
            pol_str = 'ON';
            frg_val = high_gs_value;
            bkg_val = mid_gs_value;
        case 2
            % OFF(2)-MID(2)-OFF(2)-MID(2)
            pol_str = 'OFF';
            frg_val = low_gs_value;
            bkg_val = mid_gs_value;
    end
    
    dummy_frame = mid_gs_value*ones(num_rows,num_cols);
    
    for extent = 1:5
        clear Pats pat
        switch extent
            case 1
                % 'full' field
                flicker_cols = [49:96];
                flicker_rows = [1:4];
                quad_str = 'full_right';
            case 2
                % 'Quad I/Upper Right'
                flicker_cols = [73:96];
                flicker_rows = [1:2];
                quad_str = 'quad1_right';
                
            case 3
                % 'Quad II/Upper Left'
                flicker_cols = [49:72];
                flicker_rows = [1:2];
                quad_str = 'quad2_right';
                
            case 4
                % 'Quad III/Bottom Left'
                flicker_cols = [49:72];
                flicker_rows = [3:4];
                quad_str = 'quad3_right';
            case 5
                % 'Quad IV/Bottom Right'
                flicker_cols = [73:96];
                flicker_rows = [3:4];
                quad_str = 'quad4_right';
        end
        n_pix = numel(flicker_cols)*numel(flicker_rows);
        Pats(:,:,1) = mid_gs_value*ones(num_rows,num_cols);
        tmp_frame = frg_val*ones(num_rows,num_cols);
        Pats(flicker_rows,flicker_cols,1) = tmp_frame(flicker_rows,flicker_cols);
        Pats(:,:,2) = mid_gs_value*ones(num_rows,num_cols);
        
        n_frames = size(Pats,3);
        pattern_str = [pad_num2str_w_zeros(n_frames,3) '_frames_flicker_' pol_str '_' quad_str '_w_dummy_str'];
        
        % Add the dummy frame
        Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);
        % Save the pattern
        count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
    end
end