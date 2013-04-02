% make a bar that flickers at a few positions around the arena with a few
% heights and widths changing in the Y chan.

clear Pats
% Project name is folder patterns live in.
project = 'bar_flicker_orientation_test_v03';

% Pattern properties needed later
row_compression = 0;
gs_val = 2;
testing_flag = 0;

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
counter = 1;

loop_vec = 0:8:88; % every col
%loop_vec = 8:32:88;

% Use the patternFactory class to make all of the patterns.
bar_factory = patternFactory('small',row_compression,gs_val);

bar_factory.SingleBar(8,'low',0,loop_vec);
bar_factory.AddDummyFrames('x',1);
Pats(:,:,:,1) = bar_factory.ReturnPatternAndParams;

pattern_name = 'dark_bar_flicker_orientation_pattern_with_dummy_x_frame';
counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);

clear Pats

% Use the patternFactory class to make all of the patterns.
bar_factory = patternFactory('small',row_compression,gs_val);

bar_factory.SingleBar(8,'high',0,loop_vec);
bar_factory.AddDummyFrames('x',1);
Pats(:,:,:,1) = bar_factory.ReturnPatternAndParams;

pattern_name = 'bright_bar_flicker_orientation_pattern_with_dummy_x_frame';
counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);

% 8 positions, 3 durations, 6 bar styles, 3 reps, time is(3.5 CL + 1.5 OL)
% (8*3)*6*3*5/60