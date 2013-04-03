% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
% Requires the panels matlab code at flypanels.org.
%
% 
% Make patterns for bilateral and regular velocity nulling
%       * The regular velocity nulling patterns (just like from telethon)
%       * The bilateral version of the nulling patterns from the telethon
%
% SLH - 2013

% Save time while testing.
testing_flag = 0;
row_compression = 1;
gs_val = 4;
save_directory = '/Users/stephenholtz/panels_experiments/patterns/overlaid_vel_nulling_and_bilateral_vel_nulling';

% The size of the pixels
stripe_size = 6; % same as from the telethon

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
count = 1;

% Speeds to use (not used here, for ref)
speeds = [4 16 64 128 192];
null_speed = 48;

% Contrasts (all with a mean michelson contrast of 5.5)
test_contrasts = [6 5;...
                  7 4;...
                  8 3;];
reference_contrast = [7 4];
mid_gs_value = 6; % the mean value is 5.5, so 5 or 6 is ok?)
dummy_frame = mid_gs_value*ones(4,96);

for vnt = 1:2
    if vnt == 1
        % Make them as overlaid patterns (with a dummy frame)
        vel_null_type = 'vel_null_overlaid_';
    elseif vnt == 2
        % Make them the bilateral way (with a dummy frame)
        vel_null_type = 'vel_null_bilateral_';
    end

    for test_side = 1:2

        if test_side == 1
            side_str = 'test_x';
            x_contrast = reference_contrast;
            y_contrast = test_contrasts;
        elseif test_side == 2
            side_str = 'test_y';
            x_contrast = test_contrasts;
            y_contrast = reference_contrast;    
        end
        
        Pats = [];
        
        pattern_name = [vel_null_type side_str];

        for xc_ind = 1:size(x_contrast,1)
            for yc_ind = 1:size(y_contrast,1)
                clear x_pat y_pat
                
                % Make the pattern
                for i = 1:(stripe_size*2)
                    x_pat(:,:,i,1) = repmat([x_contrast(xc_ind,1)*ones(4,stripe_size) x_contrast(xc_ind,2)*ones(4,stripe_size)],1,96/(2*stripe_size)); %#ok<*SAGROW>
                    y_pat(:,:,1,i) = repmat([y_contrast(yc_ind,1)*ones(4,stripe_size) y_contrast(yc_ind,2)*ones(4,stripe_size)],1,96/(2*stripe_size));
                end
                
                for i = 1:(stripe_size*2)
                % Shift them back 2 positions (for alignment...)
                    x_pat(:,:,i,1) = circshift(x_pat(:,:,i,1),[0 -1]);
                    y_pat(:,:,1,i) = circshift(y_pat(:,:,1,i),[0 -1]);
                end
                
                for y = 2:(stripe_size*2)
                for x = 1:(stripe_size*2)
                    x_pat(:,:,x,y) = circshift(x_pat(:,:,x,1),[0 y-1]);   
                end
                end
                
                for x = 2:(stripe_size*2)
                for y = 1:(stripe_size*2)
                    y_pat(:,:,x,y) = circshift(y_pat(:,:,1,y),[0 x-1]);
                end
                end
                
                % Either add them together, or mask them
                if vnt == 1
                    
                    Pats = x_pat + y_pat;
                    
                elseif vnt == 2
                    
                    blanking_inds = 1:96; blanking_inds(5:36) = 0;
                    blanking_inds = blanking_inds(blanking_inds~=0);

                    y_pat(:,blanking_inds,:,:) = zeros([4,64,size(y_pat,3),size(y_pat,4)]);
                    
                    blanking_inds = 1:96; blanking_inds(53:84) = 0;
                    blanking_inds = blanking_inds(blanking_inds~=0);

                    x_pat(:,blanking_inds,:,:) = zeros([4,64,size(x_pat,3),size(x_pat,4)]);
                    
                    Pats = x_pat + y_pat;
                    
                    Pats(:,[1:4 37:52 85:96],:,:) = repmat(mid_gs_value,[4,32,size(Pats,3),size(Pats,4)]);

                end
                
                % Add dummy frames (used with position functions)
                Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);
                Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'y',1);

                count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,...
                                                    [pattern_name '_x_chan_' num2str(x_contrast(xc_ind,1)) '_' num2str(x_contrast(xc_ind,2)) '_vs_y_chan_'  num2str(y_contrast(yc_ind,1)) '_' num2str(y_contrast(yc_ind,2)) '_w_dummy_frames_xy'],...
                                                    save_directory,count,testing_flag);
            end
        end
    end
end