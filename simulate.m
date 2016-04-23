function [X, Xd, U] = simulate(tspan, x0, traj, consts) 
% x    = x,y,z, vx,vy,vz, theta,phi,psi, dtheta,dphi,dpsi

n = length(x0);
steps = length(tspan);
X = zeros(n, steps);
Xd = zeros(n, steps);
H = diff(tspan);
x0 = x0(:);
update = false;
thrusterSelection = false;

X(:,1) = x0;
for k = 1:steps-1
    t = tspan(k);
    h = H(k);
    x = X(:,k);
    xd = [traj(1:3,k);  ;

    if (mod(k-1, consts.positionIter) == 0)
        ad = positionControl(x, xd);
        [Fb3, theta_d, phi_d] = attitudePlanner(x, xd);
        update = true;
    end

    if (mod(k-1, consts.attitudeIter) == 0)
        M = attitudeControl(Fb3, x, xd);
        update = true;
    end

    u = [0, 0, Fb3; M];
    if update
        % thruster mixing logic
        if thrusterSelection
            % thruster saturations
        else
            % Force saturations
            u(1) = min(max(u(1), 0), consts.max.fT) ;
            u(2) = min(max(u(2), -consts.max.tau), consts.max.tau) ;
        end
    end

    % nonlinear dynamics
    [xDot, omega] = dynamics(tspan, x0, xd, u, consts);
    X(:,k+1) = x + xDot*h;
    X(10:12,k+1) = omegaToEuler(X(7:9,k+1), omega + xDot(10:12)*h);

    Xd(:,k+1) = xd;
end

end
