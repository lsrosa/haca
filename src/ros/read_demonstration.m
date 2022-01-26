function [position, velocity, effort] = read_demonstration(filename)
% READ_DEMONSTRATION    Reads rosbag recording of a demonstrations
%   [POS, VEL, EFF] = READ_DEMONSTRATION(FILENAME) reads the position,
%   velocity and effort from rosbag recording of a demonstration
%   
%   POS, VEL, EFF are AxB matrices, where A is the number of elements in
%   the position, velocity and effor (one per joint usually), and B is the
%   number of sample.

% History
%   create  -  Leandro de Souza Rosa, 26-01-2022

bag = rosbag(filename);
selected_bag = select(bag, 'topic', '/iiwa/joint_states');
messages = readMessages(selected_bag);
pos = cellfun( @(m) double(m.Position), messages, 'UniformOutput', false );
vel = cellfun( @(m) double(m.Velocity), messages, 'UniformOutput', false );
eff = cellfun( @(m) double(m.Effort), messages, 'UniformOutput', false );

position = cell2mat(pos');
velocity = cell2mat(vel');
effort = cell2mat(eff');

end

