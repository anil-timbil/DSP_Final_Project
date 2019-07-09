%% orchestra_seating.m
% Anil Timbil
% June 22, 2019 
% This program ...


function correlated_parts(mode)

original=0;

if mode=="original"
    original=1;
    pattern = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; %placeholder

elseif mode == "arc_1"
    pattern = [11 13 15 6 8 18 20 2 23 24 3 4 22 8 8 8 8 8 8 8 8 8 8 8 8 8]; % acapella arc - directly ahead
elseif mode == "arc_2"
    pattern = [11 13 15 6 8 18 20 2 23 24 3 4 22 40 40 40 40 40 40 40 40 40 40 40 40 40]; % acapella arc - directly behind
elseif mode == "arc_3"
    pattern = [11 13 15 6 8 18 20 2 23 24 3 4 22 24 24 24 19 19 19 19 8 8 8 13 13 13]; % acapella arc - Varying elevations
    
elseif mode=="orc_1"
    pattern = [22 23 24 13 15 18 20 2 3 4 6 8 11 8 8 8 8 8 8 8 8 8 8 8 8 8]; % orchestra - directly ahead
elseif mode=="orc_2"
    pattern = [22 23 24 13 15 18 20 2 3 4 6 8 11 40 40 40 40 40 40 40 40 40 40 40 40 40]; % orchestra - directly behind
elseif mode=="orc_3"
    pattern = [22 23 24 13 15 18 20 2 3 4 6 8 11 24 24 24 19 19 19 19 8 8 8 13 13 13]; % orchestra - Varying elevations
    
elseif mode == "double_arc_1"
    pattern = [11 13 15 6 8 18 20 7 10 19 12 14 16 8 8 8 8 8 8 8 8 8 8 8 8 8]; % acapella arc - directly ahead
elseif mode == "double_arc_2"
    pattern = [11 13 15 6 8 18 20 7 10 19 12 14 16 24 24 24 19 19 19 19 8 8 8 13 13 13]; % acapella arc - Varying elevations
    
elseif mode == "360_1"
    pattern = [20 22 23 3 4 6 8 20 22 23 3 4 6 8 8 8 40 40 40 40 40 40 40 8 8 8]; % 360 - groups spread
elseif mode == "360_2"
    pattern = [4 22 22 6 23 4 20 3 20 6 8 3 23 8 8 40 8 8 40 40 8 8 40 8 40 40]; % 360 - individuals spread
    
elseif mode == "elevation_1"
    pattern = [13 13 13 13 13 13 13 13 13 13 13 13 13 8 8 8 13 13 13 13 24 24 24 19 19 19]; % elevation - base to tenor1
elseif mode == "elevation_2"
    pattern = [13 13 13 13 13 13 13 13 13 13 13 13 13 24 24 24 19 19 19 19 8 8 8 13 13 13]; % elevation - tenor1 to base

end


%% Get specialized sounds
[Bass_1_spatial, fs] = spatial_sound(pattern(1), pattern(14), 'SoundFiles/Bass_Conor.aif', original);
[Bass_2_spatial, fs] = spatial_sound(pattern(2), pattern(15), 'SoundFiles/Bass_Josh.aif', original);
[Bass_3_spatial, fs] = spatial_sound(pattern(3), pattern(16), 'SoundFiles/Bass_Sean.aif', original);
[Bari_1_spatial, fs] = spatial_sound(pattern(4), pattern(17), 'SoundFiles/Bari_Christian.aif', original);
[Bari_2_spatial, fs] = spatial_sound(pattern(5), pattern(18), 'SoundFiles/Bari_Matt.aif', original);
[Bari_3_spatial, fs] = spatial_sound(pattern(6), pattern(19), 'SoundFiles/Bari_Morgan.aif', original);
[Bari_4_spatial, fs] = spatial_sound(pattern(7), pattern(20), 'SoundFiles/Bari_CharlieL.aif', original);
[Tenor1_1_spatial, fs] = spatial_sound(pattern(8), pattern(21), 'SoundFiles/Tenor1_Ian.aif', original);
[Tenor1_2_spatial, fs] = spatial_sound(pattern(9), pattern(22), 'SoundFiles/Tenor1_Will.aif', original);
[Tenor1_3_spatial, fs] = spatial_sound(pattern(10), pattern(23), 'SoundFiles/Tenor1_Jermaine.aif', original);
[Tenor2_1_spatial, fs] = spatial_sound(pattern(11), pattern(24), 'SoundFiles/Tenor2_CharlieG.aif', original);
[Tenor2_2_spatial, fs] = spatial_sound(pattern(12), pattern(25), 'SoundFiles/Tenor2_Anil.aif', original);
[Tenor2_3_spatial, fs] = spatial_sound(pattern(13), pattern(26), 'SoundFiles/Tenor2_Oliver.aif', original);

