function K = calculateGains(consts)

%kpx = 0.006;
kpx = 0.012;
%kdx = 0.12;
kdx = 0.18;
kpz = 0.027;
kdz = 0.26;
kptheta = 8000;
kdtheta = 10000;
kppsi = 4000;
kdpsi = 3500;

K = [kpx,kpx,kpz, kdx,kdx,kdz, kptheta,kptheta,kppsi, kdtheta,kdtheta,kdpsi]';

end
