function trajectory = guidance(x0, Mode)
% x = [x y z psi]
%trajectory = [t x y z psi]

consts = get_consts();
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
	trajectory = circle_path(20, x0(3), x0);

elseif (Mode == 'eight')
	% trace out figure eight
	trajectory = eight_path(20, x0(3), x0);
    
elseif (Mode == 'zline')
	% trace out figure eight
	x0 = [x0(1); x0(2); x0(3); x0(4)];
    dx = (10/(N-1));
    xd = repmat(x0, [1, N]);
    xd(3,:) = [x0(3):dx:x0(3)+10];
    t = linspace(consts.trange(1), consts.trange(2), N);
    trajectory = [t; xd];
    
elseif (Mode == 'yline')
	% trace out figure eight
	x0 = [x0(1); x0(2); x0(3); x0(4)];
    dx = (10/(N-1));
    xd = repmat(x0, [1, N]);
    xd(2,:) = [x0(2):dx:x0(2)+10];
    t = linspace(consts.trange(1), consts.trange(2), N);
    trajectory = [t; xd];
    
elseif (Mode == 'xline')
	% trace out figure eight
	x0 = [x0(1); x0(2); x0(3); x0(4)];
    dx = (10/(N-1));
    xd = repmat(x0, [1, N]);
    xd(1,:) = [x0(1):dx:x0(1)+10];
    t = linspace(consts.trange(1), consts.trange(2), N);
    trajectory = [t; xd];
end



end
