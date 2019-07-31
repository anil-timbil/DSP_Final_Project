%% spectral_centroid_spatialize.m
% Anil Timbil
% July 11, 2019 
% This program takes in a dataframe of sound signals along with a mode of
% spatialization, and creates a spatialized sound for the given input
% signals based on the mode's pattern. Placement will follow the order of 
% the pattern with ascending spectral centroid values. If there are more than 
% 13 sound signals, additional azimuth/elevation pairs will be created from 
% the original pattern. Outputs can be found in the Output/Centroid file. 
% Sound signals can be passed in any order as the program will reorder them 
% based on ascending spectral centroid value. 

function spectral_centroid_spatialize(df, mode, fs, play_sound, plot_graph)
%% Fill in 0s for NaNs & add spectral centroid value to the last row
[row_num, col_num] = size(df);
for i=1:col_num
    column = df(:,i);
    signal = column(~isnan(column));
    centroid_val = nanmean(spectral_centroid(signal, length(signal), plot_graph, fs));
    df(row_num+1,i)=centroid_val;
    df(length(signal):row_num,i)=0;
end


%% Sort based on spectral centroid value
[temp, order] = sort(df(length(df),:));
df = df(:,order);


%% Create spatialized sound.
pattern = get_pattern(mode, col_num);
df(end,:) = [];
mix = zeros(length(df),2);
for i= 1:col_num
    spatial = spatial_sound(pattern(i), pattern(col_num+i), df(:,i), fs); 
    mix(:,1) = mix(:,1) + spatial(:,1);
    mix(:,2) = mix(:,2) + spatial(:,2);
end

mix(:,1) = mix(:,1) / max(-min(mix(:,1)), max(mix(:,1)));
mix(:,2) = mix(:,2) / max(-min(mix(:,2)), max(mix(:,2)));

% plot graph
if plot_graph==true
    plot(mix);
end

% play sound array
if play_sound==true
    play_sound_array(mix,fs);
end

audiowrite(char(strcat("Output/Centroid/",mode,".wav")), mix, fs);

end