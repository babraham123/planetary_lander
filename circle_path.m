function traj = circle_path(R,h,x0)

consts = get_consts();
tmin = consts.trange(1);
tmax = consts.trange(2);
dt = 0.1;
travel = floor(((tmax-tmin)/5)/dt)*dt
t_travel = tmin:dt:travel;
t = travel+dt:dt:tmax;

n = length(t);
Z = h*ones(1,n);
X = R*sin(t);
Y = R*cos(t);
for i = 1: length(t_travel)
x(:,i) = x0(1:3) + t_travel(i)/travel.*([X(1);Y(1);Z(1)]-x0(1:3));

end
x;
[X Y Z];
traj = [t_travel t; x [X; Y; Z]];
n = size(traj, 2);
traj = [traj; zeros(1,n)];

end
