function plotResults(T, X, Xd)

figure;
hold on;
plot3(X(1,:), X(2,:), X(3,:));
plot3(Xd(1,:), Xd(2,:), Xd(3,:), '-');
grid on;
xlabel('x (m)');
ylabel('y (m)');
zlabel('z (m)');
hold off;

figure;
hold on;
plot(T, X(1,:));
plot(T, Xd(1,:), '-');
grid on;
xlabel('time (s)');
ylabel('x (m)');
hold off;

figure;
hold on;
plot(T, X(2,:));
plot(T, Xd(2,:), '-');
grid on;
xlabel('time (s)');
ylabel('y (m)');
hold off;

figure;
hold on;
plot(T, X(3,:));
plot(T, Xd(3,:), '-');
grid on;
xlabel('time (s)');
ylabel('z (m)');
hold off;

figure;
hold on;
plot(T, X(6,:)*180/pi);
plot(T, Xd(4,:)*180/pi, '-');
grid on;
xlabel('time (s)');
ylabel('psi (deg)');
hold off;

% TODO
% other angles, velocities, accelerations, thrusts, torques

end
