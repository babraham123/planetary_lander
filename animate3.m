function animate(t_orig, x_orig, u_orig, traj_orig)
  rate = 25*0.1;  % Change this to speed up / slow down animation [Matlab R2014b and onwards appears to have slow rendering for animation.]
  
  t_vec = linspace(t_orig(1), t_orig(end), round( (t_orig(end)-t_orig(1))*rate ))' ;
  x_vec = interp1(t_orig, x_orig, t_vec, 'cubic');
  u_vec = interp1(t_orig, u_orig, t_vec, 'cubic');
  traj_vec = interp1(t_orig, traj_orig, t_vec, 'cubic');
 consts = get_consts();
 % initialize variables
 x = x_vec(1:3,:);
 v = x_vec(4:6,:);
 eulerAngles = x_vec(7:9,:);
 omega = x_vec(10:12,:);
 force_body = u_vec(1:3,:);
 torque = u_vec(4:6,:);
 trajectory = traj_vec(1:3,:);
 
 
 %% Setup of simulation
 % dock figures
 set(0,'DefaultFigureWindowStyle','docked')
 
 % create a figure, wait, call it again to make it pop to the foreground
 myfig = figure();
 pause(.01)
 figure(myfig)
 
 % clear variables; these are going to be our containers for our Lines,
 % Text, Frames, and Homogeneous transforms
 clear L0 T0 F0 H0 
 [x,y,z] = ellipsoid(0,0,0,0.3,0.25,0.2);
 L0 = surf(x,y,z);
 % x axis
 %L0(1) = line([0 0.3],[0 0],[0 0],'color','r','linewidth',2);
 T0(1) = text(0.4,0,0,'x');   
 
 hold on

 % y axis
 %L0(2) = line([0 0],[0 0.3],[0 0], 'color','g','linewidth',2);
 T0(2) = text(0,0.3,0,'y');
 
 % z axis
 %L0(3) = line([0 0],[0 0],[0 0.3], 'color','b','linewidth',2);
 T0(3) = text(0,0,0.25,'z');

 %aesthetics
 shading interp 
 temp = bone(512);
 col = temp(150:350,:);
 colormap(col)
 view(150,15)
 %view(2)

 F0 = hgtransform('Parent',gca);
 
 set(L0,'Parent',F0);
 set(T0,'Parent',F0);

 grid on
 xlabel('X','fontweight' ,'bold')
 ylabel('Y','fontweight','bold')
 zlabel('Z','fontweight','bold')

 axis([-2 1 -1 1 -3 0]) % expand & lock our view axes, to see better

 %%Animation;
 n = length(t_vec);
for i = 1:n
  
   % State of rotation
   Angles = eulerAngles(:,i);
   
   c1 = cos(Angles(1));
   s1 = sin(Angles(1));
   c2 = cos(Angles(2));
   s2 = sin(Angles(2));
   c3 = cos(Angles(3));
   s3 = cos(Angles(3));
   
   R = [c3*c1-s2*s3*s1 -c2*c3 c3*s1+c1*s2*s3;
   c1*s3+c3*s2*s1 c2*c3 s3*s1-c3*c1*s2;
   -c2*s1 s2 c2*c2];
   %position
   pos = x(:,i);
   
   %update animation
   H0 = eye(4); % make Identity homogeneous transform
   H0(1:3,4) = pos; % set position (in this example only Z was updated)
   H0(1:3,1:3) = R;
   
   set(F0,'Matrix',H0);  
   pause(0.15)
   plot3(trajectory,'k','Linewidth',3); %plots trajectory
   plot3(x(1,1:i),x(2,1:i),x(3,1:i),'r','LineWidth',2) %plots path traveled
    drawnow % force plot to update
  end
end
