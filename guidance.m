function trajectory = guidance(x0, Mode)
% x = [x y z psi]
consts = get_consts();
N = 1000;
trajectory = [];

if (Mode == 'hover')
	xd = [x0(1)+0.1; x0(2)+0.1; x0(3)+0.1; x0(9)];
    xd = repmat(xd, [1, N]);
    t = linspace(consts.trange(1), consts.trange(2), N);
    trajectory = [t; xd];

elseif (Mode == 'circle')
	% trace out circle
	trajectory = circle_path(x0(1), x0(3), x0);

elseif (Mode == 'eight')
	% trace out figure eight
	trajectory = eight_path(x0(1), x0(3), x0);

else
	disp('Unknown guidance algorithm selected!');
end


end
