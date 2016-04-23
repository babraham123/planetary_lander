function trajectory = guidance(x0, Mode)
% x = [x y z psi]
consts = get_consts();
N = 1000;
x0 = x0(:);
trajectory = [];

if (Mode == 'hover')
	x0 = [x0(1); x0(2); x0(3); x0(9)];
    xd = repmat(x0, 2, N);
    t = linspace(consts.trange(1), consts.trange(2), N);
    trajectory = [t; xd];

elseif (Mode == 'circle')
	% trace out circle
	trajectory = circle_path(x0(1), x0(3), x0);

elseif (Mode == 'eight')
	% trace out figure eight
	trajectory = 8_path(x0(1), x0(3), x0);
end



end
