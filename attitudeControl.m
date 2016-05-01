function M = attitudeControl(Fb3, x, angles_d, consts)
% K = kpx,kpy,kpz, kdx,kdy,kdz, kpphi,kptheta,kppsi, kdphi,kdtheta,kdpsi

K = consts.K;
Kp = K(7:9);
Kd = K(10:12);
angles_d = angles_d(:);
M = Kp.*(angles_d - x(7:9)) + Kd.*([0;0;0] - x(10:12));
end
