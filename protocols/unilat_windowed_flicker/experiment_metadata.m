% metadata for the experiment folder

% Transgene metadata
metadata.Line               = 'gmr_48a08ad'; %'gmr_42f06_ae_01';
metadata.Sex                = 'female'; % 'male' 'female'
metadata.DoB                = '4_13_13';
metadata.HeadGlued          = '0'; % '1' '0'
metadata.Effector           = 'gal80ts_kir21'; % 'gal80ts_kir21' 'gal80ts_tnt'
metadata.temp_unshift_time  = '0.0.0';% length of time unshifted in days.hours.mins
metadata.temp_shift_time	= '0.0.0';
metadata.temp_unshifted     = 25;
metadata.temp_shifted       = 25;
metadata.temp_experiment    = 20.1;
metadata.temp_ambient       = metadata.temp_experiment;
metadata.humidity_ambient   = 60.2;
metadata.fly_tag            = '';
metadata.note               = '';

% Prevents me from messing up the light cycles, kinda.
time = 2;
switch time 
    case 1
        metadata.LightCycle = '19_11'; % 11 AM
    case 2
        metadata.LightCycle = '00_16'; %  4 PM
    case 3
        metadata.LightCycle = '04_20'; %  8 PM
    case 4
        metadata.LightCycle = '05_21'; %  9 PM
    otherwise
        metadata.LightCycle = '00_00'; % ...
end

% Don't generally change.
[~,metadata.Arena]          = system('echo %COMPUTERNAME%');    metadata.Arena = metadata.Arena(1:end-1);
[~,metadata.Experimenter]   = system('echo %USERNAME%');        metadata.Experimenter = metadata.Experimenter(1:end-1);
metadata.DateTime           = datestr(now,30);