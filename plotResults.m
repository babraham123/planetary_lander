function plotResults(T, X, Xd, U)
% x = x,y,z, vx,vy,vz, phi,theta,psi, dphi,dtheta,dpsi
%trajectory = x,y,z,psi, dx,dy,dz,dpsi, ddx,ddy,ddz,ddpsi 

figure;
hold on;
plot3(X(1,:), X(2,:), X(3,:));
plot3(Xd(1,:), Xd(2,:), Xd(3,:), '--');
grid on;
xlabel('x (m)');
ylabel('y (m)');
zlabel('z (m)');
title('Trajectories');
hold off;
legend({'actual', 'desired'});

figure;
hold on;
plot(T, X(1,:));
plot(T, Xd(1,:), '--');
grid on;
xlabel('time (s)');
ylabel('x (m)');
title('Position X');
hold off;
legend({'actual', 'desired'});

figure;
hold on;
plot(T, X(2,:));
plot(T, Xd(2,:), '--');
grid on;
xlabel('time (s)');
ylabel('y (m)');
title('Position Y');
hold off;
legend({'actual', 'desired'});

figure;
hold on;
plot(T, X(3,:));
plot(T, Xd(3,:), '--');
grid on;
xlabel('time (s)');
ylabel('z (m)');
title('Position Z');
hold off;
legend({'actual', 'desired'});

figure;
hold on;
plot(T, X(7,:)*180/pi);
plot(T, Xd(7,:)*180/pi, '--');
plot(T, X(8,:)*180/pi);
plot(T, Xd(8,:)*180/pi, '--');
grid on;
xlabel('time (s)');
ylabel('phi, theta (deg)');
title('Angles {\theta}, {\phi}');
hold off;
legend({'phi', 'phi desired', 'theta', 'theta desired'});
 
figure;
hold on;
plot(T, X(9,:)*180/pi);
plot(T, Xd(9,:)*180/pi, '--');
grid on;
xlabel('time (s)');
ylabel('psi (deg)');
title('Angle {\psi}');
hold off;
legend({'actual', 'desired'});


% TODO
% other angles, velocities, accelerations, thrusts, torques

end
