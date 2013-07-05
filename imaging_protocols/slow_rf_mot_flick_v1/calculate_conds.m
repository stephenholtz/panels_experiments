%%-'slow_rf_mot_flick_v1'-------------------------------------------------------
initial_time    = 20; % 20 seconds before any stims (with the laser on)
inter_dur       = 4;  % 4 seconds between stimuli for baseline/aftereffect calcs
num_reps        = 4;  % 5 based on flicker resp consistency this a good #

total_conds = 0;

% Monocular motion (should start with the least number of edges 'on screen')
directions  = 2; % pos / neg / up / down
spat_freqs  = 3; % 30 60 90
temp_freqs  = 2; % .25 .5;
duration    = 6; % at least 4 seconds (to get a full sweep for all conditions)
mot_time = directions*spat_freqs*temp_freqs*(duration+inter_dur)*num_reps;
total_conds = total_conds + directions*spat_freqs*temp_freqs;

% RF Bars/Edges
polarities  = 2; % ON / OFF
types       = 2; % small bar, big bar, edge
directions  = 4; % up down back front
speeds      = 1; % slow(10 dps)
duration    = 11; % ~120 degrees / 10dps
rfs_time = polarities*types*directions*speeds*(duration+inter_dur)*num_reps;
total_conds = total_conds + polarities*types*directions*speeds;

% Sub/full field flicker (all of these come after 4 seconds of mid-level gs)
locations   = 5; % Four non-overlapping quadrants of half the arena
types       = 2; % OFF(2)-ON(2)-OFF(2)-ON(2) & ON(2)-OFF(2)-ON(2)-OFF(2)
speeds      = 1; % .25Hz (each flash is 2s)
duration    = 8; % 
subflk_time = locations*types*speeds*(duration+inter_dur)*num_reps;
total_conds = total_conds + locations*types*speeds;

total_time = initial_time + mot_time + rfs_time + subflk_time;
time_in_mins = total_time/60;