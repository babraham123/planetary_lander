function [x_dot] = simulate(tspan, x0, Xd, consts) 
% x = x,y,z, vx,vy,vz, ax,ay,az, theta,phi,psi, wx,wy,wz, dwx,dwy,dwz

n = length(x0);
steps = length(tspan);
X = zeros(n, steps);
H = diff(tspan);
x0 = x0(:);
update = false;
thrusterSelection = false;

X(:,1) = x0;
for k = 2:steps
    t = tspan(k);
    h = H(k);
    x = X(:,k);
    xd = Xd(:,k);

    if (mod(k-1, consts.positionIter) == 0)
        [Fb3, theta_d, phi_d] = attitudePlanner(x, xd);
        update = true;
    end

    if (mod(k-1, consts.attitudeIter) == 0)
        M = attitudeControl(Fb3, x, xd);
        update = true;
    end

    u = [Fb3; M];
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
    xDot = dynamics(tspan, x0, xd, u, consts)

    X(:,k) = x + xDot*h;
end

end