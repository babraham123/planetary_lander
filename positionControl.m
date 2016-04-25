function Fb3 = positionControl(x, traj, consts, K)
%trajectory = x,y,z,psi, dx,dy,dz,dpsi, ddx,ddy,ddz,ddpsi 
% K = kpx,kpy,kpz, kdx,kdy,kdz, kpphi,kptheta,kppsi, kdphi,kdtheta,kdpsi

Fb3 = consts.mass*(consts.g + traj(11) + K(6)*(traj(7) - x(6)) + K(3)*(traj(3) - x(3)));

end
