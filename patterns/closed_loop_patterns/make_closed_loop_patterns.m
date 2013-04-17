% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
% Requires the panels matlab code at flypanels.org.
%
% SLH - 2013

% Save time while testing.
testing_flag = 0;
row_compression = 0;
gs_val = 2;

% Win: 'C:\panels_experiments\patterns\windowed_prog_reg_motion_lambda_60';
save_directory = mfilename('fullpath');
save_directory = fileparts(save_directory);

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
count = [];

% Make a horzontal bar and vertical bar
%==========================================================================
    count = 999;

    pattern_str = '6px_vert_4_px_horiz_closed_loop_interspersal_pat';

    % The size of the stripes in pixels
    vert_stripe_size    = 6;
    horiz_stripe_size   = 4;
    num_rows            = 32;
    num_cols            = 96;

    switch gs_val
        case 3 % For some reason this is the only one that works...
            mid_gs_value = 3;
            high_gs_value = 7;
            low_gs_value = 0;
        case 2
            mid_gs_value = 2;
            high_gs_value = 3;
            low_gs_value = 0;
        case 1
            mid_gs_value = 0;
            high_gs_value = 1;
            low_gs_value = 0;
    end

    high_frame = high_gs_value*ones(num_rows,num_cols);

    vert_pat = [];
    % Create a vertical bar matrix
    base_vert_pat = [0*ones(num_rows,vert_stripe_size), 500*ones(num_rows,num_cols-vert_stripe_size)];
    % Vertically center the pattern at 47?
    base_vert_pat = circshift(base_vert_pat,[0 -2-vert_stripe_size/2]);
    for i = 1:num_cols
        vert_pat(:,:,i) = circshift(base_vert_pat,[0 i-1]); %#ok<*SAGROW>
    end

    horiz_pat_r = [];
    % Create a horizontal bar matrix
    base_horiz_pat = [500*ones(num_rows-horiz_stripe_size,num_cols);0*ones(horiz_stripe_size,num_cols)];
    % Horizontally center the pattern at 21?
    base_horiz_pat = circshift(base_horiz_pat,[-horiz_stripe_size/2 0]);
    for i = 1:num_rows
        horiz_pat_r(:,:,i) = circshift(base_horiz_pat,[i-1 0]); %#ok<*SAGROW>
    end

    % Overlay the two patterns
    Pats = high_frame;

    for y = 1:size(horiz_pat_r,3)
        for x = 1:size(vert_pat,3)
            Pats(:,:,x,y) = (vert_pat(:,:,x)+horiz_pat_r(:,:,y));
            frame = Pats(:,:,x,y);

            inds_eq_1000 = find(frame == 1000);
            inds_lt_1000 = find(frame < 1000);

            frame(inds_eq_1000) = high_gs_value;
            frame(inds_lt_1000) = low_gs_value;

            Pats(:,:,x,y) = frame;

            if 0
                clf
                imagesc(Pats(:,:,x,y))
                pause(.001)
            end
        end
    end

    [~] = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);

% Make a horzontal bar and vertical bar
%==========================================================================
    count = 998;
    pattern_str = '6px_vert_bar_4_px_horiz_grat_closed_loop_interspersal_pat';

    % The size of the stripes in pixels
    vert_stripe_size    = 6;
    horiz_stripe_size   = 4;
    num_rows            = 32;
    num_cols            = 96;

    switch gs_val
        case 3 % For some reason this is the only one that works...
            mid_gs_value = 3;
            high_gs_value = 7;
            low_gs_value = 0;
        case 2
            mid_gs_value = 2;
            high_gs_value = 3;
            low_gs_value = 0;
        case 1
            mid_gs_value = 0;
            high_gs_value = 1;
            low_gs_value = 0;
    end

    high_frame = high_gs_value*ones(num_rows,num_cols);

    vert_pat = [];
    % Create a vertical bar matrix
    base_vert_pat = [0*ones(num_rows,vert_stripe_size), 500*ones(num_rows,num_cols-vert_stripe_size)];
    % Vertically center the pattern at 47?
    base_vert_pat = circshift(base_vert_pat,[0 -2-vert_stripe_size/2]);
    for i = 1:num_cols
        vert_pat(:,:,i) = circshift(base_vert_pat,[0 i-1]); %#ok<*SAGROW>
    end

    horiz_pat_r = [];
    % Create a horizontal bar matrix
    base_horiz_pat = repmat([500*ones(horiz_stripe_size,num_cols);0*ones(horiz_stripe_size,num_cols)],num_rows/(horiz_stripe_size*2),1);
    % Horizontally center the pattern at 21?
    base_horiz_pat = circshift(base_horiz_pat,[-horiz_stripe_size/2 0]);
    for i = 1:num_rows
        horiz_pat_r(:,:,i) = circshift(base_horiz_pat,[i-1 0]); %#ok<*SAGROW>
    end

    % Overlay the two patterns
    Pats = high_frame;

    for y = 1:size(horiz_pat_r,3)
        for x = 1:size(vert_pat,3)
            Pats(:,:,x,y) = (vert_pat(:,:,x)+horiz_pat_r(:,:,y));
            frame = Pats(:,:,x,y);

            inds_eq_1000 = find(frame == 1000);
            inds_lt_1000 = find(frame < 1000);

            frame(inds_eq_1000) = high_gs_value;
            frame(inds_lt_1000) = low_gs_value;

            Pats(:,:,x,y) = frame;

            if 0
                clf
                imagesc(Pats(:,:,x,y))
                pause(.001)
            end
        end
    end

    [~] = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);

