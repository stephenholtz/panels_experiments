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
testing_flag = 0;
row_compression = 1;
gs_val = 3;

% Win: 'C:\panels_experiments\patterns\windowed_prog_reg_motion_lambda_60';
save_directory = mfilename('fullpath');
save_directory = fileparts(save_directory);

% The size of the stripes in pixels
stripe_sizes = 8;
num_rows = 4;
rows_used = [2 3];
% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
count = 1;

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

dummy_frame = mid_gs_value*ones(num_rows,96);
% [ x(left)  y(right) ]
% 1 blank
% 2 flicker
% 3 bars (horizontal)
% pattern_combinations = [1 2;...
%                         2 1;...
%                         1 3;...
%                         3 1;...
%                         2 3;...
%                         3 2;...
%                         3 3];
pattern_combinations = [1 2 3];
pattern_combination_str = {'LEFT','RIGHT','BOTH'};
% {[left][right][horiz]}
pattern_windows = {(29:36),(53:60),(rows_used);...          %30-60
                   (21:28),(61:68),(rows_used);...          %60-90
                   (13:20),(69:76),(rows_used);...          %90-120
                   (5:12), (77:84),(rows_used);...          %120-150
                   (21:36),(53:68),(rows_used);...          %30-90
                   (13:28),(61:76),(rows_used);...          %60-120
                   (5:20), (69:84),(rows_used);...          %90-150
                   (5:36), (53:84),(rows_used)};            %30-150
% The amount that the [left,right] windowed patterns need to be shifted
% (cw) to be symmetrical
pattern_window_shift =[4,-4;...          %30-60
                       4,-4;...          %60-90
                       4,-4;...          %90-120
                       12,-12;...        %120-150
                       0,0;...          %30-90
                       0,0;...          %60-120
                       0,0;...          %90-150
                       0,0];            %30-150
pattern_window_str = {  '30to60',...
                        '60to90',...
                        '90to120',...
                        '120to150',...
                        '30to90',...
                        '60to120',...
                        '90to150',...
                        '30to150'};

for pat_wind = 1:size(pattern_windows,1)

    for pat_comb = pattern_combinations

        for stripe_size = stripe_sizes

        strp_str = [num2str(stripe_size) 'px_vert'];

            pattern_str = [ pattern_window_str{pat_wind} '_window_' pattern_combination_str{pat_comb} '_' strp_str];

            if pat_comb == 1

                l_pat = [];
                base_pat = repmat([low_gs_value*ones(num_rows,stripe_size), high_gs_value*ones(num_rows,stripe_size)],1,96/(2*stripe_size));
                for i = 1:stripe_size*2
                    l_pat(:,:,i,1) = circshift(base_pat,[0 i-1]); %#ok<*SAGROW>
                end
                % Shift everything to be 'centered'
                for i = 1:size(l_pat,3)
                    l_pat(:,:,i,1) = circshift(l_pat(:,:,i,1),[0 pattern_window_shift(pat_wind,1)]);
                end
                
                r_pat = dummy_frame;
                
                Pats = dummy_frame;
                left_cols = pattern_windows{pat_wind,1};
                right_cols = pattern_windows{pat_wind,2};
                horiz_cols = pattern_windows{pat_wind,3};

                for x = 1:size(l_pat,3)
                    Pats(:,:,x,1) = dummy_frame;
                    Pats(horiz_cols,left_cols,x,1) = l_pat(horiz_cols,left_cols,x);
                    Pats(horiz_cols,right_cols,x,1) = r_pat(horiz_cols,right_cols,1);
                end
                
            elseif pat_comb == 2
                
                r_pat = [];
                base_pat = repmat([low_gs_value*ones(num_rows,stripe_size), high_gs_value*ones(num_rows,stripe_size)],1,96/(2*stripe_size));
                for i = 1:stripe_size*2
                    r_pat(:,:,i,1) = circshift(base_pat,[0 i-1]);
                end
                % Shift everything to be 'centered'
                for i = 1:size(r_pat,3)
                    r_pat(:,:,i,1) = circshift(r_pat(:,:,i,1),[0 pattern_window_shift(pat_wind,2)]);
                end
                
                l_pat = dummy_frame;
                
                Pats = dummy_frame;
                left_cols = pattern_windows{pat_wind,1};
                right_cols = pattern_windows{pat_wind,2};
                horiz_cols = pattern_windows{pat_wind,3};

                for x = 1:size(r_pat,3)
                    Pats(:,:,x,1) = dummy_frame;
                    Pats(horiz_cols,left_cols,x,1) = l_pat(horiz_cols,left_cols,1);
                    Pats(horiz_cols,right_cols,x,1) = r_pat(horiz_cols,right_cols,x);
                end
                
            elseif pat_comb == 3
                
                l_pat = [];
                base_pat = repmat([low_gs_value*ones(num_rows,stripe_size), high_gs_value*ones(num_rows,stripe_size)],1,96/(2*stripe_size));
                for i = 1:stripe_size*2
                    l_pat(:,:,i,1) = circshift(base_pat,[0 i-1]);
                end
                % Shift everything to be 'centered'
                for i = 1:size(l_pat,3)
                    l_pat(:,:,i,1) = circshift(l_pat(:,:,i,1),[0 pattern_window_shift(pat_wind,1)]);
                end

                r_pat = [];
                base_pat = repmat([low_gs_value*ones(num_rows,stripe_size), high_gs_value*ones(num_rows,stripe_size)],1,96/(2*stripe_size));
                for i = 1:stripe_size*2
                    r_pat(:,:,i,1) = circshift(base_pat,[0 i-1]);
                end
                % Shift everything to be 'centered'
                for i = 1:size(r_pat,3)
                    r_pat(:,:,i,1) = circshift(r_pat(:,:,i,1),[0 pattern_window_shift(pat_wind,2)]);
                end
                
                Pats = dummy_frame;
                left_cols = pattern_windows{pat_wind,1};
                right_cols = pattern_windows{pat_wind,2};
                horiz_cols = pattern_windows{pat_wind,3};

                for x = 1:size(l_pat,3)
                    Pats(:,:,x,1) = dummy_frame;
                    Pats(horiz_cols,left_cols,x,1) = l_pat(horiz_cols,left_cols,x);
                    Pats(horiz_cols,right_cols,x,1) = r_pat(horiz_cols,right_cols,x);
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
