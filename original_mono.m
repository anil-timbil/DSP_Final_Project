
%% original_mono.m
% Anil Timbil
% July 15, 2019 
% This program takes in a dataframe of unequal length sound signals, and
% creates a mono track. The end result will be used to compare different
% modes of spatializations to the original sound which does not apply any
% spatialization.

function original_mono(df, fs, play_sound, plot_graph)
%% Fill in 0s for NaNs
[row_num, col_num] = size(df);

for i=1:col_num
    column = df(:,i);
    signal = column(~isnan(column));
    df(length(signal):row_num,i)=0;
end

%% Mix different signals into one channel.
mix = zeros(length(df),1);
for i= 1:col_num
    mix(:,1) = mix(:,1) + df(:,i);
end

mix(:,1) = mix(:,1) / max(-min(mix(:,1)), max(mix(:,1)));

% plot graph
if plot_graph==true
    plot(mix);
end
   
% play sound array
if play_sound==true
    play_sound_array(mix,fs);
end

audiowrite(char(strcat("Output/","Original",".wav")), mix, fs);


end