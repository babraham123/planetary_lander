function U = geomControlA(x,traj,consts,phi_d,theta_d,omega)
% x    = x,y,z, vx,vy,vz, phi,tehta,psi, dphi,dtheta,dpsi
% traj = x,y,z,psi, vx,vy,vz,dpsi, ax,ay,az,ddpsi
% K = kpx,kpy,kpz, kdx,kdy,kdz, kpphi,kptheta,kppsi, kdphi,kdtheta,kdpsi
%desired Om and OmDot are assumed to be 0
%U = u1 (body z force) u2 (body torques)

K = consts.K;
mass = consts.mass;
I = consts.I;
g = consts.g;

%Rotational States
eulerAngles = x(7:9);
dAngles = x(10:12);
R = eulerToRot(eulerAngles);
Rd = eulerToRot([phi_d, theta_d, traj(4)]);
Om = eulerToOmega(eulerAngles, dAngles);
Omd = 0*Om;
dOmd = 0*Om;
a3 = [0;0;1];
b3 = R*a3;
a_d = traj(9:11);

%calculating errors
eo = Om - R'*Rd*Omd;
er = 0.5*unSkew(Rd'*R-R'*Rd);
ep = traj(1:3)-x(1:3);
ev = traj(5:7) - x(4:6);

%gains;
Kp = K(1:3);
Kd = K(4:6);
kr = K(7:9);
ko = K(10:12);
% a_d 
% Kd.*ev 
% Kp.*ep
% g*a3
b3 = [-b3(1); -b3(2); b3(3)];
%(a_d + Kd.*ev + Kp.*ep + g*a3)
u1 = mass*b3'*(a_d + Kd.*ev + Kp.*ep + g*a3); %Multirotor Aerial Vehicles (31)
%(-kr.*er-ko.*eo)
%cross(Om,I*Om) - I*(cross(Om,R'*Rd*Omd)-R'*Rd*dOmd)
u2 = (-kr.*er-ko.*eo) + cross(Om,I*Om) - I*(cross(Om,R'*Rd*Omd)-R'*Rd*dOmd); %Multirotor Aerial Vehicles (27)

U = [u1;u2];
