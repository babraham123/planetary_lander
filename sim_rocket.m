function sim_rocket()
    % load constant parameters
    consts = get_consts();
    
    % x = x,y,z, vx,vy,vz, theta,phi,psi, wx,wy,wz
    x0 = [10,10,100, 0,0,0, 0,0,0, 0,0,0]';
    tspan = linspace(consts.trange(1), consts.trange(2), consts.nIter);
    
    % generate trajectory of desired positions, xd = [x y z psi]
    trajectory = guidance(x0, 'hover');
    
    % interpolate and differentiate
    xd = interp1(trajectory(1,:), trajectory(2:end,:), tspan, 'cubic');
    vd = diff(xd)./diff(td);
    ad = diff(vd)./diff(td(1:end-1));
    vd(:,end+1) = [0 0 0 0]';
    ad(:,end+1) = [0 0 0 0]'; ad(:,end+1) = [0 0 0 0]';
    trajectory = [trajectory; vd; ad];

    % calculate gains for PD control, [Kp; Kd]
    K = calculateGains();

    % Integrate system
    [T, X, Xd, U] = simulate(tspan, x0, trajectory, consts, K);
    
    % J = compute_score(T, X, trajectory, consts);
    % disp(['Score: ' num2str(J)]) ;
    
    % Plots
    plotResults(T, X, Xd, U);
    
    % Animation
    animate(T, X, U);
end


