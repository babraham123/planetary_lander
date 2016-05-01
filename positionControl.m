function Fb3 = positionControl(x, traj, consts)
%trajectory =  x,y,z,phi, dx,dy,dz,dphi, ddx,ddy,ddz,ddphi 
% K = kpx,kpy,kpz, kdx,kdy,kdz, kptheta,kpphi,kppsi, kdtheta,kdphi,kdpsi

K = consts.K;
Fb3 = consts.mass*(consts.g + traj(11) + K(6)*(traj(7) - x(6)) + K(3)*(traj(3) - x(3)));%/(cos(x(4))*cos(x(5)));

end
