% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
% Requires the panels matlab code at flypanels.org.
%
% unilat_windowed_prog_reg_grats_w_flicker.m Will make gratings of a
% few different spatial frequencies that move up/down in the x and y chans.
% Stims will be windowed at L and R side for 120 degrees.
%
% SLH - 2013

% Save time while testing.
testing_flag = 1;
row_compression = 0;
gs_val = 2; % no need for more gs
save_directory = '/Users/stephenholtz/panels_experiments/patterns/unilat_windowed_prog_reg_grats_w_flicker';

% The size of the stripes in pixels
stripe_sizes = [4 12];

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
count = 1;

mid_gs_value = 2;
high_gs_value = 3;
low_gs_value = 0;
dummy_frame = mid_gs_value*ones(32,96);

% [ x(left)  y(right) ]
% 1 blank
% 2 flicker
% 3 bars (horizontal)
pattern_combinations = [1 2;...
                        2 1;...
                        1 3;...
                        3 1;...
                        2 3;...
                        3 2;...
                        3 3];
pattern_combination_str = {'blank','flicker','bars'};
% {[left][right][horiz]}
pattern_windows = {[5:36],[53:84],[1:32];...             %120
                   [15:26],[63:74],[11:22]};%#ok<*NBRAK> %45
pattern_window_str = {'120deg','45deg'};

for pat_wind = 1:size(pattern_windows,1)

    for pat_comb = 1:size(pattern_combinations,1)
    
        for stripe_size = stripe_sizes
        
        strp_str = [num2str(stripe_size) 'px_vert'];
        
            l_pat_type = pattern_combinations(pat_comb,1);
            r_pat_type = pattern_combinations(pat_comb,2);

            if l_pat_type == 3 || l_pat_type == 2
                l_stim_str = strp_str;
            else
                l_stim_str = '';
            end

            if r_pat_type == 3 || r_pat_type == 2
                r_stim_str = strp_str;
            else
                r_stim_str = '';
            end

            pattern_str = [ pattern_window_str{pat_wind} '_window' '_LEFT_' pattern_combination_str{l_pat_type} l_stim_str '_RIGHT_' pattern_combination_str{r_pat_type} r_stim_str];
            
            flicker_stripe_size = stripe_size;
            
            % Make pattern
            bck_pat = dummy_frame;
            
            l_pat = [];
            switch l_pat_type
                case 1
                    l_pat = dummy_frame;
                    
                case 2
                    l_pat(:,:,1) = repmat(  [high_gs_value*ones(32,flicker_stripe_size), mid_gs_value*ones(32,flicker_stripe_size),...
                                                low_gs_value*ones(32,flicker_stripe_size), mid_gs_value*ones(32,flicker_stripe_size)],1,96/(4*flicker_stripe_size));
                    l_pat(:,:,2) = repmat(  [low_gs_value*ones(32,flicker_stripe_size), mid_gs_value*ones(32,flicker_stripe_size),...
                                                high_gs_value*ones(32,flicker_stripe_size), mid_gs_value*ones(32,flicker_stripe_size)],1,96/(4*flicker_stripe_size));
                    if stripe_size == 12
                        for i = 1:size(l_pat,3)
                            l_pat(:,:,i,1) = circshift(l_pat(:,:,i,1),[0 -8]); %#ok<*SAGROW>
                        end 
                    elseif stripe_size == 4
                        for i = 1:size(l_pat,3)
                            l_pat(:,:,i,1) = circshift(l_pat(:,:,i,1),[0 -2]);
                        end
                    end
                    
                case 3
                    base_pat = repmat([low_gs_value*ones(32,stripe_size), high_gs_value*ones(32,stripe_size)],1,96/(2*stripe_size));

                    for i = 1:stripe_size*2
                        l_pat(:,:,i,1) = circshift(base_pat,[0 i-1]);
                    end
                    % Shift everything to be 'centered'
                    if stripe_size == 12
                        for i = 1:size(l_pat,3)
                            l_pat(:,:,i,1) = circshift(l_pat(:,:,i,1),[0 2]);
                        end
                    elseif stripe_size == 4
                        for i = 1:size(l_pat,3)
                            l_pat(:,:,i,1) = circshift(l_pat(:,:,i,1),[0 -2]);
                        end
                    end
                    
            end
            
            r_pat = [];
            
            switch r_pat_type
                case 1
                    r_pat = dummy_frame;
                    
                case 2
                    r_pat(:,:,1) = repmat(  [high_gs_value*ones(32,flicker_stripe_size), mid_gs_value*ones(32,flicker_stripe_size),...
                                                low_gs_value*ones(32,flicker_stripe_size), mid_gs_value*ones(32,flicker_stripe_size)],1,96/(4*flicker_stripe_size));
                    r_pat(:,:,2) = repmat(  [low_gs_value*ones(32,flicker_stripe_size), mid_gs_value*ones(32,flicker_stripe_size),...
                                                high_gs_value*ones(32,flicker_stripe_size), mid_gs_value*ones(32,flicker_stripe_size)],1,96/(4*flicker_stripe_size));
                    if stripe_size == 12
                        for i = 1:size(r_pat,3)
                            r_pat(:,:,i,1) = circshift(r_pat(:,:,i,1),[0 -10]);
                        end 
                    elseif stripe_size == 4
                        for i = 1:size(r_pat,3)
                            r_pat(:,:,i,1) = circshift(r_pat(:,:,i,1),[0 6]);
                        end
                    end
                    
                case 3
                    base_pat = repmat([low_gs_value*ones(32,stripe_size), high_gs_value*ones(32,stripe_size)],1,96/(2*stripe_size));
                    
                    for i = 1:stripe_size*2
                        r_pat(:,:,i,1) = circshift(base_pat,[0 i-1]);
                    end
                    % Shift everything to be 'centered'
                    if stripe_size == 12
                        for i = 1:size(r_pat,3)
                            r_pat(:,:,i,1) = circshift(r_pat(:,:,i,1),[0 2]);
                        end
                    elseif stripe_size == 4
                        for i = 1:size(r_pat,3)
                            r_pat(:,:,i,1) = circshift(r_pat(:,:,i,1),[0 -2]);
                        end
                    end
            end
            
            Pats = dummy_frame;
            
            left_cols = pattern_windows{pat_wind,1};
            right_cols = pattern_windows{pat_wind,2};
            horiz_cols = pattern_windows{pat_wind,3};
            
            for x = 1:size(l_pat,3)
                for y = 1:size(r_pat,3)
                    Pats(:,:,x,y) = dummy_frame;
                    Pats(horiz_cols,left_cols,x,y) = l_pat(horiz_cols,left_cols,x);
                    Pats(horiz_cols,right_cols,x,y) = r_pat(horiz_cols,right_cols,y);
                end
            end
            
%             if count
%                 image(Pats(:,1:88,1,1));
%                 colormap(hot(4))
%                 hold all
%             end

%            Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);
%            Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'y',1);
            
            count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
            
        end
    end
    
end
