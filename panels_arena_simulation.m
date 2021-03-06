classdef panels_arena_simulation < handle
% The most useful code I have ever written.
% 
% Needs: condition_struct w/fields , pattern location, and position
% function location if the mode of the condition struct requires it
%
% Required fields in condition_struct (if using position functions):
% condition_struct.PatternLoc
% condition_struct.PatternName
% condition_struct.Mode
% condition_struct.InitialPosition
% condition_struct.Gains
% condition_struct.Duration
% (condition_struct.FuncFreqY)
% (condition_struct.FuncFreqX)
% (condition_struct.PosFuncLoc)
% (condition_struct.PosFuncNameX)
% (condition_struct.PosFuncNameY)
%
% Example use:
% 
% % construct stim_obj, which has the fields listed in properties below
% stim_obj = panels_arena_stimulation(condition_struct);
% 
% % use the methods to make figures
% std_handle = stim_obj.MakeSimpleSpaceTimeDiagram('green')
% params_handle = stim_obj.MakeParametersPage
%
% % save the figure by passing the handles
% save_path = pwd;
% panels_arena_simulation.SaveSpaceTimeDiagram(save_path,std_handle,params_handle);
%
% % making a gif or movie is different. to make it fast, saving and creating happen at the same time
% stim_obj.MakeSaveAnimatedGif(save_path)
% stim_obj.MakeMovie('green',save_path)
%
% TODO: 
%  - Fix the sampling to make it intelligent vs the high rate then downsample
%  - Make the movie saving a bit faster, and give optional text on frame
%    ranges.
%
% SLH - 2012

    properties(Constant)
        arena_display_clock = 1000; % hz
        space_time_diagram_samp_rate = 100; % fps
        movie_samp_rate = 30; % fps
        
        % number of pixels the arena is offset
        small_arena_offset = 4;
        large_arena_offset = 0;

        % degrees each pixel represents
        small_arena_pixel_size = 3.75;
        large_arena_pixel_size = 1.875;

        % the inds of columns actually displayed
        small_arena_cols = 1:88;
        large_arena_cols = 1:96;
        
        num_arena_cols = 96;
        num_arena_rows = 32;
        
        % Makes very close to standard def...
        small_arena_movie_scale_factor = 16;
        large_arena_movie_scale_factor = 2;
    end
    
    properties
        full_condition_struct
        
        % Properties set by constructor
        arena_type
        mode
        pattern
        x_function
        x_func_freq
        y_function
        y_func_freq
        gains
        initial_pos
        duration
        row_compression
        grayscale_val

        % vectors for x and y
        x_pos_vector
        y_pos_vector

        % frames that will be displayed
        stim_frames

        colormap
        
    end

    methods

