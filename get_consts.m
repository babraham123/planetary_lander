function consts = get_consts()
    % System Constants

    consts.g = 3.71; % gEarth = 9.81;

    consts.trange = [0 100];
    consts.nIter = (consts.trange(2) - consts.trange(1)) * 5000;
    consts.positionIter = (consts.trange(2) - consts.trange(1)) * 2;
    consts.attitudeIter = consts.positionIter * 5;

    consts.mass = 3300; % kg
    % consts.mass = 900 + 900 + 400; % 2200 kg
    consts.thrusterMin = 400; % N
    consts.thrusterMax = 3060;

    consts.forceMin = [0 0 3200]'; % N
    consts.forceMax = [0 0 24480]';
    consts.torqueMaxAbs = [18620 23940 10000]'; % Nm

    consts.rx = 2.25; % m
    % consts.rx = 1.5; % m
    consts.ry = 1.75;
    % consts.ry = 1.25;
    consts.h = 2;
    Ix = consts.mass*(3*(consts.rx^2) + (consts.h^2)) / 12;
    Iz = consts.mass*(consts.rx^2) / 2;
    consts.I = diag([Ix, Ix, Iz]);

    % control allocation / mixing logic
    r1 = [-consts.rx consts.ry -consts.h/2]';
    r2 = [consts.rx consts.ry -consts.h/2]';
    r3 = [-consts.rx -consts.ry -consts.h/2]';
    r4 = [consts.rx -consts.ry -consts.h/2]';

    consts.xyAngle = 0; % 45; % 0 for all y, 90 for all x
    consts.cantAngle = 25; % 0 for straight down
    fx = sind(consts.cantAngle) * cosd(consts.xyAngle);
    fy = sind(consts.cantAngle) * sind(consts.xyAngle);
    fz = cosd(consts.cantAngle);

    f1 = [fx -fy fz]';
    f1 = [f1; cross(r1, f1)];
    f2 = [-fx -fy fz]';
    f2 = [f2; cross(r2, f2)];
    f3 = [fx fy fz]';
    f3 = [f3; cross(r3, f3)];
    f4 = [-fx fy fz]';
    f4 = [f4; cross(r4, f4)];
    consts.H = [f1,f1, f2,f2, f3,f3, f4,f4];
    consts.Hinv = pinv(consts.H);

    % Set the PD control gains
    %kpx = 0.006;
    kpx = 0.012*15;
    %kdx = 0.12;
    kdx = 0.18*4;
    kpz = 0.027*2;
    kdz = 0.26*1.5;
    kptheta = 8000*2;
    kdtheta = 10000*1.4;
    kppsi = 4000*.9;
    kdpsi = 3500;

    consts.K = [kpx,kpx,kpz, kdx,kdx,kdz, kptheta,kptheta,kppsi, kdtheta,kdtheta,kdpsi]';

end
