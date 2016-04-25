close all
clear
clc

traj = circle_path(50,2,[0;0;0]);
[l,n] = size(traj);
time = traj(1,:);
pos = [traj(2:4,:); zeros(9,n)];
u = zeros(6,n);

traj = pos;

animate3(time,pos,traj,u)