%% Equalize their lengths to mix them

% Max length: Determined looking at the sound files
max_len = 276*44100;

% Equalize
%Bass_1_spatial(length(Bass_1_spatial)+1:max_len,:) = 0;
%Bass_2_spatial(length(Bass_2_spatial)+1:max_len,:) = 0;
Bass_1_spatial = Bass_1_spatial(1:max_len,:)*6;
Bass_2_spatial = Bass_2_spatial(1:max_len,:)*6;
Bass_3_spatial = Bass_3_spatial(1:max_len,:)*6;
Bari_1_spatial = Bari_1_spatial(1:max_len,:)*5;
Bari_2_spatial = Bari_2_spatial(1:max_len,:)*5;
Bari_3_spatial = Bari_3_spatial(1:max_len,:)*5;
Bari_4_spatial = Bari_4_spatial(1:max_len,:)*5;
Tenor1_1_spatial = Tenor1_1_spatial(1:max_len,:)*4;
Tenor1_2_spatial = Tenor1_2_spatial(1:max_len,:)*4;
Tenor1_3_spatial = Tenor1_3_spatial(1:max_len,:)*4;
Tenor2_1_spatial = Tenor2_1_spatial(1:max_len,:)*5;
Tenor2_2_spatial = Tenor2_2_spatial(1:max_len,:)*5;
Tenor2_3_spatial = Tenor2_3_spatial(1:max_len,:)*5;

%assignin('base','Tenor2_1_spatial',Tenor2_1_spatial); 
%size(Tenor2_1_spatial)
%length(Tenor2_1_spatial)

%% Mix 

% left & right
mix(:,1) = Bass_1_spatial(:,1)+Bass_2_spatial(:,1)+Bass_3_spatial(:,1) + ...
    Bari_1_spatial(:,1) + Bari_2_spatial(:,1) + Bari_3_spatial(:,1) + Bari_4_spatial(:,1) + ...
    Tenor1_1_spatial(:,1) + Tenor1_2_spatial(:,1) + Tenor1_3_spatial(:,1) +...
    Tenor2_1_spatial(:,1) + Tenor2_2_spatial(:,1) + Tenor2_3_spatial(:,1);
mix(:,1) = mix(:,1) / max(-min(mix(:,1)), max(mix(:,1)));

if original~=1
    mix(:,2) = Bass_1_spatial(:,2)+Bass_2_spatial(:,2)+Bass_3_spatial(:,2) + ...
        Bari_1_spatial(:,2) + Bari_2_spatial(:,2) + Bari_3_spatial(:,2) + Bari_4_spatial(:,2) + ...
        Tenor1_1_spatial(:,2) + Tenor1_2_spatial(:,2) + Tenor1_3_spatial(:,2) +...
        Tenor2_1_spatial(:,2) + Tenor2_2_spatial(:,2) + Tenor2_3_spatial(:,2);
    mix(:,2) = mix(:,2) / max(-min(mix(:,2)), max(mix(:,2)));
end

plot(mix);
audiowrite(char(strcat("Output/",mode,".wav")), mix, fs);

%play_sound_array(Bass_1_spatial(44000*4:44000*7,:),fs);


end