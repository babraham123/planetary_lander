close all
clear
clc

format long g
format compact

%kpx = 0.006;
    kpx = 0.012*15;
    %kdx = 0.12;
    kdx = 0.18*4;
    kpz = 0.027*2;
    kdz = 0.26*1.5;
    kptheta = 8000*2;
    kdtheta = 10000*1.4;
    kppsi = 4000*.9;
    kdpsi = 3500;

xd = 20*pi/180;
%xd = 10;
dxd = 0;
dt = 1/100;

x = 0;
X = [0];
dx = 0;
dX = [0];
des = @(t) 0*t + xd;
ni = 100;
nj = 50;
T = 0:dt:ni*nj*dt;

%m = 3300 * 2.25^2/12;
m = 3300/12 * (3*2.25^2 + 4);
%m = 3300;
kp = kptheta;
kd = kdtheta;
F = [];

for i = 1:ni;
    xe = xd-x;
    dxe = dxd-dx;
    f = control(xe,dxe,kp,kd);
    F = [F,f];
    a = f/m;
    for j = 1:nj
        x = x + dx*dt + 0.5*a*dt^2;
        dx = dx + a*dt;
        X = [X;x];
        dX = [dX;dx];
    end
end

figure(1)
hold on
plot(T,X)
fplot(des,[0,ni*nj*dt])
