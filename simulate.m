function [X, Xd, U, Ud, Ft] = simulate(T, x0, trajectory, consts) 
% x    = x,y,z, vx,vy,vz, phi,theta,psi, dphi,dtheta,dpsi
% traj = x,y,z,psi, vx,vy,vz,dpsi, ax,ay,az,ddpsi

thrusterSelection = true;

n = length(x0);
steps = length(T);
x0 = x0(:);

% initialize
X = zeros(n, steps);
X(:,1) = x0;
Xd = zeros(n, steps);
Xd(:,1) = x0;
U = zeros(6, steps);
Ud = zeros(6, steps);
H = diff(T);
theta_d = 0;
phi_d = 0;
Fb3 = 0;
M = [0;0;0];
u = zeros(6,1);
Ft = zeros(8, steps);
ft = zeros(8, 1);

for k = 1:steps-1
    t = T(k);
    h = H(k);
    x = X(:,k);
    update = false;
    traj = trajectory(:,k);

    if (mod(k-1, consts.positionIter) == 0)
        %Fb3 = positionControl(x, traj, consts);
        temp = geomControl(x,traj,consts,phi_d,theta_d);
        Fb3 = temp(1);
        [phi_d, theta_d] = attitudePlanner(x, traj, consts);
        update = true;
    end

    if (mod(k-1, consts.attitudeIter) == 0)
        temp = geomControl(x,traj,consts,phi_d,theta_d); 
        M = temp(2:4);
        %M = attitudeControl(Fb3, x, [phi_d, theta_d, traj(4)],consts);
        update = true;
    end

    if (update)
        u = [0; 0; Fb3; M];
        ud = u;
        % control allocation logic
        ft = mixingLogic(u, consts);
        % thruster saturations
        ft = min(max(ft, consts.thrusterMin.*ones(8,1)), consts.thrusterMax.*ones(8,1));
        u = consts.H*ft;
        u = awgn(u,90,'measured'); %noise put in for thrusters
    end

    % nonlinear dynamics
    if (thrusterSelection)
        [xDot, omega] = dynamics(x, u, consts);
    else
        [xDot, omega] = dynamics(x, ud, consts);
    end
    X(:,k+1) = x + xDot*h;
    X(10:12,k+1) = omegaToEuler(X(7:9,k+1), omega + xDot(10:12)*h);
    X(:,k+1) = awgn(X(:,k+1),90, 'measured'); %noise in measurement

    Xd(:,k+1) = [traj(1:3); traj(5:7); phi_d;theta_d;traj(4); 0;0;traj(8)];
    U(:,k) = u;
    Ud(:,k) = ud;
    Ft(:,k) = ft;
end

Xd = Xd';
td = [T; T]';
Xd(1:end-1,10:11) = diff(Xd(:,7:8))./diff(td);
Xd = Xd';

end
