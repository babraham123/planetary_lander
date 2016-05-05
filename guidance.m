function trajectory = guidance(x0, Mode, consts)
% x = [x y z psi]
%trajectory = [t x y z psi]

N = 1000;
x0 = x0(:);
trajectory = [];

if (Mode == 'hover')
    x0 = [x0(1); x0(2); x0(3); x0(4)];
    xd = repmat(x0, [1, N]);
    t = linspace(consts.trange(1), consts.trange(2), N);
    trajectory = [t; xd];

elseif (Mode == 'circl')
    % trace out circle
    trajectory = circle_path(20, x0(3), x0, consts);

elseif (Mode == 'eight')
    % trace out figure eight
    trajectory = eight_path(20, x0(3), x0, consts);
    
elseif (Mode == 'zline')
    x0 = [x0(1); x0(2); x0(3); x0(4)];
    dx = (10/(N-1));
    xd = repmat(x0, [1, N]);
    xd(3,:) = [x0(3):dx:x0(3)+10];
    t = linspace(consts.trange(1), consts.trange(2), N);
    trajectory = [t; xd];
    
elseif (Mode == 'yline')
    x0 = [x0(1); x0(2); x0(3); x0(4)];
    dx = (10/(N-1));
    xd = repmat(x0, [1, N]);
    xd(2,:) = [x0(2):dx:x0(2)+10];
    t = linspace(consts.trange(1), consts.trange(2), N);
    trajectory = [t; xd];
    
elseif (Mode == 'xline')
    x0 = [x0(1); x0(2); x0(3); x0(4)];
    dx = (10/(N-1));
    xd = repmat(x0, [1, N]);
    xd(1,:) = [x0(1):dx:x0(1)+10];
    t = linspace(consts.trange(1), consts.trange(2), N);
    trajectory = [t; xd];

elseif (Mode == 'fline')
    x0 = [x0(1); x0(2); x0(3); x0(4)];
    totdist = (consts.trange(2) - consts.trange(1))*2;
    dx = (totdist/(N-1));
    xd = repmat(x0, [1, N]);
    xd(1,:) = [x0(1):dx:x0(1)+totdist];
    xd(2,:) = [x0(2):dx:x0(2)+totdist];
    xd(3,:) = [x0(3):dx:x0(3)+totdist];
    t = linspace(consts.trange(1), consts.trange(2), N);
    trajectory = [t; xd];
end

end
