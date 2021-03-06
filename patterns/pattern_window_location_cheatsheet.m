% Cheat sheet for 96 pixel arena locations
%
% all pixels are 3.75?

% Left, Right, Center 120?: used for normal 'unilateral' presentation
L_120 = 5:36;
R_120 = 53:84;
C_120 = 29:60;

C_60 = 37:52; % This is the part that is blanked out during the L/R_120 stims

% Left, right center 45 degrees
L_45 = 15:26;
R_45 = 63:74;
C_45 = 39:50;

% Left, right center 37.5 degrees
L_38 = 16:25;
R_38 = 64:73;
C_38 = 40:49;

arena_inds = @(left,right)([(left/3.75)+44+1,(right/3.75)+44, NaN, numel(((left/3.75)+44+1):((right/3.75)+44))*3.75]);
% i.e. for windows on either side of the fly (0 is the center)
% arena_inds(-135,-45)
% 
% ans =
% 
%      9    32   NaN    90
% 
% arena_inds(45,135)
% 
% ans =
% 
%     57    80   NaN    90