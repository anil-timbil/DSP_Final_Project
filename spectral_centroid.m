%% spectral_centroid.m
% Anil Timbil
% July 11, 2019 
% This program creates an array that represents the spectral centroid of
% the given sound signal over time. The following resources were used in
% order to write up the logic in this module.
% 1:https://ccrma.stanford.edu/~unjung/AIR/areaExam.pdf
% 2:https://www.cs.cmu.edu/~music/icm/slides/05-algorithmic-composition.pdf

function y = spectral_centroid(signal, duration, graph_included, fs)
% signal: pass one of the singing parts
% duration: In samples 
% graph_included: true for a spectral centroid graph over time. false otherwise
% fs: 44100 at which our sound files are recorded

%extract a portion
sample = signal(1:duration);

%Spectrum
fft_size = 2^12;
noverlap = floor(fft_size/1.1);
[S, F, T] = spectrogram( sample, hanning(fft_size), noverlap, fft_size, fs );
S = abs(S);

% Create the spectral centroid array
centroid = zeros(length(T),1);
for i = 1:length(T)
    value_1 = sum(S(1:end,i).*F);
    value_2 = sum(S(1:end,i));
    centroid(i) = value_1/value_2;
end

% plot graph
if graph_included
    figure(1);
    plot(centroid);
end

y = centroid;
    
end