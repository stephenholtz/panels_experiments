% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
% Requires the panels matlab code at flypanels.org.
%
% make_pats_unilat_windowed_up_down_grats_bars.m Will make gratings of a
% few different spatial frequencies that move up/down in the x and y chans.
% Stims will be windowed at L and R side for 120 degrees.
%
% SLH - 2013

% Save time while testing.
testing_flag = 1;
row_compression = 0;
gs_val = 2; % no need for more gs
save_directory = '/Users/stephenholtz/panels_experiments/patterns/unilat_windowed_up_down_grats';

% The size of the stripes in pixels
stripe_sizes = [2 4 8];

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
count = 1;

mid_gs_value = 2;
high_gs_value = 3;
low_gs_value = 1;
dummy_frame = mid_gs_value*ones(32,96);

for stim_type = 1
    
    stim_type_name = 'grat';
    
    for stripe_size = stripe_sizes

        base_pat = repmat([low_gs_value*ones(stripe_size,96); high_gs_value*ones(stripe_size,96)],32/(2*stripe_size),1);

        for stim_loc = 1:4
            
            Pats = [];
            if stim_loc == 1
                stim_str = ['full_field_' num2str(stripe_size) 'pixbar'];
            elseif stim_loc == 2
                stim_str = ['center120_' num2str(stripe_size) 'pixbar'];
            elseif stim_loc == 3
                stim_str = ['left120_' num2str(stripe_size) 'pixbar_' stim_type_name '_' 'right120_blank'];
            elseif stim_loc == 4
                stim_str = ['left120_blank' '_' 'right120_' num2str(stripe_size) 'pixbar' '_' stim_type_name];
            end
            
            if stim_loc == 1
                for i = 1:stripe_size*2
                    Pats(:,:,i,1) = circshift(base_pat,1-i); %#ok<*SAGROW>
                end
                
                Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);
                
            elseif stim_loc == 2
                for i = 1:stripe_size*2
                    Pats(:,:,i,1) = circshift(base_pat,1-i); %#ok<*SAGROW>
                end
                
                blanking_inds = 1:96; blanking_inds(29:60) = 0;
                blanking_inds = blanking_inds(blanking_inds~=0);
                
                Pats(:,blanking_inds,:,:) = mid_gs_value*ones([32,64,size(Pats,3),1]);
                
                Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);
                
            elseif stim_loc == 3
                for i = 1:stripe_size*2
                    Pats(:,:,i,1) = circshift(base_pat,1-i); %#ok<*SAGROW>
                end

                blanking_inds = 1:96; blanking_inds(53:84) = 0;
                blanking_inds = blanking_inds(blanking_inds~=0);

                Pats(:,blanking_inds,:,:) = mid_gs_value*ones([32,64,size(Pats,3),1]);
                
                Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);

            elseif stim_loc == 4
                for i = 1:stripe_size*2
                    Pats(:,:,i,1) = circshift(base_pat,1-i); %#ok<*SAGROW>
                end
                
                blanking_inds = 1:96; blanking_inds(5:36) = 0;
                blanking_inds = blanking_inds(blanking_inds~=0);
                
                Pats(:,blanking_inds,:,:) = mid_gs_value*ones([32,64,size(Pats,3),1]);
                
                Pats = add_dummy_frame_to_pattern(Pats,dummy_frame,'x',1);
                
            end
            
            count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,...
                                               stim_str,save_directory,count,testing_flag);
        end
    end
end