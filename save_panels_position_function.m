function count = save_panels_position_function(save_directory,function_name,func,counter) %#ok<*INUSL>
    
    temp = regexpi(function_name,'\position_function','split');
    
    if numel(num2str(counter)) < 2
        count = ['00' num2str(counter)];
    elseif numel(num2str(counter)) < 3
        count = ['0' num2str(counter)];        
    else
        count = num2str(counter);
    end
    
    function_name = ['position_function' '_' count '_' temp{end}];
    file_name = fullfile(save_directory,function_name);
    
    if ~isdir(save_directory)
        mkdir(save_directory)
    end
    
    save(file_name, 'func');
    disp(function_name);
    
    count = counter + 1;
    
end