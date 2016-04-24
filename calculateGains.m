function K = calculateGains(consts)

kpx = 0.006;
kdx = 0.12;
kpz = 0.027;
kdz = 0.26;
kptheta = 20000;
kdtheta = 16000;
kppsi = 4000;
kdpsi = 3500;

K = [kpx,kpx,kpz, kdx,kdx,kdz, kptheta,kptheta,kppsi, kdtheta,kdtheta,kdpsi]';

end
