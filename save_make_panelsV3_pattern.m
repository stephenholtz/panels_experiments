function new_count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,save_directory,counter,testing_flag)

    pad_num2str_w_zeros = @(num,num_zeros)([repmat('0',1,num_zeros - numel(num2str(num))) num2str(num)]);

    % Save the pattern, populate required fields.
    pattern.Pats        = Pats;
    pattern.x_num       = size(Pats,3);
    pattern.y_num       = size(Pats,4);
    pattern.num_panels  = 48;
    pattern.gs_val      = gs_val;     % 8 levels of intensity (0-7)
    pattern.row_compression = row_compression; % so only make [ L M N O ] with L = 4 (one per panel)
    panel_id_map =                  [12  8  4 11  7  3 10  6  2  9  5  1;
                                     24 20 16 23 19 15 22 18 14 21 17 13;
                                     36 32 28 35 31 27 34 30 26 33 29 25;
                                     48 44 40 47 43 39 46 42 38 45 41 37];
    pattern.Panel_map = panel_id_map;
    pattern.BitMapIndex = process_panel_map(pattern);
    
    % This function takes almost all of the time, and is only needed if we
    % are loading the patterns to an SD card.
    if ~exist('testing','var') && ~testing_flag
        pattern.data = Make_pattern_vector(pattern);
    end
    
    % When writing to SD card for the controller, ordering is important
    % and numero-alphabetical.
    new_count = counter + 1;
    count = pad_num2str_w_zeros(counter,3);
    
    pattern_name = ['Pattern_' count '_' pattern_name];
    
    if ~isdir(save_directory)
        mkdir(save_directory)
    end
    
    file_name = fullfile(save_directory,pattern_name);
    disp(file_name);
    save(file_name, 'pattern');
end