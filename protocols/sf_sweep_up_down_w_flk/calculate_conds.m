%%-'sf_sweep_up_down_w_flk'--------------------------------------

% Flicker only
sides       = 2; % Left and right
directions  = 1; % pos
spat_freqs  = 2; % = 4 12
temp_freqs  = 2; % = 2 6
flicker     = 1; % only flicker

flicker_only_conds = (sides*directions*spat_freqs*temp_freqs*flicker);

% Motion +/- flicker
sides       = 2; % Left and right
directions  = 2; % pos / neg
spat_freqs  = 5; % = 2 4 6 8 12
temp_freqs  = 2; % = 2 6
flicker     = 2; % with and without sf matched flicker

one_side_motion_flicker = (sides*directions*spat_freqs*temp_freqs*flicker);
both_sides_motion = (sides*directions*spat_freqs*temp_freqs);

total_conds = one_side_motion_flicker + both_sides_motion + flicker_only_conds;

%%-exp_time-----------------------------------------------------------

% stimulus durations
cl_time = 2.25;% bare minimum
ol_time = 1.5; % bare minimum
slop = .12;    % from whatever

rep_in_mins = total_conds*(cl_time + ol_time + slop)/60;

num_reps = 2; % 2 might be okay, I can add a third rep to good flies...
exp_split= 1; % i.e. not split between protocols

exp_time = rep_in_mins*num_reps/exp_split

N_per_line = 14;
num_rigs = 3;
tether_time = 20;
hours_per_line = ((exp_time * exp_split * N_per_line) + tether_time) / (num_rigs * 60);