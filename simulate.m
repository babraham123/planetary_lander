function [X, Xd, U] = simulate(tspan, x0, trajectory, consts, K) 
% x    = x,y,z, vx,vy,vz, theta,phi,psi, dtheta,dphi,dpsi
% traj = x,y,z,psi, vx,vy,vz,dpsi, ax,ay,az,ddpsi

thrusterSelection = false;

n = length(x0);
steps = length(tspan);
x0 = x0(:);

% initialize
X = zeros(n, steps);
X(:,1) = x0;
Xd = zeros(n, steps);
U = zeros(6, steps);
H = diff(tspan);
theta_d = 0;
phi_d = 0;
Fb3 = 0;
M = [0;0;0];
u = zeros(6,1);

for k = 1:steps-1
    t = tspan(k);
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
        M = attitudeControl(Fb3, x, [theta_d, phi_d, psi_d], traj);
        update = true;
    end

    if (update)
        u = [0, 0, Fb3; M];

        % thruster mixing logic
        if thrusterSelection
            Ft = mixingLogic(u, consts);
            % thruster saturations
            Ft = min(max(Ft, consts.thrusterMin), consts.thrusterMax);
            u = consts.H*Ft;
        else
            % Force saturations
            u(1) = min(max(u(1), consts.forceMin), consts.forceMax);
            u(2:4) = min(max(u(2:4), -consts.torqueMaxAbs), consts.torqueMaxAbs);
        end
    end

    % nonlinear dynamics
    [xDot, omega] = dynamics(x, u, consts);
    X(:,k+1) = x + xDot*h;
    X(10:12,k+1) = omegaToEuler(X(7:9,k+1), omega + xDot(10:12)*h);

    xd = [traj(1:3,k); traj(5:7,k); theta_d;phi_d;traj(4,k); 0;0;traj(8,k)];
    Xd(:,k+1) = xd;
    U(:,k) = u;
end

Xd(1:end-1,10) = diff(Xd(:,7))./diff(tspan);
Xd(1:end-1,11) = diff(Xd(:,8))./diff(tspan);

end
