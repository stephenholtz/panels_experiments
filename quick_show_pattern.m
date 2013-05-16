function pat_figure = quick_show_pattern(fps,x_vector,y_vector,pattern)
    if ~exist('pattern','var')
        [file,filedir]=uigetfile;
        % errors if no file selected, whatever
        load(fullfile(filedir,file));
        if ~exist('pattern','var')
            error('not a valid pattern file')
        end
    end
    if exist('x_vector','var') && ~exist('y_vector','var')
        y_vector = ones(1,numel(x_vector));
    end
    if (~exist('x_vector','var') && ~exist('y_vector','var')) || (isnan(x_vector(1)) && isnan(y_vector(1)))
        x_vector = repmat(1:pattern.x_num,1,1);
        y_vector = ones(1,numel(x_vector));
    end
    
    if numel(x_vector) ~= numel(y_vector)
        error('x and y vector need to have the same number of elements')
    end
    
    if ~exist('fps','var')
        pause_amt = .125;
    else
        pause_amt = 1/fps;
    end
    
    switch pattern.gs_val
        case 1
            cmap = [0 0 0; 0 1 0];
        otherwise
            cmap = [zeros(pattern.gs_val^2,1), linspace(0,1,pattern.gs_val^2)', zeros(pattern.gs_val^2,1)];
    end
    
    pat_figure = figure('Color',[0 0 0],'Position',[200 200 900 300],'Colormap',cmap,'Name','Pattern Preview','NumberTitle','off');
    subplot('Position',[0 0 1 1])
    colormap(cmap);

    for i = 1:numel(x_vector)
        frame = pattern.Pats(:,:,x_vector(i),y_vector(i));
        image(frame); axis off;
        pause(pause_amt);
    end
end