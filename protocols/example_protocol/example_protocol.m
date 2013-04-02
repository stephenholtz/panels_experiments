function [C,repetition_duration] = example_protocol
% Protocol to check for bar orientation behavior
% SLH - 2013

% get to the correct directory
switch computer
    case 'MACI64'
        dir = '/Users/stephenholtz/tethered_flight_arena_code/';
    otherwise
        dir = 'C:\tethered_flight_arena_code\';        
end

% gather some information
cf = pwd;
patterns = what(fullfile(dir,'patterns','bar_flicker_orientation_test_v03'));
pattern_loc = patterns.path;
patterns = patterns.mat;
pos_func_loc = fullfile(dir,'position_functions','bar_flicker_orientation_test_v03');
position_functions = what(pos_func_loc);
position_functions = position_functions.mat;
panel_cfgs_loc = fullfile(dir,'panel_configs');
panel_cfgs = what(panel_cfgs_loc);
panel_cfgs = panel_cfgs.mat;
cd(cf);

% Start a few variables for below    
cond_num = 1;
total_ol_dur = 0;
default_frequency = 200;
duration = .9;

for bar_lum = 1:2
    for flicker_type = 1:2
        for arena_loc = 1:3; 
                C.experiment(cond_num).PatternID        = bar_lum; %#ok<*AGROW>
                C.experiment(cond_num).PatternName      = patterns{bar_lum};
                C.experiment(cond_num).Gains            = [0 0 0 0];
                C.experiment(cond_num).Mode             = [4 0];
                C.experiment(cond_num).InitialPosition  = [1 1];
                C.experiment(cond_num).PosFuncLoc       = pos_func_loc;
                
                switch flicker_type
                    case 1
                        x_pos_func = arena_loc + 0;
                    case 2
                        x_pos_func = arena_loc + 3;
                end
                
                C.experiment(cond_num).PosFunctionX     = [1 x_pos_func];
                C.experiment(cond_num).FuncFreqX        = default_frequency;
                C.experiment(cond_num).PosFuncNameX     = position_functions{x_pos_func};
                C.experiment(cond_num).PosFunctionY 	= [2 0];
                C.experiment(cond_num).FuncFreqY 		= default_frequency;
                C.experiment(cond_num).PosFuncNameY     = 'null';
                C.experiment(cond_num).Duration         = duration;
                C.experiment(cond_num).note             = '';

                total_ol_dur = total_ol_dur + C.experiment(cond_num).Duration + .02;

                cond_num = cond_num + 1;

        end
    end
end

% closed loop inter-trial stimulus
C.closed_loop.PatternID      = numel(patterns); % single stripe 8 wide, same contrast as rev phi stims
C.closed_loop.PatternName    = patterns(numel(patterns));
C.closed_loop.PatternLoc     = pattern_loc;
C.closed_loop.Mode           = [1 0];
C.closed_loop.InitialPosition= [49 1];
C.closed_loop.Gains          = [-12 0 0 0]; % 12-14 seems to work pretty well, 42-48 is another regime that looks nice
C.closed_loop.PosFunctionX   = [1 0];
C.closed_loop.PosFunctionY   = [2 0];
C.closed_loop.FuncFreqY      = default_frequency;
C.closed_loop.FuncFreqX 	 = default_frequency;
C.closed_loop.PosFuncLoc     = 'none';            
C.closed_loop.PosFuncNameX   = 'none';
C.closed_loop.PosFuncNameY   = 'none';
C.closed_loop.Duration       = 3;
C.closed_loop.Voltage        = 0; % Very important.

% initial alignment stimulus
C.initial_alignment = C.closed_loop;

% Set condition parameters that are not specified (or do not change) in the telethon
% assign voltages to each condition as well.
encoded_vals = linspace(.1,9.9,numel(C.experiment));
for cond_num = 1:numel(C.experiment)
    C.experiment(cond_num).PanelCfgNum    = 1; % should be only the two center panels!
    C.experiment(cond_num).PanelCfgName   = panel_cfgs{1};
    C.experiment(cond_num).VelFunction 	  = [1 0];
	C.experiment(cond_num).VelFuncName 	  = 'none';
    C.experiment(cond_num).SpatialFreq    = 'none';    
    C.experiment(cond_num).Voltage        = encoded_vals(cond_num);
    C.experiment(cond_num).PatternLoc     = pattern_loc;
end

total_dur = total_ol_dur + numel(C.experiment)*C.closed_loop.Duration;
repetition_duration = total_dur/60;

end