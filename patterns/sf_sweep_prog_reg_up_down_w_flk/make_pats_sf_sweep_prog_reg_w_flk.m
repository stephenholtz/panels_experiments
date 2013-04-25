% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
%
% SLH - 2013

clear

% All patters have strings for regexpi / sanity
% Pattern_###_16PxWind_PX_###_LEFT_(h/v_grt/flk,blank)_RIGHT_(...).mat

% Save time while testing.
testing_flag = 0;
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
stripe_sizes = [2 4 6 8 12 16];
num_rows = 32;

% Counter for iterating the pattern names, set nonzero if appending to another experiment.
count = 1;

dummy_frame = mid_gs_value*ones(num_rows,96);

% [ x(left)  y(right) ]
% 1 blank
% 2 flicker (vertical)
% 3 flicker (horizontal)
% 4 bars (vertical)
% 5 bars (horizontal)
% 6 bars(horizontal in - direction)
% 6 bars(horizontal in + direction)
pattern_combinations = [1 2;...
                        2 1;...
                        1 3;...
                        3 1;...
                        1 4;...
                        4 1;...
                        1 5;...
                        5 1;...
                        2 4;...
                        4 2;...
                        3 5;...
                        5 3;...
                        4 4;...
                        5 5;...
                        6 7];
pattern_combination_str = {'blank','v_flk','h_flk','v_grt','h_grt','hrgrt','hrgrt'};
pattern_windows = {(21:36),(53:68),(1:32)}; % 30?-90?

pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