%-------CONSTRUCTOR, DETERMINE STIMULUS FRAMES----------------------------%

        function obj = panels_arena_simulation(arena_type,condition_struct)

            obj.arena_type = arena_type;
            
            obj.full_condition_struct = condition_struct;
            
            obj.AddConditionProperties(condition_struct);

            obj.MakeXYPosVectors;
            
            obj.MakeStimulusFrames;
            
        end
        
        function AddConditionProperties(obj,condition_struct)

            pattern_location = fullfile(condition_struct.PatternLoc,condition_struct.PatternName);
            load(pattern_location)

            if exist('pattern','var')
                obj.pattern = pattern.Pats; %#ok<*PROP,*CPROP>
                obj.grayscale_val = pattern.gs_val; 
                try
                    obj.row_compression = pattern.row_compression;
                catch
                    obj.row_compression = 0;
                end
            else
                error('pattern from condition_struct not found')
            end

            obj.mode = condition_struct.Mode;

            obj.initial_pos = condition_struct.InitialPosition;

            obj.gains = condition_struct.Gains;

            obj.duration = condition_struct.Duration;        

            if obj.mode(1) == 4
                x_function_location = fullfile(condition_struct.PosFuncLoc,condition_struct.PosFuncNameX);
                load(x_function_location);
                if exist('func','var')
                    obj.x_function = func;
                    obj.x_func_freq = condition_struct.FuncFreqX;
                else
                    error('x position function from condition_struct not found')
                end
            else
                obj.x_function = NaN;
                obj.x_func_freq = NaN;
            end

            if obj.mode(2) == 4
                y_function_location = fullfile(condition_struct.PosFuncLoc,condition_struct.PosFuncNameY);
                load(y_function_location);
                if exist('func','var')
                    obj.y_function = func;
                    obj.y_func_freq = condition_struct.FuncFreqY;
                else
                    error('y position function from condition_struct not found')
                end
            else
                obj.y_function = NaN;
                obj.y_func_freq = NaN;
            end            
        end
        
        function MakeXYPosVectors(obj)
            
            % first find the fps required for X and Y chans
            
            % X Chan
            switch obj.mode(1)
                case 0
                    x_fps = abs(obj.gains(1)) + abs(2.5*obj.gains(2));
                    if obj.gains(1) > 0
                        x_loop = 1:size(obj.pattern,3);
                    else
                        x_loop = size(obj.pattern,3):-1:1;
                    end
                case 4
                    x_fps = obj.x_func_freq;
                    x_loop = obj.x_function+obj.initial_pos(1);
                otherwise
                    error('Unsupported mode')
            end
            
            % Y Chan
            switch obj.mode(2)
                case 0
                    y_fps = abs(obj.gains(3)) + abs(2.5*obj.gains(4));
                    if obj.gains(3) > 0
                        y_loop = 1:size(obj.pattern,4);
                    else
                        y_loop = size(obj.pattern,4):-1:1;
                    end
                    
                case 4
                    y_fps = obj.y_func_freq;
                    y_loop = obj.y_function+obj.initial_pos(2);
                otherwise
                    error('Unsupported mode')
            end
            
            % Use a 2k 'clock' to make the vectors
            obj.x_pos_vector = zeros(1,obj.arena_display_clock*obj.duration);
            obj.y_pos_vector = zeros(1,obj.arena_display_clock*obj.duration);
            
            % x chan
            
            if x_fps ~= 0 
                
                if mod(obj.arena_display_clock/x_fps,1)
                    disp('Uneven frame division in X chan')
                end
                
                loop_loc = obj.initial_pos(1);
                
                for i = 1:numel(obj.x_pos_vector)
                    
                    if ~mod(i,round(obj.arena_display_clock/x_fps))
                        loop_loc = loop_loc + 1;
                    end

                    if loop_loc > numel(x_loop)
                        loop_loc = 1;
                    end

                    obj.x_pos_vector(i) = x_loop(loop_loc);

                end
                
            else
                
                obj.x_pos_vector = repmat(obj.initial_pos(1),1,numel(obj.x_pos_vector));
                
            end
            
            % y chan
            
            if y_fps ~= 0
                
                if mod(obj.arena_display_clock/y_fps,1)
                    disp('Uneven frame division in Y chan')
                end
                
                loop_loc = obj.initial_pos(2);
                
                for i = 1:numel(obj.y_pos_vector)
                    
                    if ~mod(i,round(obj.arena_display_clock/y_fps))
                        loop_loc = loop_loc + 1;
                    end

                    if loop_loc > numel(y_loop)
                        loop_loc = 1;
                    end

                    obj.y_pos_vector(i) = y_loop(loop_loc);

                end
                
            else
                
                obj.y_pos_vector = repmat(obj.initial_pos(2),1,numel(obj.y_pos_vector));
                
            end

            
        end

        function MakeStimulusFrames(obj)

            obj.stim_frames = zeros(obj.num_arena_rows,obj.num_arena_cols,numel(obj.x_pos_vector));
            
            for curr_pos = 1:numel(obj.x_pos_vector)
                
                y_ind = obj.y_pos_vector(curr_pos);                
                x_ind = obj.x_pos_vector(curr_pos);

                % hard coded...
                if obj.row_compression
                    obj.stim_frames(:,:,curr_pos) = [   repmat(obj.pattern(1,:,x_ind,y_ind),8,1);...
                                                        repmat(obj.pattern(2,:,x_ind,y_ind),8,1);...
                                                        repmat(obj.pattern(3,:,x_ind,y_ind),8,1);...
                                                        repmat(obj.pattern(4,:,x_ind,y_ind),8,1)];
                else
                    obj.stim_frames(:,:,curr_pos) = obj.pattern(:,:,x_ind,y_ind);
                end
                
            end
        end
        
%-------OUTPUT MEDIA: DIAGRAMS, MOVIES------------------------------------%    
        
        function cmap = SetColorMap(obj,~)

         switch obj.grayscale_val
            case 1
                cmap = [0 0 0; 0 1 0];   % 2 colors - on / off
            case 2
                cmap = [0 0 0; 0 1/3 0; 0 2/3 0; 0 1 0]; % 4 levels of gscale    
            case 3
                cmap = [0 0 0; 0 2/8 0; 0 3/8 0; 0 4/8 0; 0 5/8 0; 0 6/8 0; 0 7/8 0; 0 1 0];  % 8 levels of gscale        
            case 4
                cmap = [0 0 0; 0 2/16 0; 0 3/16 0; 0 4/16 0; 0 5/16 0; 0 6/16 0; 0 7/16 0; 0 8/16 0; ...
                    0 9/16 0; 0 10/16 0; 0 11/16 0; 0 12/16 0; 0 13/16 0; 0 14/16 0; 0 15/16 0; 0 1 0];  % 16 levels of gscale        
