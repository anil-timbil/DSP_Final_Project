%%  spatial_sound.m
% Anil Timbil
% June 22, 2019 
% This program takes in an original sound array and outputs a 3D spatial 
% sound for a given azimuth & elevation value. It places a sound
% source relative to position of listener. 

% The function is customized from a 1998 study published by CIPIC Interface
% Laboratory at University of California. This study provides a set of
% HRIR data measured from a large group of subjecs. Interpolation will
% not be required due to availability of measured HRIR data. 
% Copyright (C) 2001 The Regents of the University of California

% Azimuth angles did not have equidistant sampling and had the pattern of
% the following vector: [-80 -65 -55 -45:5:45 55 65 80]
% Elevations range from -45 degree to 230.625 degrees in steps of 6.625
% degrees, following the pattern of [-45:6.625:230.625]. 
% There are 25 azimuths and 50 elevations in total, and we use the index 
% of the vectors above to get the corresponding value. 

% Changes in azimuth can be detected easily through use of headphones,
% however changes in elevation are more difficult to detect. Subject 12
% was chosen for this program since it provided a larger range for output
% of sound samples. 


function [y,f] = spatial_sound(Ia, IndE, file_name, original)

%% Pass in audio file to be spatialized
[Insig, fs] = audioread(file_name);

if original==1
    y = Insig;
    f = fs;
    return
end

Insig = Insig';
Insig = Insig(1, 1:end);

%% Specify azimuth & elevation index
%%Ia = 1 %1-25
%%IndE = 50 %1-50
hrir_l = evalin('base', 'hrir_l');
hrir_r = evalin('base', 'hrir_r');
hl = hrir_l(Ia,IndE,:);
hr = hrir_r(Ia,IndE,:);

%% Apply spatialization through hrir data
Lsig  = length(Insig);
[N,L] = size(hl);
out   = zeros(N*Lsig,2);
ramp  = ones(size(Insig));
hann  = hanning(round(.05*fs));
ramp(1:round(0.025*fs)) = hann(1:round(0.025*fs));
ramp(end-round(0.025*fs)+1:end) = hann(round(0.025*fs):end);
Insig = Insig.*ramp;

for i = 1:N,
   out(((i-1)*Lsig+1):(i*Lsig),1) = filter(hl(i,:),1,Insig)';
   out(((i-1)*Lsig+1):(i*Lsig),2) = filter(hr(i,:),1,Insig)';
end;

%% Output spatialized sound
max_val = 1.05*max(max(abs(out)));
out = out/max_val;                 % scale
%play_sound_array(out,fs);
y = out;
f = fs;
end
