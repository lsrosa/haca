function [ee_poses] = compute_cartesian_ee_pose(robot,poses)
%[EE_POSES] = COMPUTE_CARTESIAN_EE_POSE(ROBOT, POSES) compute the ee pose in
%Cartesian space (xyz) given the joints pose
%    
%ROBOT is the robot's model obtained with IMPORTROBOT(URDF), where URDF is
%the robot's description file. POSES is an nxM matrix, where N is
%the number of joints and M is the number of samples

% History
%   create  -  Leandro de Souza Rosa, 02-02-2022

%showdetails(robot)

[~, n_samples] = size(poses);
ee_poses = zeros(3,n_samples); %pre-allocation

for i = 1:n_samples
    ee_poses(:,i) = tform2trvec(getTransform(robot,poses(:,i),'iiwa_link_ee'));
end

end
