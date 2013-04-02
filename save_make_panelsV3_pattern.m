function new_count = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag)
    
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
    
    if ~exist('testing','var') && ~testing_flag
        pattern.data = Make_pattern_vector(pattern);
    end
    
    % Get the correct target directory
    switch computer
        case {'PCWIN','PCWIN64'}
            root_pattern_dir = 'C:\tethered_flight_arena_code\patterns';
        case {'MACI64'}
            root_pattern_dir = '/Users/stephenholtz/tethered_flight_arena_code/patterns';
        otherwise
            error('is this linux?')
    end
    
    % When writing to SD card for the controller, ordering is important
    % and alphabetical.
    new_count = counter + 1;
    if numel(num2str(counter)) < 2
        count = ['00' num2str(counter)];
    elseif numel(num2str(counter)) < 3
        count = ['0' num2str(counter)];        
    else
        count = num2str(counter);        
    end
    
    pattern_name = ['Pattern_' count '_' pattern_name];
    
    if ~isdir(fullfile(root_pattern_dir,project))
        mkdir(fullfile(root_pattern_dir,project))
    end
    
    file_name = fullfile(root_pattern_dir,project,pattern_name);
    disp(file_name);
    save(file_name, 'pattern');
end