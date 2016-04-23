function traj = circle_path(R,h,x0)

dt = 0.1;
travel = 8;
t_travel = 0:dt:travel;
t = travel+dt:dt:20;
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
