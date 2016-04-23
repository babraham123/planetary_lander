function K = calculateGains(consts)

kpx = 20;
kdx = 400;
kpz = 90;
kdz = 850;
kptheta = 20000;
kdtheta = 16000;
kppsi = 4000;
kdpsi = 3500;

K = [kpx,kpx,kpz, kdx,kdx,kdz, kptheta,kptheta,kppsi, kdtheta,kdtheta,kdpsi]';

end
