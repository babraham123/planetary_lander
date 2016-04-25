function U = geomControl(x,traj,consts,K,theta_d,phi_d,omega)
% x    = x,y,z, vx,vy,vz, phi,tehta,psi, dphi,dtheta,dpsi
% traj = x,y,z,psi, vx,vy,vz,dpsi, ax,ay,az,ddpsi
% K = kpx,kpy,kpz, kdx,kdy,kdz, kpphi,kptheta,kppsi, kdphi,kdtheta,kdpsi
%desired Om and OmDot are assumed to be 0
%U = u1 (body z force) u2 (body torques)

%Rotational States
eulerAngles = x(7:9);
R = eulerToRot(eulerAngles);
Rd = eulerToRot([traj(4); theta_d,phi_d]);
omega_d = 0*omega;
domega_d = 0*omega;
a3 = [0;0;1];
b3 = R*a3;


%calculating errors
eo = omega_d-omega;
er = 0.5*unSkew(Rd'*R-R'*Rd); 
ep = traj(1:3)-x(1:3);
ev = traj(5:8) - x(4:6);

gains;
Kp = K(1:3);
Kd = K(4:6);
kr = K(7:9);
ko = K(10:12);

u1 = mass*b3'*(a_d + Kd*ev + Kp*ep + g*a3); 
%Multirotor Aerial Vehicles (31)
u2 = I*(-kr*er-ko*eo) + cross(omega,consts.I*omega) - consts.I*(cross(omega,R'*Rd*omega_d)-R'*Rd*domega_d); 
%Multirotor Aerial Vehicles (27)

U = [u1;u2];
