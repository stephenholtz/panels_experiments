%%-'sf_tf_dir_mot_sweep'--------------------------------------

% Monocular Motion
sides       = 2; % Left and right
directions  = 2; % pos / neg
spat_freqs  = 5; % 15 30 45 60 90
temp_freqs  = 4; % .5 2 6 14;
flicker     = 2; % with and without sf/tf matched flicker
one_side_motion_flicker = (sides*directions*spat_freqs*temp_freqs*flicker);

% Binocular Motion
sides       = 1; % Left and right
directions  = 2; % pos / neg
spat_freqs  = 5; % 15 30 45 60 90
temp_freqs  = 4; % .5 2 6 14;
both_sides_motion = (sides*directions*spat_freqs*temp_freqs);

% Flicker
sides       = 2; % Left and right
directions  = 1; % just one 'flicker'
spat_freqs  = 3+1; % 15 30 60 (or full field flicker)
temp_freqs  = 4; % .5 2 6 14;
flicker_only = (sides*directions*spat_freqs*temp_freqs);

total_conds = one_side_motion_flicker + both_sides_motion + flicker_only;

cond_dur = 2.25 + 1.65; % OL and CL portions
num_reps = 2;
rep_in_mins = total_conds*cond_dur/60;
exp_time = 1.05*rep_in_mins*num_reps;

N_per_line = 14; % my slop included (this - ~3 is probably the real goal)
num_rigs = 3;
tether_time = 20;
hours_per_line = ((exp_time * N_per_line) + tether_time) / (num_rigs * 60);

fprintf('Exp Time: %0.2d mins.\nLine Time: %0.2d hours.\n',exp_time,hours_per_line);

% Note:
% Full field flicker + motion will have to wait for another time if the
% results are compelling.
