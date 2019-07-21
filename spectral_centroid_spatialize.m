%% spectral_centroid_spatialize.m
% Anil Timbil
% July 11, 2019 
% This program takes in a dataframe of sound signals along with a mode of
% spatialization, and creates a spatialized sound for the given input
% signals based on the mode's pattern. If the number of sound signals are
% less than 13, then it will start placing sound signals starting from
% lower singing parts to higher parts. If there are more than 13,
% additional azimuth/elevation pairs will be created from the original
% pattern. Outputs can be found in the Output/Centroid file.

function spectral_centroid_spatialize(df, mode, fs, play_sound, plot_graph)
%% Fill in 0s for NaNs & add spectral centroid value to the last row
[row_num, col_num] = size(df);
for i=1:col_num
    column = df(:,i);
    signal = column(~isnan(column));
    centroid_val = nanmean(spectral_centroid(signal, length(signal), graph_included, fs));
    df(row_num+1,i)=centroid_val;
    df(length(signal):row_num,i)=0;
end

%% Sort based on spectral centroid value
[temp, order] = sort(df(length(df),:));
df = df(:,order);


%% modify pattern if the number of soundtracks are more than 13. 
pattern = get_pattern(mode);

if col_num>length(pattern)/2 %add additional azimuth/elevations
    repetition = fix(col_num/(length(pattern)/2))-1;
    new_azimuth = pattern(1:length(pattern)/2);
    new_elevation = pattern(length(pattern)/2+1:end);
    for i=1:repetition
        new_azimuth =  horzcat(new_azimuth,pattern(1:length(pattern)/2));
        new_elevation =  horzcat(new_elevation,pattern(length(pattern)/2+1:end));
    end
    new_azimuth =  horzcat(new_azimuth,pattern(1:mod(col_num,length(pattern)/2)));
    new_elevation =  horzcat(new_elevation,pattern(length(pattern)/2+1: length(pattern)/2 + mod(col_num,length(pattern)/2)));
    pattern = horzcat(new_azimuth,new_elevation);
end

%% Create spatialized sound.
df(end,:) = [];
mix = zeros(length(df),2);
for i= 1:col_num
    spatial = spatial_sound(pattern(i), pattern(col_num+i), df(:,i), fs, original); 
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

audiowrite(char(strcat("Output/","Centroid/",mode,".wav")), mix, fs);

end