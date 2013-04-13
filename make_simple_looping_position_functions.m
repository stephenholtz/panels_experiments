function [function_vector,actual_temp_freq] = make_simple_looping_position_functions(spatial_freq,temporal_freq,pos_func_samp_freq,direction,dummy_frame_flag)
% make a position function to move a pattern with a very simple vector,
% will warn if the speed to use is not exact.

% get the speed the pattern must move at in frames per second
% i.e. (loop/second)*(frames/loop) = frames/second
fps = temporal_freq*spatial_freq;

% calculate the step size
% (frames/second)^-1 * (samples/second) = (samples/frame)
step_size = (1/fps)*pos_func_samp_freq;
if step_size ~= ceil(step_size)
    
    if abs(ceil(step_size)-step_size) < abs(floor(step_size)-step_size)
        step_size = ceil(step_size);
    elseif floor(step_size) ~= 0
        step_size = floor(step_size);
    else
        step_size = ceil(step_size);
    end
    
    actual_temp_freq = pos_func_samp_freq/(step_size*spatial_freq);
    warning(['Speed not exact. Ideal: ' num2str(temporal_freq) ' Actual: ' num2str(actual_temp_freq) '.' ])
else
    actual_temp_freq = temporal_freq;
end

function_vector = [];

for step = 1:spatial_freq
    function_vector = [function_vector repmat(step,1,step_size)]; %#ok<*AGROW>
end

% If there is a dummy frame, then the zeroth index should not be indexed
% into, otherwise, this is a frame that is needed, and the steps are all
% one index position too large.
if ~exist('dummy_frame_flag','var') && ~dummy_frame_flag
    function_vector = function_vector - 1;
end

if direction == -1
    function_vector(step_size+1:end) = fliplr(function_vector(step_size+1:end));
end

end
