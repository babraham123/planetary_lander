function [X, Xd, U] = simulate(T, x0, trajectory, consts, K) 
% x    = x,y,z, vx,vy,vz, theta,phi,psi, dtheta,dphi,dpsi
% traj = x,y,z,psi, vx,vy,vz,dpsi, ax,ay,az,ddpsi

thrusterSelection = false;

n = length(x0);
steps = length(T);
x0 = x0(:);

% initialize
X = zeros(n, steps);
X(:,1) = x0;
Xd = zeros(n, steps);
U = zeros(6, steps);
H = diff(T);
theta_d = 0;
phi_d = 0;
Fb3 = 0;
M = [0;0;0];
u = zeros(6,1);

for k = 1:steps-1
    t = T(k);
    h = H(k);
    x = X(:,k);
    update = false;
    traj = trajectory(:,k);

    if (mod(k-1, consts.positionIter) == 0)
        Fb3 = positionControl(x, traj, consts, K);
        [theta_d, phi_d] = attitudePlanner(x, traj, consts, K);
        update = true;
    end

    if (mod(k-1, consts.attitudeIter) == 0)
        M = attitudeControl(Fb3, x, [theta_d, phi_d, traj(4)], K);
        update = true;
    end

    if (update)
        u = [0; 0; Fb3; M];

        % thruster mixing logic
        if thrusterSelection
            Ft = mixingLogic(u, consts);
            % thruster saturations
            Ft = min(max(Ft, consts.thrusterMin), consts.thrusterMax);
            u = consts.H*Ft;
        else
            % Force saturations
            u(1:3) = min(max(u(1:3), consts.forceMin), consts.forceMax);
            u(4:6) = min(max(u(4:6), -consts.torqueMaxAbs), consts.torqueMaxAbs);
        end
    end

    % nonlinear dynamics
    [xDot, omega] = dynamics(x, u, consts);
    X(:,k+1) = x + xDot*h;
    X(10:12,k+1) = omegaToEuler(X(7:9,k+1), omega + xDot(10:12)*h);

    Xd(:,k) = [traj(1:3); traj(5:7); theta_d;phi_d;traj(4); 0;0;traj(8)];
    U(:,k) = u;
end

traj = trajectory(:,end);
Xd(:,end) = [traj(1:3); traj(5:7); theta_d;phi_d;traj(4); 0;0;traj(8)];
U(:,end) = u;

Xd = Xd';
td = [T; T]';
Xd(1:end-1,10:11) = diff(Xd(:,7:8))./diff(td);
Xd = Xd';

end