% Make a horzontal bar and vertical grat that moves up / down depending on the x displacement
%==========================================================================
    count = 997;
    pattern_str = '6px_vert_bar_4_px_horiz_windowed_up_down_grat_closed_loop_interspersal_pat';

    % The size of the stripes in pixels
    vert_stripe_size    = 8;
    horiz_stripe_size   = 4;
    num_rows            = 32;
    num_cols            = 96;

    switch gs_val
        case 3 % For some reason this is the only one that works...
            mid_gs_value = 3;
            high_gs_value = 7;
            low_gs_value = 0;
        case 2
            mid_gs_value = 2;
            high_gs_value = 3;
            low_gs_value = 0;
        case 1
            mid_gs_value = 0;
            high_gs_value = 1;
            low_gs_value = 0;
    end

    high_frame = high_gs_value*ones(num_rows,num_cols);

    vert_pat = [];
    % Create a vertical bar matrix
    base_vert_pat = [1000*ones(num_rows,vert_stripe_size), 0*ones(num_rows,num_cols-vert_stripe_size)];
    % Vertically center the pattern at 47?
    base_vert_pat = circshift(base_vert_pat,[0 -2-vert_stripe_size/2]);
    for i = 1:num_cols
        vert_pat(:,:,i) = circshift(base_vert_pat,[0 i-1]); %#ok<*SAGROW>
    end
    
    % Moves DOWN if x goes ccw / UP if x goes cw
    horiz_pat_l = [];
    % Create a horizontal bar matrix
    base_horiz_l_pat = repmat([1000*ones(horiz_stripe_size,num_cols);0*ones(horiz_stripe_size,num_cols)],num_rows/(horiz_stripe_size*2),1);
    % Horizontally center the pattern at 21?
    base_horiz_l_pat = circshift(base_horiz_l_pat,[-4 0]);
    for i = 1:num_cols
        horiz_pat_l(:,:,i) = circshift(base_horiz_l_pat,[i-1 0]);
    end
    
    % Moves UP if x goes ccw / DOWN if x goes cw
    horiz_pat_r = [];
    % Create a horizontal bar matrix
    base_horiz_r_pat = repmat([1000*ones(horiz_stripe_size,num_cols);0*ones(horiz_stripe_size,num_cols)],num_rows/(horiz_stripe_size*2),1);
    % Horizontally center the pattern at 21?
    base_horiz_r_pat = circshift(base_horiz_r_pat,[0 0]);
    for i = 1:num_cols
        horiz_pat_r(:,:,i) = circshift(base_horiz_r_pat,[1-i 0]);
    end
    
    % Combine the Horiz bars
    left_cols = 17:34;
    right_cols = 55:72;
    
    horiz_pat = [];
    
    for i = 1:num_cols
       horiz_pat(:,:,i) = zeros(size(high_frame,1),size(high_frame,2));
       horiz_pat(:,left_cols,i) = horiz_pat_l(:,left_cols,i);
       horiz_pat(:,right_cols,i) = horiz_pat_r(:,right_cols,i);
    end
    
    % Overlay the two patterns
    Pats = high_frame;
    y = 1;
    for x = 1:size(vert_pat,3)

        Pats(:,:,x,y) = (vert_pat(:,:,x)+horiz_pat(:,:,x));
        frame = Pats(:,:,x,y);

        inds_eq_1000 = find(frame >= 1000);
        inds_lt_1000 = find(frame < 1000);

        frame(inds_eq_1000) = low_gs_value;
        frame(inds_lt_1000) = high_gs_value;

        Pats(:,:,x,y) = frame;

        if 0
            clf
            imagesc(Pats(:,:,x,y))
            colormap(hot(3));
            pause(.01)
        end
    end

    [~] = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);