%             case 1
%                 cmap = [0 0 0; 0 1 0];
%             otherwise
%                 cmap = [zeros(obj.grayscale_val^2,1), linspace(0,1,obj.grayscale_val^2)', zeros(obj.grayscale_val^2,1)];
         end
        
        obj.colormap = cmap;
            
        end
        
        function std_handle = MakeSimpleSpaceTimeDiagram(obj,color_mode)
            %
            obj.SetColorMap(color_mode);
            
            % preallocate a vector for the space time diagram
            samp_from_full_res_rate = (obj.arena_display_clock/obj.space_time_diagram_samp_rate);
            
             space_time_mat = zeros(size(obj.stim_frames,3)/samp_from_full_res_rate,numel(obj.([obj.arena_type '_arena_cols'])));
            
            iter = 1;
            for ind = 1:samp_from_full_res_rate:size(obj.stim_frames,3)
                space_time_mat(iter,:) = obj.stim_frames((obj.num_arena_rows/2),1:numel(obj.([obj.arena_type '_arena_cols'])),ind);
                iter = iter+1;
            end
            
            std_handle = figure('Color',[0 0 0],'Colormap',obj.colormap,'Name','Space-Time Diagram','NumberTitle','off');
            
            subplot('Position',[0 0 1 1])
            colormap(obj.colormap);
            image(space_time_mat);
%             if obj.grayscale_val == 1
%                 imagesc(space_time_mat); %imagesc does NOT work properly with the colormap
%             else
%                 image(space_time_mat); %imagesc does NOT work properly with the colormap
%             end
            axis off
            
        end

        function params_handle = MakeParametersPage(obj)

            params_handle = figure('Color',[1 1 1],'Name','Condition Parameters','NumberTitle','off');

            fields = fieldnames(obj.full_condition_struct);

            for i = 1:numel(fields)
                field_content = obj.full_condition_struct.(fields{i});
                if isnumeric(field_content);
                    field_text = num2str(field_content);
                elseif ischar(field_content)
                    field_text = field_content;
                elseif iscell(field_content)
                    if isnumeric(field_content{1});
                        field_text = num2str(field_content{1});
                    elseif ischar(field_content{1})
                        field_text = field_content{1};
                    end
                end

                figure_text{i,:} = [fields{i}, ' = ', field_text]; %#ok<*AGROW>
            end

            annotation(params_handle,'Textbox',[0 0 1 1],'String',figure_text,'Edgecolor','None','Interpreter','none')

        end            

        function MakeSaveAnimatedGif(obj,save_file_path)        
            
            % Makes a 30 fps sampling
            obj.SetColorMap('green');

            samp_from_full_res_rate = ceil(obj.arena_display_clock/obj.movie_samp_rate);
            
            inds_to_use = 1:samp_from_full_res_rate:size(obj.stim_frames,3);

            video_mat = [];
            % video_mat = zeros(obj.small_arena_movie_scale_factor*obj.num_arena_rows:

            iter = 1;
            
            for ind = inds_to_use
                % Do a reshape on each frame
                reshaped_frame = kron(obj.stim_frames(:,obj.([obj.arena_type '_arena_cols']),ind),ones(obj.([obj.arena_type '_arena_movie_scale_factor'])));
                video_mat(:,:,:,iter) = reshaped_frame;
                iter = iter + 1;
            end
            
            imwrite(video_mat, obj.colormap, [save_file_path '.gif'],'DelayTime',2,'LoopCount',inf);
            
        end
        
        function mov_handle = MakeMovie(obj,color_mode,save_file_path,varargin)
            % Makes a 30 fps video
            obj.SetColorMap(color_mode);

            samp_from_full_res_rate = ceil(obj.arena_display_clock/obj.movie_samp_rate);
            
            inds_to_use = 1:samp_from_full_res_rate:size(obj.stim_frames,3);
            
            video_mat = zeros(obj.small_arena_movie_scale_factor*obj.num_arena_rows,...
                obj.small_arena_movie_scale_factor*numel(obj.([obj.arena_type '_arena_cols'])),3,numel(inds_to_use));
            
            iter = 1;
            for ind = inds_to_use
                
                % Do a reshape on each frame
                rgb_frame = ind2rgb(obj.stim_frames(:,obj.([obj.arena_type '_arena_cols']),ind),obj.colormap);
                reshaped_frame = imresize(rgb_frame,obj.([obj.arena_type '_arena_movie_scale_factor']),'nearest');
                
                video_mat(:,:,:,iter) = reshaped_frame;
                iter = iter + 1;
            end

            mov_handle = VideoWriter(save_file_path,'Motion JPEG AVI');

            set(mov_handle,'Quality',95,'FrameRate',obj.movie_samp_rate);

            open(mov_handle)

            writeVideo(mov_handle,video_mat)

            close(mov_handle)
            
        end
        
    end
    
    methods (Static)
        
        function SaveSpaceTimeDiagram(save_file_path,std_handle,params_handle)
            
            export_fig(std_handle,save_file_path,'-pdf')

            if exist('params_handle','var') && params_handle
                export_fig(params_handle,save_file_path,'-pdf','-append')
            end
            
        end
                
    end
    
end
