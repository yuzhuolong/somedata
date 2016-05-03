%% set_system_opt
%   -- TARGET_DIR, DEFAULT_NAME;
%   -- AUDIOFILES_HOMEDIR, MAX_AUDIOFILE_LENGTH, MIN_AUDIOFILE_LENGTH, 
%      MAX_SAMPLES_COUNT, SEGMENT_LENGTH;
%   -- K_GMM, MAX_ITERATION_COUNT, THREHOLD
%   -- WIN_TIME_WIDTH, STEP_TIME

function system_options = setSystemOptions()
%% Param about WEKA..
system_options.TARGET_DIR = 'C:\Users\jqrghs\Desktop\PMC实验\Matlab源码 最新版\Matlab源码/';
system_options.DEFAULT_NAME = 'default';

%% Param about AUDIO files..
system_options.AUDIOFILES_HOMEDIR = 'D:/My Papers/WASA2016/hzq/Incar/';
system_options.MAX_AUDIOFILE_LENGTH = 9; % Length of audiofiles should NOT EXCEED 20s..
system_options.MIN_AUDIOFILE_LENGTH = 9; % And shoud be MORE than 10s..
system_options.SEGMENT_LENGTH = 1; % Length of each segment..
system_options.MAX_SAMPLES_COUNT = 100000;
system_options.DICE = 0.5;
system_options.DOWN_SAMPLING_CNT = 10;

system_options.ENABLE_LOG_FILE = 1;
system_options.ENABLE_DEBUG = 0;



%% Params about GMM..
system_options.K_GMM = 3;
system_options.MAX_ITERATION_COUNT = 1000;
system_options.THREHOLD = 1e-6;

%% Params about SEGMENTS..
% Pt window..
system_options.WIN_WIDTH = 20;
system_options.OVERLAP_RATIO = 0.6;
% Time window..
system_options.WIN_TIME_WIDTH = 0.032;
system_options.STEP_TIME = 0.016;

end