% Make a horzontal bar and vertical grat that moves up / down depending on the x displacement
%==========================================================================
    count = 996;
    pattern_str = '6px_vert_bar_4_px_horiz_windowed_down_up_grat_closed_loop_interspersal_pat';

    % The size of the stripes in pixels
    vert_stripe_size    = 8;
    horiz_stripe_size   = 4;
    num_rows            = 32;
    num_cols            = 96;

    switch gs_val
        case 3 % For some reason this is the only one that works...
            mid_gs_value = 3;
            high_gs_value = 7;
            low_gs_value = 0;
        case 2
            mid_gs_value = 2;
            high_gs_value = 3;
            low_gs_value = 0;
        case 1
            mid_gs_value = 0;
            high_gs_value = 1;
            low_gs_value = 0;
    end

    high_frame = high_gs_value*ones(num_rows,num_cols);

    vert_pat = [];
    % Create a vertical bar matrix
    base_vert_pat = [1000*ones(num_rows,vert_stripe_size), 0*ones(num_rows,num_cols-vert_stripe_size)];
    % Vertically center the pattern at 47?
    base_vert_pat = circshift(base_vert_pat,[0 -2-vert_stripe_size/2]);
    for i = 1:num_cols
        vert_pat(:,:,i) = circshift(base_vert_pat,[0 i-1]); %#ok<*SAGROW>
    end
    
    % Moves DOWN if x goes ccw / UP if x goes cw
    horiz_pat_l = [];
    % Create a horizontal bar matrix
    base_horiz_l_pat = repmat([1000*ones(horiz_stripe_size,num_cols);0*ones(horiz_stripe_size,num_cols)],num_rows/(horiz_stripe_size*2),1);
    % Horizontally center the pattern at 21?
    base_horiz_l_pat = circshift(base_horiz_l_pat,[0 0]);
    for i = 1:num_cols
        horiz_pat_l(:,:,i) = circshift(base_horiz_l_pat,[1-i 0]);
    end
    
    % Moves UP if x goes ccw / DOWN if x goes cw
    horiz_pat_r = [];
    % Create a horizontal bar matrix
    base_horiz_r_pat = repmat([1000*ones(horiz_stripe_size,num_cols);0*ones(horiz_stripe_size,num_cols)],num_rows/(horiz_stripe_size*2),1);
    % Horizontally center the pattern at 21?
    base_horiz_r_pat = circshift(base_horiz_r_pat,[-4 0]);
    for i = 1:num_cols
        horiz_pat_r(:,:,i) = circshift(base_horiz_r_pat,[i-1 0]);
    end
    
    % Combine the Horiz bars
    left_cols = 17:34;
    right_cols = 55:72;
    
    horiz_pat = [];
    
    for i = 1:num_cols
       horiz_pat(:,:,i) = zeros(size(high_frame,1),size(high_frame,2));
       horiz_pat(:,left_cols,i) = horiz_pat_l(:,left_cols,i);
       horiz_pat(:,right_cols,i) = horiz_pat_r(:,right_cols,i);
    end
    
    % Overlay the two patterns
    Pats = high_frame;
    y = 1;
    for x = 1:size(vert_pat,3)

        Pats(:,:,x,y) = (vert_pat(:,:,x)+horiz_pat(:,:,x));
        frame = Pats(:,:,x,y);

        inds_eq_1000 = find(frame >= 1000);
        inds_lt_1000 = find(frame < 1000);

        frame(inds_eq_1000) = low_gs_value;
        frame(inds_lt_1000) = high_gs_value;

        Pats(:,:,x,y) = frame;

        if 0
            clf
            imagesc(Pats(:,:,x,y))
            colormap(hot(3));
            pause(.01)
        end
    end

    [~] = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
