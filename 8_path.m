function traj = 8_path(R,h,x0)
dt = 0.1;
travel = 8;
t_travel = 0:dt:travel;
t = travel+dt:dt:100;
n = length(t);
Z = h*ones(1,n);
X = R*sin(t+pi/2);
Y = R*cos(2*t);
x = x0 - t_travel/travel*([X(0) Y(0) Z(0)]);

traj = [t_travel x; t X Y Z];
end
