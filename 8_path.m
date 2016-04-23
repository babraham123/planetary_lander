function traj = 8_path(R,h,x0)
dt = 0.1;
travel = 8;
t_travel = 0:dt:travel;
t = travel+dt:dt:30;
n = length(t);
Z = h*ones(1,n);
X = R*sin(t+pi/2);
Y = R*cos(2*t);for i = 1:length(t_travel)
x(:,i) = x0(1:3) + t_travel(i)/travel*([X(0) Y(0) Z(0)]-x0(1:3));
end

traj = [t_travel t; x [X; Y; Z]];
end
