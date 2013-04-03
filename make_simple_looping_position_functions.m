function function_vector = make_simple_looping_position_functions(spatial_freq,temporal_freq,pos_func_samp_freq,dummy_frame_flag)
% make a position function to move a pattern with a very simple vector,
% will warn if the speed to use is not exact.

% get the speed the pattern must move at in frames per second
% i.e. (loop/second)*(frames/loop) = frames/second
fps = temporal_freq*spatial_freq;

% calculate the step size
% (frames/second)^-1 * (samples/second) = (samples/frame)
step_size = (1/fps)*pos_func_samp_freq;
if step_size ~= ceil(step_size)
    warning('Speed not exact!')
    step_size = ceil(step_size);
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

end
