function traj = eight_path(R, h, x0, consts)

tmin = consts.trange(1);
tmax = consts.trange(2);
dt = 0.1;
travel = floor(((tmax-tmin)/5)/dt)*dt; %20% of the time is getting to path
t_travel = tmin:dt:travel;
t = travel+dt:dt:tmax;

n = length(t);
Z = h*ones(1,n);
X = R*sin(0.15*(t-travel));
Y = -R*sin(2*0.15*(t-travel));

for i = 1: length(t_travel)
x(:,i) = x0(1:3) + t_travel(i)/travel.*([X(1);Y(1);Z(1)]-x0(1:3))*sin(t_travel(i)*pi/(2*travel));

end
temp = [x [X; Y; Z]];
tempx = smooth(temp(1,:));
tempy = smooth(temp(2,:));
tempz = smooth(temp(3,:));
% size(temp)
% size(tempx')
% size(tempy')
% size(tempz')
% size([t_travel, t])
traj = [t_travel t; tempx'; tempy'; tempz'];
n = size(traj, 2);
traj = [traj; zeros(1,n)];
end