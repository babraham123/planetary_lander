function consts = get_consts()
    % System Constants

    consts.g = 3.71;
    consts.gEarth = 9.81;

    consts.trange = [0 10];
    consts.nIter = (consts.trange(2) - consts.trange(1)) * 1000;
    consts.positionIter = (consts.trange(2) - consts.trange(1)) * 2;
    consts.attitudeIter = consts.positionIter * 5;

    consts.mass = 3300; % kg
    consts.thrusterMin = 400; % N
    consts.thrusterMax = 3060;

    consts.forceMin = [0 0 3200]'; % N
    consts.forceMax = [0 0 24480]';
    consts.torqueMaxAbs = [18620 23940 10000]'; % Nm

    consts.rx = 2.25; % m
    consts.ry = 1.75;
    consts.h = 2;
    Ix = consts.mass*(3*(consts.rx^2) + (consts.h^2)) / 12;
    Iz = consts.mass*(consts.rx^2) / 2;
    consts.I = diag([Ix, Ix, Iz]);

    % mixing logic
    consts.H = eye(6);
end
