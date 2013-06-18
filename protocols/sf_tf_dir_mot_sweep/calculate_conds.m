%%-'sf_tf_dir_mot_sweep'--------------------------------------

% Monocular Motion
sides       = 2; % Left and right
directions  = 2; % pos / neg
spat_freqs  = 5; % 15 30 45 60 90
temp_freqs  = 4; % .5 2 6 14;
flicker     = 2; % with and without sf matched flicker
one_side_motion_flicker = (sides*directions*spat_freqs*temp_freqs*flicker);

% Binocular Motion
sides       = 1; % Left and right
directions  = 2; % pos / neg
spat_freqs  = 5; % 15 30 45 60 90
temp_freqs  = 4; % .5 2 6 14;
flicker     = 1; % with and without sf matched flicker
both_sides_motion = (sides*directions*spat_freqs*temp_freqs*flicker);

% Flicker
sides       = 2; % Left and right
directions  = 1; % just one 'flicker'
spat_freqs  = 5; % 30 60
temp_freqs  = 4; % .5 2 6 14;
flicker     = 1; % with and without sf matched flicker
flicker_only = (sides*directions*spat_freqs*temp_freqs*flicker);

total_conds = one_side_motion_flicker + both_sides_motion + flicker_only;

cond_dur = 2.25 + 2; % OL and CL portions
num_reps = 2;
rep_in_mins = total_conds*cond_dur/60;
exp_time = rep_in_mins*num_reps;

N_per_line = 14; % my slop included
num_rigs = 3;
tether_time = 20;
hours_per_line = ((exp_time * N_per_line) + tether_time) / (num_rigs * 60);

fprintf('Exp Time: %0.2d mins.\nLine Time: %0.2d hours.\n',exp_time,hours_per_line);
