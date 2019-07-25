%% get_pattern.m
% Anil Timbil
% July 14, 2019 
% This program returns the predefined patterns that were presented in the
% documentation. Maximum number of soundtracks is assumed to be 13.
% First 13 elements in the list are for azimuth, and the second 13 are for
% the elevation. Each number represents a degree for either azimuth or
% elevation. Please refer to Modes of Spatialization document for
% visualization of these values.

function pattern = get_pattern(mode, col_num)

if mode=="original"
    pattern = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; %placeholder

elseif mode == "arc_1"
    pattern = [11 13 15 6 8 18 20 3 4 22 2 23 24 8 8 8 8 8 8 8 8 8 8 8 8 8]; % acapella arc - directly ahead
elseif mode == "arc_2"
    pattern = [11 13 15 6 8 18 20 3 4 22 2 23 24 40 40 40 40 40 40 40 40 40 40 40 40 40]; % acapella arc - directly behind
elseif mode == "arc_3"
    pattern = [11 13 15 6 8 18 20 3 4 22 2 23 24 24 24 24 19 19 19 19 13 13 13 8 8 8]; % acapella arc - Varying elevations
    
elseif mode=="orc_1"
    pattern = [22 23 24 13 15 18 20 6 8 11 2 3 4 8 8 8 8 8 8 8 8 8 8 8 8 8]; % orchestra - directly ahead
elseif mode=="orc_2"
    pattern = [22 23 24 13 15 18 20 6 8 11 2 3 4 40 40 40 40 40 40 40 40 40 40 40 40 40]; % orchestra - directly behind
elseif mode=="orc_3"
    pattern = [22 23 24 13 15 18 20 6 8 11 2 3 4 24 24 24 19 19 19 19 13 13 13 8 8 8]; % orchestra - Varying elevations
    
elseif mode == "double_arc_1"
    pattern = [11 13 15 6 8 18 20 12 14 16 7 10 19 8 8 8 8 8 8 8 8 8 8 8 8 8]; % acapella arc - directly ahead
elseif mode == "double_arc_2"
    pattern = [11 13 15 6 8 18 20 12 14 16 7 10 19 24 24 24 19 19 19 19 13 13 13 8 8 8]; % acapella arc - Varying elevations
    
elseif mode == "360_1"
    pattern = [20 22 23 3 4 6 8  3 4 6 20 22 23 8 8 8 40 40 40 40 8 8 8 40 40 40]; % 360 - groups spread
elseif mode == "360_2"
    pattern = [4 22 22 6 23 4 20 8 3 23 3 20 6 8 8 40 8 8 40 40 8 40 40 8 8 40]; % 360 - individuals spread
    
elseif mode == "elevation_1"
    pattern = [13 13 13 13 13 13 13 13 13 13 13 13 13 8 8 8 13 13 13 13 19 19 19 24 24 24]; % elevation - base to tenor1
elseif mode == "elevation_2"
    pattern = [13 13 13 13 13 13 13 13 13 13 13 13 13 24 24 24 19 19 19 19 13 13 13 8 8 8]; % elevation - tenor1 to base
    
else
    disp("Please enter a valid pattern name. Eg: arc_1, orc_1,...");
end

%% modify pattern if the number of soundtracks are more than 13. 
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

end