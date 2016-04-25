function [phi_d, theta_d] = attitudePlanner(x, traj, consts, K)
% K = kpx,kpy,kpz, kdx,kdy,kdz, kpphi,kptheta,kppsi, kdphi,kdtheta,kdpsi
%trajectory = x,y,z,psi, dx,dy,dz,dpsi, ddx,ddy,ddz,ddpsi
% x    = x,y,z, vx,vy,vz, phi,theta,psi, dphi,dtheta,dpsi


ax_com = traj(9) + K(4)*(traj(5) - x(4)) + K(1)*(traj(1) - x(1));
ay_com = traj(10) + K(5)*(traj(6) - x(5)) + K(2)*(traj(2) - x(2));
% edy = traj(6) - x(5)
ey = traj(2) - x(2);
% pause
psi_d = traj(4);
phi_d = -(1/consts.g)*(ax_com*sin(psi_d) - ay_com*cos(psi_d));
theta_d = -(1/consts.g)*(ax_com*cos(psi_d) + ay_com*sin(psi_d));

[ey, ay_com, phi_d];

end
