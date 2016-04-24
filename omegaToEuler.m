function dAngles = omegaToEuler(angles, omega)

% State of rotation
sec1 = sec(angles(1));
t1 = sin(angles(1));
c2 = cos(angles(2));
s2 = sin(angles(2));

R = [1 s2*t1 c2*t1; 0 c2 -s2; 0 s2*sec1 c2*sec1];
dAngles = R*omega;

end