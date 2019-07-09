%% main.m
% Anil Timbil
% June 22, 2019 
% This program ...

%% Read in HRIR data from subject 12
file = load('-mat', 'Subjects/subject_012/hrir_final.mat');

%% Read in sound files

%% Create new variables in the base workspace from those fields.
vars = fieldnames(file);
for i = 1:length(vars)
    assignin('base', vars{i}, file.(vars{i}));
end

%% Hear example spatializations
wtbar = waitbar(0, 'Creating example spatialization...','Name', 'Evaluating Sound Files...');

% list of parameters: "original", "arc_1", "arc_2", "arc_3", "orc_1", "orc_2", "orc_3",
% "double_arc_1", "double_arc_2", "360_1", "360_2", "elevation_1", "elevation_2"
correlated_parts("arc_1");

close(wtbar);

%% Spatialize sounds based on Spectral Centroid