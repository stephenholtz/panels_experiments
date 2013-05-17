% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
%
% SLH - 2013

% All patters have strings for regexpi / sanity
% Pattern_###_16PxWind_PX_###_LEFT_(h/v_grt/flk,blank)_RIGHT_(...).mat

% Save time while testing.
testing_flag = 0;
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

% For zero padding the names properly
pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

num_rows = 32;
num_rows_rc = 4;
num_cols = 96;

% Counter for iterating the pattern names, set nonzero if appending to another experiment.
if ~exist('count','var'); 
    count = 1;
end

% Blank frame that is at the beginning of all the patterns (with row compression or not)
dummy_frame_rc = mid_gs_value*ones(num_rows_rc,96);
dummy_frame = mid_gs_value*ones(num_rows,96);

base_pat_name = '';

%%-Make the 'edges' patterns-
if 1
    row_compression = 1; % The edges can be row compressed
    stripe_size = 6; % Use for 45 degree bar
    px_str = ['PX_' pad_num2str_w_zeros(stripe_size,2)];

    left_cols = 7:40; % -142.5->15, 15->142.5
    right_cols = 49:82; % 0->142.5
    full_cols = 7:82; % -142.5->142.5

    for bar_polarity = 1:2
        if bar_polarity == 1;
            pol_str = 'off';
            pol_1 = low_gs_value;
            pol_2 = high_gs_value;
        elseif bar_polarity == 2;
            pol_str = 'on';
            pol_2 = low_gs_value;
            pol_1 = high_gs_value;
        end

        for bar_type = 1:2
            if bar_type == 1;
                clear temp_pat Pats; bar_str = 'bar';
                base_pat = [pol_1*ones(num_rows_rc,stripe_size),pol_2*ones(num_rows_rc,num_cols-stripe_size)];
                for  i = 1:num_cols
                    temp_pat(:,:,i,1) = circshift(base_pat,[0 i-1]); %#ok<*SAGROW>
                end

                % All edge sweeps go from -142.5 on to +142.5
                for side = 1:3
                    if side == 1
                        side_str = 'left';
                        for dir = 1:2
                            Pats = dummy_frame_rc;
                            if dir == 1
                                dir_str = 'prog';
                                for i = 1:numel(left_cols)+1+stripe_size
                                    Pats(:,:,i,1) = dummy_frame_rc;
                                    Pats(1:num_rows_rc,left_cols,i) = temp_pat(1:num_rows_rc,left_cols,left_cols(end)+2-i);
                                end
                            else
                                dir_str = 'reg';
                                for i = 1:numel(left_cols)+1+stripe_size
                                    Pats(:,:,i,1) = dummy_frame_rc;
                                    Pats(1:num_rows_rc,left_cols,i) = temp_pat(1:num_rows_rc,left_cols,mod(left_cols(1)-stripe_size-1+i,num_cols));
                                end
                            end
                            
                            Pats = add_dummy_frame_to_pattern(Pats,dummy_frame_rc,'x',1);
                            num_frames_str = ['NUM_FRAMES_' pad_num2str_w_zeros(size(Pats,3),3) '_'];
                            pattern_str = [num_frames_str side_str '_' dir_str '_' pol_str '_' bar_str];
                            count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
                            
                        end
                    elseif side == 2
                        side_str = 'right';
                        for dir = 1:2
                            Pats = dummy_frame_rc;
                            if dir == 1
                                dir_str = 'prog';
                                for i = 1:numel(right_cols)+1+stripe_size
                                    Pats(:,:,i,1) = dummy_frame_rc;
                                    Pats(1:num_rows_rc,right_cols,i) = temp_pat(1:num_rows_rc,right_cols,right_cols(1)-stripe_size-1+i);
                                end
                            else
                                dir_str = 'reg';
                                for i = 1:numel(right_cols)+1+stripe_size
                                    Pats(:,:,i,1) = dummy_frame_rc;
                                    Pats(1:num_rows_rc,right_cols,i) = temp_pat(1:num_rows_rc,right_cols,mod(right_cols(end)+2-i,num_cols));
                                end
                            end
                            
                            Pats = add_dummy_frame_to_pattern(Pats,dummy_frame_rc,'x',1);
                            num_frames_str = ['NUM_FRAMES_' pad_num2str_w_zeros(size(Pats,3),3) '_'];
                            pattern_str = [num_frames_str side_str '_' dir_str '_' pol_str '_' bar_str];
                            count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
                        end
                        
                    elseif side == 3
                        Pats = dummy_frame_rc;
                        side_str = 'full';
                        for i = 1:numel(full_cols)+stripe_size+1
                            Pats(:,:,i,1) = dummy_frame_rc;
                            Pats(1:num_rows_rc,full_cols,i) = temp_pat(1:num_rows_rc,full_cols,mod(full_cols(1)-stripe_size-1+i,num_cols));
                        end
                        Pats = add_dummy_frame_to_pattern(Pats,dummy_frame_rc,'x',1);
                        num_frames_str = ['NUM_FRAMES_' pad_num2str_w_zeros(size(Pats,3),3) '_'];
                        pattern_str = [num_frames_str side_str '_' pol_str '_' bar_str];
                        count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
                    end
                end

             elseif bar_type == 2;
                clear temp_pat Pats; bar_str = 'edge';
                for i = 1:num_cols+1
                    temp_pat(:,:,i,1) = [pol_1*ones(num_rows_rc,i),pol_2*ones(num_rows_rc,(num_cols+1)-i)];
                end
                for i = (num_cols+1):(num_cols+1+stripe_size)
                    temp_pat(:,:,i,1) = temp_pat(:,:,size(temp_pat,3),1);
                end
                % All edge sweeps go from -142.5 on to +142.5
                for side = 1:3
                    if side == 1
                        side_str = 'left';
                        for dir = 1:2
                            Pats = dummy_frame_rc;
                            if dir == 1
                                dir_str = 'prog';
                                for i = 1:numel(left_cols)+1
                                    Pats(:,:,i,1) = dummy_frame_rc;
                                    Pats(1:num_rows_rc,left_cols,i) = temp_pat(1:num_rows_rc,left_cols,left_cols(end)+1-i);
                                end
                                for i = size(Pats,3):(size(Pats,3)+stripe_size)
                                    Pats(:,:,i,1) = Pats(:,:,size(Pats,3),1);
                                end
                            else
                                dir_str = 'reg';
                                for i = 1:numel(left_cols)+1
                                    Pats(:,:,i,1) = dummy_frame_rc;
                                    Pats(1:num_rows_rc,left_cols,i) = temp_pat(1:num_rows_rc,left_cols,mod(left_cols(1)-2+i,num_cols));
                                end
                                for i = size(Pats,3):(size(Pats,3)+stripe_size)
                                    Pats(:,:,i,1) = Pats(:,:,size(Pats,3),1);
                                end
                            end
                            Pats = add_dummy_frame_to_pattern(Pats,dummy_frame_rc,'x',1);
                            num_frames_str = ['NUM_FRAMES_' pad_num2str_w_zeros(size(Pats,3),3) '_'];
                            pattern_str = [num_frames_str side_str '_' dir_str '_' pol_str '_' bar_str];
                            count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
                        end
                    elseif side == 2
                        side_str = 'right';
                        for dir = 1:2
                            Pats = dummy_frame_rc;
                            if dir == 1
                                dir_str = 'prog';
                                for i = 1:numel(right_cols)+1+stripe_size
                                    Pats(:,:,i,1) = dummy_frame_rc;
                                    Pats(1:num_rows_rc,right_cols,i) = temp_pat(1:num_rows_rc,right_cols,right_cols(1)-2+i);
                                end
                            else
                                dir_str = 'reg';
                                for i = 1:numel(right_cols)+1+stripe_size
                                    Pats(:,:,i,1) = dummy_frame_rc;
                                    Pats(1:num_rows_rc,right_cols,i) = temp_pat(1:num_rows_rc,right_cols,mod(right_cols(end)+1-i,num_cols));
                                end
                            end                            
                            Pats = add_dummy_frame_to_pattern(Pats,dummy_frame_rc,'x',1);
                            num_frames_str = ['NUM_FRAMES_' pad_num2str_w_zeros(size(Pats,3),3) '_'];
                            pattern_str = [num_frames_str side_str '_' pol_str '_' bar_str];
                            count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
                        end
                        
                    elseif side == 3
                        Pats = dummy_frame_rc;
                        side_str = 'full';
                        for dir = 1:2
                            Pats = dummy_frame_rc;
                            if dir == 1
                                dir_str = 'cw';
                                for i = 1:numel(full_cols)+1+stripe_size
                                    Pats(:,:,i,1) = dummy_frame_rc;
                                    Pats(1:num_rows_rc,full_cols,i) = temp_pat(1:num_rows_rc,full_cols,mod(full_cols(1)-2+i,num_cols));
                                end
                            elseif dir == 2
                                dir_str = 'ccw';
                                for i = 1:numel(full_cols)+1
                                    Pats(:,:,i,1) = dummy_frame_rc;
                                    Pats(1:num_rows_rc,full_cols,i) = temp_pat(1:num_rows_rc,full_cols,full_cols(end)+1-i);
                                end
                                for i = size(Pats,3):(size(Pats,3)+stripe_size)
                                    Pats(:,:,i,1) = Pats(:,:,size(Pats,3),1);
                                end
                            end
                            
                            Pats = add_dummy_frame_to_pattern(Pats,dummy_frame_rc,'x',1);
                            num_frames_str = ['NUM_FRAMES_' pad_num2str_w_zeros(size(Pats,3),3) '_'];
                            pattern_str = [num_frames_str side_str '_' dir_str '_' pol_str '_' bar_str];
                            count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_str,save_directory,count,testing_flag);
                        end
                    end
                end
            end
        end
    end
end
