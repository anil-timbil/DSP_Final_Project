%% spatialization_experience.m
% Anil Timbil
% June 22, 2019 
% This program provides an overview of how we can spatilize sound in the
% context of acapella music. Taking different 'modes' of spatialization,
% this program places 13 sounds at different spots following the
% definitions of modes, and serves as a tool to help us experience
% tiny nuances at a significant level. This file uses a predetermined list
% of sound files from Co Co Beaux's Tupelo Honey song with the soloist to
% not to overshadow the spatialization experience. 


function spatialization_experience(df, mode, fs, play_sound, plot_graph)

original=0;
if mode=="original"
    original=1;
end

%% Fill in 0s for NaNs
[row_num, col_num] = size(df);

for i=1:col_num
    column = df(:,i);
    signal = column(~isnan(column));
    df(length(signal):row_num,i)=0;
end

%% Get specialized sounds
pattern = get_pattern(mode);

mix = zeros(length(df),2);
for i= 1:col_num
    spatial = spatial_sound(pattern(i), pattern(col_num+i), df(:,i), fs, original); 
    mix(:,1) = mix(:,1) + spatial(:,1);
    mix(:,2) = mix(:,2) + spatial(:,2);
end

mix(:,1) = mix(:,1) / max(-min(mix(:,1)), max(mix(:,1)));
mix(:,2) = mix(:,2) / max(-min(mix(:,2)), max(mix(:,2)));


%{


Bass_1_spatial = spatial_sound(pattern(1), pattern(14), df(:,1), fs, original);
Bass_2_spatial = spatial_sound(pattern(2), pattern(15), df(:,2), fs, original);
Bass_3_spatial = spatial_sound(pattern(3), pattern(16), df(:,3), fs, original);
Bari_1_spatial = spatial_sound(pattern(4), pattern(17), df(:,4), fs, original);
Bari_2_spatial = spatial_sound(pattern(5), pattern(18), df(:,5), fs, original);
Bari_3_spatial = spatial_sound(pattern(6), pattern(19), df(:,6), fs, original);
Bari_4_spatial = spatial_sound(pattern(7), pattern(20), df(:,7), fs, original);
Tenor2_1_spatial = spatial_sound(pattern(8), pattern(21), df(:,8), fs, original);
Tenor2_2_spatial = spatial_sound(pattern(9), pattern(22), df(:,9), fs, original);
Tenor2_3_spatial = spatial_sound(pattern(10), pattern(23), df(:,10), fs, original);
Tenor1_1_spatial = spatial_sound(pattern(11), pattern(24), df(:,11), fs, original);
Tenor1_2_spatial = spatial_sound(pattern(12), pattern(25), df(:,12), fs, original);
Tenor1_3_spatial = spatial_sound(pattern(13), pattern(26), df(:,13), fs, original);

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

if original~=1 %if not original sound
    mix(:,2) = Bass_1_spatial(:,2)+Bass_2_spatial(:,2)+Bass_3_spatial(:,2) + ...
        Bari_1_spatial(:,2) + Bari_2_spatial(:,2) + Bari_3_spatial(:,2) + Bari_4_spatial(:,2) + ...
        Tenor1_1_spatial(:,2) + Tenor1_2_spatial(:,2) + Tenor1_3_spatial(:,2) +...
        Tenor2_1_spatial(:,2) + Tenor2_2_spatial(:,2) + Tenor2_3_spatial(:,2);
    mix(:,2) = mix(:,2) / max(-min(mix(:,2)), max(mix(:,2)));
end
%}


audiowrite(char(strcat("Output/",mode,".wav")), mix, fs);

if plot_graph==true
    plot(mix);
end
    
if play_sound==true
    play_sound_array(mix,fs);
end

audiowrite(char(strcat("Output/",mode,".wav")), mix, fs);


end