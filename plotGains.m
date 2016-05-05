function plotGains(ISE, MSE, T, posErr, Ft_tot, gains)
% x = x,y,z, vx,vy,vz, phi,theta,psi, dphi,dtheta,dpsi
%trajectory = x,y,z,psi, dx,dy,dz,dpsi, ddx,ddy,ddz,ddpsi 
consts = get_consts();
m = length(gains);
prefix = 'kpx,y = ';

figure;
hold on;
leg = {};
toterr = sqrt(posErr(1,:,:).^2 + posErr(2,:,:).^2 + posErr(3,:,:).^2)
for k=1:m
    plot(T, toterr(1,:,k));
    leg = [leg, { [prefix, num2str(gains(k))] }];
end
grid on;
xlabel('time (s)');
ylabel('error, m');
title('L2 Position Error');
legend(leg);
hold off;

figure;
hold on;
leg = {};
for k=1:m
    plot(T, posErr(1,:,k));
    leg = [leg, { [prefix, num2str(gains(k))] }];
end
grid on;
xlabel('time (s)');
ylabel('error, m');
title('position error in X');
legend(leg);
hold off;

figure;
hold on;
leg = {};
for k=1:m
    plot(T, posErr(2,:,k));
    leg = [leg, { [prefix, num2str(gains(k))] }];
end
grid on;
xlabel('time (s)');
ylabel('error, m');
title('position error in Y');
legend(leg);
hold off;

figure;
hold on;
leg = {};
for k=1:m
    plot(T, posErr(3,:,k));
    leg = [leg, { [prefix, num2str(gains(k))] }];
end
grid on;
xlabel('time (s)');
ylabel('error, m');
title('position error in Z');
legend(leg);
hold off;

figure;
hold on;
leg = {};
for k=1:m
    plot(T, Ft_tot(k,:));
    leg = [leg, { [prefix, num2str(gains(k))] }];
end
grid on;
xlabel('time (s)');
ylabel('total thrust, N');
title('Total thrust');
legend(leg);
hold off;

figure;
plot(gains, MSE);
grid on;
xlabel(prefix);
ylabel('MSE');
title('MSE vs gains');

figure;
plot(gains, ISE);
grid on;
xlabel(prefix);
ylabel('ISE');
title('ISE vs gains');

end
