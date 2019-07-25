%% main.m
% Anil Timbil
% June 22, 2019 
% This program is used to organize high level flow of the project. The user
% can choose from different modes of spatialization as well as different
% programs as described in the documentation. Important steps such as
% choosing the HRIR subject and reading in the sound files to be
% spatialized happen in this file. 

%% Change these variables to experience the different features of the program.

% programs: "original", "example", "spectral_centroid"

% modes: "arc_1", "arc_2", "arc_3", "orc_1", "orc_2", "orc_3", "double_arc_1", 
% "double_arc_2", "360_1", "360_2", "elevation_1", "elevation_2"

program = "spectral_centroid"; 
mode = "elevation_2";

play_sound=false;
plot_graph=false;


%% Read in sound files (Co Co Beaux's Tupelo Honey)
[Bass_1, fs] = audioread('SoundFiles/Bass_Conor.aif');
[Bass_2, fs] = audioread('SoundFiles/Bass_Josh.aif');
[Bass_3, fs] = audioread('SoundFiles/Bass_Sean.aif');
[Bari_1, fs] = audioread('SoundFiles/Bari_Christian.aif');
[Bari_2, fs] = audioread('SoundFiles/Bari_Matt.aif');
[Bari_3, fs] = audioread('SoundFiles/Bari_Morgan.aif');
[Bari_4, fs] = audioread('SoundFiles/Bari_CharlieL.aif');
[Tenor2_1, fs] = audioread('SoundFiles/Tenor2_CharlieG.aif');
[Tenor2_2, fs] = audioread('SoundFiles/Tenor2_Anil.aif');
[Tenor2_3, fs] = audioread('SoundFiles/Tenor2_Oliver.aif');
[Tenor1_1, fs] = audioread('SoundFiles/Tenor1_Ian.aif');
[Tenor1_2, fs] = audioread('SoundFiles/Tenor1_Will.aif');
[Tenor1_3, fs] = audioread('SoundFiles/Tenor1_Jermaine.aif');

% Create a dataframe from these sound signals
[df, binary]=padcat(Bass_1,Bass_2,Bass_2, Bari_1,Bari_2,Bari_3,Bari_4,...
            Tenor2_1,Tenor2_2,Tenor2_3,Tenor1_1,Tenor1_2,Tenor1_3);
        
        
%% Read in HRIR data from subject 12
file = load('-mat', 'Subjects/subject_012/hrir_final.mat');

% Create new variables in the base workspace from those fields.
vars = fieldnames(file);
for i = 1:length(vars)
    assignin('base', vars{i}, file.(vars{i}));
end


%% Choose the program
if program=="original"
    % Hear the original soundtracks mixed in a mono channel (Written in Output File)
    wtbar = waitbar(0, 'Mixing original sound files...','Name', 'Evaluating Sound Files...');
    original_mono(df, fs, play_sound, plot_graph); %type 'clear sound' in the command window to kill the audio at any time.
    close(wtbar);

elseif program=="example"
    % Hear spatialization Experience (Written in Output/Examples File)
    wtbar = waitbar(0, 'Creating example spatialization...','Name', 'Evaluating Sound Files...');
    spatialization_experience(df, mode, fs, play_sound, plot_graph); %type 'clear sound' in the command window to kill the audio at any time.
    close(wtbar);

elseif program=="spectral_centroid"
    % Spatialize sounds based on Spectral Centroid (Written in Output/Centroid File)
    wtbar = waitbar(0, 'Spatializing Using Spectral Centroid','Name', 'Evaluating Sound Files...');
    spectral_centroid_spatialize(df, mode, fs, play_sound, plot_graph); %type 'clear sound' in the command window to kill the audio at any time.
    close(wtbar);

else
    disp("Enter a valid program name. (Eg: example,spectral_centroid)");
end
    