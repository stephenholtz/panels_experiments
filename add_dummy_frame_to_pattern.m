function pattern_out = add_dummy_frame_to_pattern(pattern,dummy_frame,channel,num_frames)
% Just adds a blank frame(s) to the beginning of the pattern. 

    %dummy_frame = repmat(dummy_frame,[1 1 size(pattern,3) size(pattern,4)]);

    switch channel
        case {3,'x'}
            temp_pattern = pattern;
            clear pattern

            for i = 1:size(temp_pattern,4)

                dummy_frame(:,:,(1+num_frames):size(temp_pattern,3)+num_frames,:) = temp_pattern(:,:,:,i);

                pattern_out(:,:,:,i) = dummy_frame; %#ok<*AGROW>

            end
        case {4,'y'}

            temp_pattern = pattern;
            clear pattern

            for i = 1:size(temp_pattern,3)
                
                dummy_frame(:,:,:,(1+num_frames):size(temp_pattern,4)+num_frames) = temp_pattern(:,:,i,:);
                
                pattern_out(:,:,i,:) = dummy_frame;

            end
        otherwise
            error('channel_dim must be 3,''x'',4, or ''y''')
    end
            
end