function [position1, position2] = read_bimanual_demonstration(file_arm1, file_arm2)
% READ_DEMONSTRATION    Reads rosbag recording of a demonstrations
%   [x1, y1, z1, x2, y2, z2] = READ_DEMONSTRATION(FILE_ARM1, FILE_ARM2) 
% reads the cartesian position from rosbag recording of a demonstration
%   [POSITION1, POSITION2] are AxB matrices, where A is the dimentions of
%   the pose (3) and B is the number of samples.
%
% History
%   create  -  Leandro de Souza Rosa, 23-03-2022
% TODO: get timestamps

bag1 = rosbag(file_arm1);
selected_bag1 = select(bag1, 'topic', '/cartesian_pose_left');
messages1 = readMessages(selected_bag1);
pos1 = cellfun( @(m) double([m.Pose.Position.X; m.Pose.Position.Y; m.Pose.Position.Z]), messages1, 'UniformOutput', false );
position1 = cell2mat(pos1');

bag2 = rosbag(file_arm2);
selected_bag2 = select(bag2, 'topic', '/cartesian_pose_right');
messages2 = readMessages(selected_bag2);
pos2 = cellfun( @(m) double([m.Pose.Position.X; m.Pose.Position.Y; m.Pose.Position.Z]), messages2, 'UniformOutput', false );
position2 = cell2mat(pos2');

end

