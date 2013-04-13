function [function_vector,min_pos_func_sample_rate] = make_determine_best_samp_rate_simple_looping_position_functions(spatial_freq,temporal_freq,direction,dummy_frame_flag)
% make a position function to move a pattern with a very simple vector, in
% this case determine what the best position function sampling rate is and
% return it as the second argument

% get the speed the pattern must move at in frames per second
% i.e. (loop/second)*(frames/loop) = frames/second
fps = temporal_freq*spatial_freq;

% find the minimum sampling rate to make the loop work
range_samp_rates = 1:500;
potential_step_sizes = (1/fps)*range_samp_rates;
min_pos_func_sample_rate = min(range_samp_rates((round(potential_step_sizes)==potential_step_sizes)));
step_size = (1/fps)*min_pos_func_sample_rate;

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