for stripe_size = stripe_sizes
    
    px_str = ['PX_' pad_num2str_w_zeros(stripe_size,2)];
    
    % Determine how large temporary pattern should be
    N_temp_pat_rows = 32;
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
                    % and blank can happen the same way)
                    pat.(side_str)(:,:,1,1) = mid_gs_value * ones(N_temp_pat_rows,N_temp_pat_cols);
                    pat.(side_str)(:,:,2,1) = mid_gs_value * ones(N_temp_pat_rows,N_temp_pat_cols);
                case 2
                    % vertical flicker
                    for i = 1:2:stripe_size*2
                        pat.(side_str)(:,:,i,1) = repmat([low_gs_value *ones(N_temp_pat_rows,stripe_size), mid_gs_value*ones(N_temp_pat_rows,stripe_size),...
                                                          high_gs_value*ones(N_temp_pat_rows,stripe_size), mid_gs_value*ones(N_temp_pat_rows,stripe_size)],1,ceil(N_temp_pat_cols/(4*stripe_size)));
                        pat.(side_str)(:,:,i+1,1) = repmat([high_gs_value*ones(N_temp_pat_rows,stripe_size), mid_gs_value*ones(N_temp_pat_rows,stripe_size),...
                                                          low_gs_value *ones(N_temp_pat_rows,stripe_size), mid_gs_value*ones(N_temp_pat_rows,stripe_size)],1,ceil(N_temp_pat_cols/(4*stripe_size)));
                    end
                case 3
                    % horizontal flicker
                    for i = 1:2:stripe_size*2
                        pat.(side_str)(:,:,i,1) = repmat([low_gs_value *ones(stripe_size,N_temp_pat_cols); mid_gs_value*ones(stripe_size,N_temp_pat_cols);...
                                                          high_gs_value*ones(stripe_size,N_temp_pat_cols); mid_gs_value*ones(stripe_size,N_temp_pat_cols)],ceil(N_temp_pat_rows/(4*stripe_size)),1);
                        pat.(side_str)(:,:,i+1,1) = repmat([high_gs_value*ones(stripe_size,N_temp_pat_cols); mid_gs_value*ones(stripe_size,N_temp_pat_cols);...
                                                          low_gs_value *ones(stripe_size,N_temp_pat_cols); mid_gs_value*ones(stripe_size,N_temp_pat_cols)],ceil(N_temp_pat_rows/(4*stripe_size)),1);
                    end
                case 4
                    % vertical grating
                    base_pat = repmat([low_gs_value*ones(N_temp_pat_rows,stripe_size), high_gs_value*ones(N_temp_pat_rows,stripe_size)],1,ceil(N_temp_pat_cols/(2*stripe_size)));
                    for i = 1:stripe_size*2
                        pat.(side_str)(:,:,i,1) = circshift(base_pat,[0 i-1]);
                    end
                case 5
                    % horizontal grating
                    base_pat = repmat([low_gs_value*ones(stripe_size,N_temp_pat_cols); high_gs_value*ones(stripe_size,N_temp_pat_cols)],ceil(N_temp_pat_rows/(2*stripe_size)),1);
                    for i = 1:stripe_size*2
                        pat.(side_str)(:,:,i,1) = circshift(base_pat,[1-i 0]);
                    end
                case 6
                    % horizontal grating that go in opposite directions
                    base_pat = repmat([low_gs_value*ones(stripe_size,N_temp_pat_cols); high_gs_value*ones(stripe_size,N_temp_pat_cols)],ceil(N_temp_pat_rows/(2*stripe_size)),1);
                    for i = 1:stripe_size*2
                        pat.(side_str)(:,:,i,1) = circshift(base_pat,[i-1 0]);
                    end
                case 7
                    % horizontal grating that go in opposite directions
                    base_pat = repmat([low_gs_value*ones(stripe_size,N_temp_pat_cols); high_gs_value*ones(stripe_size,N_temp_pat_cols)],ceil(N_temp_pat_rows/(2*stripe_size)),1);
                    for i = 1:stripe_size*2
                        pat.(side_str)(:,:,i,1) = circshift(base_pat,[1-i 0]);
                    end
            end
        end
        
        l_str = ['LEFT_' pattern_combination_str{pattern_combinations(pat_comb_row,1)}];
        r_str = ['RIGHT_' pattern_combination_str{pattern_combinations(pat_comb_row,2)}];
        
        % Pattern_###_PX_###_LEFT_(h/v_grt/flk,blank)_RIGHT_(...).mat
        pattern_str = ['16PxWind_' px_str '_' l_str '_' r_str];
        
        Pats = dummy_frame;
        
        % Mask out extra rows and columns
        left_cols = pattern_windows{1};
        right_cols = pattern_windows{2};
        horiz_cols = pattern_windows{3};

        % Shift the patterns so they make sense... conditionally
        % disp(pattern_str);
        for ps = {'left','right'}
            for i = 1:size(pat.(ps{1}),3)            
                if stripe_size == 2
                    pat.(ps{1})(:,:,i) = circshift(pat.(ps{1})(:,:,i),[stripe_size/2 stripe_size/2]);
                elseif stripe_size == 4
                    pat.(ps{1})(:,:,i) = circshift(pat.(ps{1})(:,:,i),[-stripe_size-2 stripe_size+2]);
                elseif stripe_size == 6
                    if ps{1}(1) == 'l'
                        pat.(ps{1})(:,:,i) = circshift(pat.(ps{1})(:,:,i),[1 stripe_size+1]);
                    elseif ps{1}(1) == 'r'
                        pat.(ps{1})(:,:,i) = circshift(pat.(ps{1})(:,:,i),[1 stripe_size-3]);
                    end
                elseif stripe_size == 8
                    pat.(ps{1})(:,:,i) = circshift(pat.(ps{1})(:,:,i),[4 stripe_size]);
                elseif stripe_size == 10
                    pat.(ps{1})(:,:,i) = circshift(pat.(ps{1})(:,:,i),[1 3]);
                elseif stripe_size == 12
                    pat.(ps{1})(:,:,i) = circshift(pat.(ps{1})(:,:,i),[10 -2]);
                elseif stripe_size == 16
                    if ps{1}(1) == 'l'
                        pat.(ps{1})(:,:,i) = circshift(pat.(ps{1})(:,:,i),[8 4+stripe_size]);
                    elseif ps{1}(1) == 'r'
                        pat.(ps{1})(:,:,i) = circshift(pat.(ps{1})(:,:,i),[8 4+stripe_size]);
                    end
                end
            end
        end
        
        if count == Inf
            clf;
            disp(count)
            disp(pattern_str)
            subplot(2,2,1)
            image(pat.left(horiz_cols,left_cols,1))
            axis off; box off
            title('Left 1')
            subplot(2,2,2)
            image(pat.right(horiz_cols,left_cols,1))
            axis off; box off
            title('Right 1')
            subplot(2,2,3)
            image(pat.left(horiz_cols,left_cols,2))
            axis off; box off
            title('Left 2')
            subplot(2,2,4)
            image(pat.right(horiz_cols,left_cols,2))
            axis off; box off
            title('Right 2')
            colormap(hot(10))
            hold all
            %pause
            'db';
        end
        
        test = 0;
        
        % Loop until both of the sides have completed
        l_loop_sz = size(pat.left,3);
        r_loop_sz = size(pat.right,3);
        if l_loop_sz > r_loop_sz
            for x = 1:l_loop_sz
                Pats(:,:,x,1) = dummy_frame;
                if test; Pats(:,:,x,1) = 10+0*dummy_frame; end
                Pats(horiz_cols,left_cols,x,1) = pat.left(horiz_cols,left_cols,x);
                Pats(horiz_cols,right_cols,x,1) = pat.right(horiz_cols,right_cols,mod(x,2)+1);
            end
        elseif r_loop_sz > l_loop_sz
            for x = 1:r_loop_sz
                Pats(:,:,x,1) = dummy_frame;
                if test; Pats(:,:,x,1) = 10+0*dummy_frame; end
                Pats(horiz_cols,left_cols,x,1) = pat.left(horiz_cols,left_cols,mod(x,2)+1);
                Pats(horiz_cols,right_cols,x,1) = pat.right(horiz_cols,right_cols,x);
            end
        elseif l_loop_sz == r_loop_sz
            for x = 1:r_loop_sz
                Pats(:,:,x,1) = dummy_frame;
                if test; Pats(:,:,x,1) = 10+0*dummy_frame; end
                Pats(horiz_cols,left_cols,x,1) = pat.left(horiz_cols,left_cols,x);
                Pats(horiz_cols,right_cols,x,1) = pat.right(horiz_cols,right_cols,x);
            end            
        end
        
        if count == Inf
            clf
            disp(count)
            disp(pattern_str)
            subplot(2,1,1)
            image(Pats(:,1:88,1,1))
            axis off; box off
            title('Frame 1')
            subplot(2,1,2)
            image(Pats(:,1:88,2,1))
            axis off; box off
            title('Frame 2')
            colormap(hot(10))
            hold all
            %pause
            'db';
        end

        Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);

        count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
    end
end
