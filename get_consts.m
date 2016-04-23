function consts = get_consts()
    % System Constants

    consts.g = 3.71;
    consts.gEarth = 9.81;

    consts.trange = [0 1];
    consts.nIter = (consts.trange(2) - consts.trange(1)) * 1000;
    consts.positionIter = (consts.trange(2) - consts.trange(1)) * 2;
    consts.attitudeIter = consts.positionIter * 5;

    consts.mass = 3300; % kg
    consts.thrusterMin = 400; % N
    consts.thrusterMax = 3060;

    consts.forceMin = [0 0 3200]';
    consts.forceMax = [2130 2130 24480]';
    consts.torqueMaxAbs = [18620 23940 10000]';
end
