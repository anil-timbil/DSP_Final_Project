%% spatialization_experience.m
% Anil Timbil
% June 22, 2019 
% This program provides an overview of how we can spatilize sound in the
% context of acapella music. Taking different 'modes' of spatialization,
% this program places sound tracks at different spots following the
% definitions of modes, and serves as a tool to help us experience
% tiny nuances at a significant level. This file uses the list of sound 
% signals that were created in the main file, and is designed to work with 
% the current order of sound signals in the dataframe. 


function spatialization_experience(df, mode, fs, play_sound, plot_graph)
%% Fill in 0s for NaNs
[row_num, col_num] = size(df);
for i=1:col_num
    column = df(:,i);
    signal = column(~isnan(column));
    df(length(signal):row_num,i)=0;
end

%% Get specialized sounds
pattern = get_pattern(mode, col_num);
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

audiowrite(char(strcat("Output/Examples/",mode,".wav")), mix, fs);

end