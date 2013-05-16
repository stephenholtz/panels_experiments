%%-'misc_prog_reg_stims'--------------------------------------

% Edges- the sweep will be from -147.5 on (to avoid strangeness) - DONE
types       = 4; % on bar 45 degs, off bar 45 degs, on edge, off edge
directions  = 3; % prog, reg (and full sweep)
sides       = 2; % left and right
temp_freqs  = 3; % 150, 225, 300 dps
edges_conds = types*directions*sides*temp_freqs;

% Block scrambled (a minimum sf = lam) - DONE
directions  = 2; % prog and reg
sides       = 3; % left right both
temp_freqs  = 3; % 3,6,12
spat_freqs  = 2; % wavelength 30,60
block_conds = directions*sides*temp_freqs*spat_freqs;

% flicker responses - DONE
sides       = 2; % left and right
windows     = 1; % normal
speeds      = 4; % slopes of triangle wave increase
flicker_conds = sides*windows*speeds;

% rev phi responses - DONE
directions  = 2; % cw,ccw
sides       = 3; % left, right, full
speeds      = 3; % slow speeds: .75,2,5
spat_freqs  = 1; % lam 60
rev_phi_conds = sides*speeds*spat_freqs*directions;

% noise and normal conds
sides = 3;      % full left right
directions = 2; % +/-
spat_freqs = 2; % 30 60
speeds = 3;     % 3,6,12
noise = 3;      % 0%, 17% and 50%
noise_normal_conds = sides*directions*spat_freqs*speeds*noise;

% flicker and motion conditions
sides = 2;      % prog and reg
directions = 2; % +/-
spat_freqs = 2; % 30 60
speeds = 3;     % 3,6,12
flicker = 2;    % 1hz and 2hz wrt motion period
flick_mot_conds = sides*directions*spat_freqs*speeds*flicker;

% unilateral flicker conditions
sides = 2;      % Lr
directions = 1; % +/-
spat_freqs = 2; % 30 60
speeds = 3;     % 3,6,12
flicker = 2;    % 1hz and 2hz wrt motion period
flick_only_conds = sides*directions*spat_freqs*speeds*flicker;

total_conds = edges_conds + block_conds + noise_normal_conds + flick_mot_conds + flick_only_conds + flicker_conds + rev_phi_conds;

ol_time = 2; % a good approximate time
cl_time = 2; % probably the minimum needed
n_reps = 2;
exp_time = n_reps*total_conds*(ol_time+cl_time)/60

%-hours_per_line---------------------------------------------

% lines: c2a,c2b,c3a,c3b,c2/3,lai,ctrla,ctrlb
N_lines = 8;

N_per_line = 14; % with 2 reps I think this has to be >10
num_rigs = 3;
tether_time = 20;
hours_per_line = ((exp_time * N_per_line) + tether_time) / (num_rigs * 60)
