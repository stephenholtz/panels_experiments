%%-'misc_prog_reg_stims'--------------------------------------

% Edges- the sweep will be from -147.5 on (to avoid strangeness) - DONE
types       = 4; % on bar 45 degs, off bar 45 degs, on edge, off edge
directions  = 3; % prog, reg (and full sweep)
sides       = 2; % left and right
temp_freqs  = 3; % 150, 225, 300 dps
edges_conds = types*directions*sides*temp_freqs;

% Block scrambled (an average sf = lam)
directions  = 3; % prog and reg (and full)
sides       = 2; % left and right
temp_freqs  = 3; % 3,6,12
spat_freqs  = 2; % wavelength 30,60
block_conds = directions*sides*temp_freqs*spat_freqs;

% Normal + noise - DONE
noise       = 2; % noise 25%, noise 50%
directions  = 3; % prog and reg (and full)
sides       = 2; % left and right
temp_freqs  = 3; % 3,6,12
spat_freqs  = 2; % wavelength 30,60
noise_conds = noise*directions*sides*temp_freqs*spat_freqs;

% Normal , and + tf match flicker - DONE
directions  = 2; % prog and reg (and full)
sides       = 2; % left and right
temp_freqs  = 3; % 3,6,12
spat_freqs  = 2; % wavelength 30,60
flicker     = 3; % no flicker, tf matched flicker, and 4*tf flicker
normal_and_flick_conds = directions*sides*temp_freqs*spat_freqs*flicker;

% Full field responses 
directions  = 2; % cw,ccw
temp_freqs  = 3; % 3,6,12
spat_freqs  = 2; % wavelength 30,60
norm_full_field_conds = directions*temp_freqs*spat_freqs;

% flicker responses
sides       = 2; % left and right
windows     = 2; % very big, and normal
speeds      = 3; % slopes of triangle wave increase
flicker_conds = sides*windows*speeds;

total_conds = edges_conds + block_conds + noise_conds + normal_and_flick_conds + norm_full_field_conds + flicker_conds;

ol_time = 2; % a good approximate time
cl_time = 2.25; % probably the minimum needed
n_reps = 2;
exp_time = n_reps*total_conds*(ol_time+cl_time)/60;

%-hours_per_line---------------------------------------------

% lines: c2a,c2b,c3a,c3b,c2/3,lai,ctrla,ctrlb
N_lines = 8;

N_per_line = 14; % with 2 reps I think this has to be >10
num_rigs = 3;
tether_time = 20;
hours_per_line = ((exp_time * N_per_line) + tether_time) / (num_rigs * 60);
