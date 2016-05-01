rate = 2.5;  % Change this to speed up / slow down animation [Matlab R2014b and onwards appears to have slow rendering for animation.]

%T = linspace(t_orig(1), t_orig(end), round( (t_orig(end)-t_orig(1))*rate ))' ;
%X = interp1(t_orig, x_orig, T, 'cubic');
%U = interp1(t_orig, u_orig, T, 'cubic');
%traj = interp1(t_orig, traj_orig, T, 'cubic');
T = t_orig';
X = x_orig;
U = u_orig;
traj = traj_orig;
consts = get_consts();
% initialize variables
xi = X(1:3,:);
v = X(4:6,:);
eulerAngles = X(7:9,:);
omega = X(10:12,:);
force_body = U(1:3,:);
torque = U(4:6,:);
trajectory = traj(1:3,:);
trajx = trajectory(1,:);
trajy = trajectory(2,:);
trajz = trajectory(3,:);
xax = [min(trajx) - 5, max(trajx)+5];
yax = [min(trajy) - 5, max(trajy)+5];
zax = [min(trajz) - 5, max(trajz)+5];


%% Setup of simulation
% dock figures
%set(0,'DefaultFigureWindowStyle','docked')

% create a figure, wait, call it again to make it pop to the foreground
myfig = figure();
pause(.01)
figure(myfig)

% clear variables; these are going to be our containers for our Lines,
% Text, Frames, and Homogeneous transforms
clear L0 T0 F0 H0 
[x,y,z] = ellipsoid(0,0,0,1.5,1.5,0.5);
L0 = surf(x,y,z);
% x axis
A0(1) = line([0 1.75],[0 0],[0 0],'color','k','linewidth',1);
T0(1) = text(2.5,0,0,'x');   

hold on

% y axis
A0(2) = line([0 0],[0 1.75],[0 0], 'color','k','linewidth',1);
T0(2) = text(0,2.5,0,'y');

% z axis
A0(3) = line([0 0],[0 0],[0 0.75], 'color','k','linewidth',1);
T0(3) = text(0,0,1.5,'z');

%aesthetics
shading interp 
% temp = bone(512);
% col = temp(150:350,:);
% colormap(col)
view(150,60)
%view(2)

F0 = hgtransform('Parent',gca);


set(L0,'Parent',F0);
set(T0,'Parent',F0);
set(A0,'Parent',F0);
% F0
% F0.Children
grid on
xlabel('X','fontweight' ,'bold')
ylabel('Y','fontweight','bold')
zlabel('Z','fontweight','bold')
axis([xax yax zax]) % expand & lock our view axes, to see better
%pause(4)
%%Animation;
n = length(T);

for i = 1:200:n

    % State of rotation
    angles = eulerAngles(:,i);
    

%     c1 = cos(angles(1))
%     s1 = sin(angles(1))
%     c2 = cos(angles(2))
%     s2 = sin(angles(2))
%     c3 = cos(angles(3))
%     s3 = sin(angles(3))

    R = eulerToRot(angles);
    %position
    pos = xi(:,i);
    temp = traj(1:3,i);

    %update animation
    H0 = eye(4); % make Identity homogeneous transform
    H0(1:3,4) = pos; % set position (in this example only Z was updated)
    H0(1:3,1:3) = R;

    set(F0,'Matrix',H0);  
    pause(0.01)
    plot3(trajx(1:i),trajy(1:i),trajz(1:i),'b:','Linewidth',2); %plots trajectory
    plot3(xi(1,1:i),xi(2,1:i),xi(3,1:i),'r','LineWidth',1.5) %plots path traveled
    drawnow % force plot to update
end

end

