function dAngles = omegaToEuler(angles, omega)

% State of rotation
sec1 = sec(eulerAngles(1));
t1 = sin(eulerAngles(1));
c2 = cos(eulerAngles(2));
s2 = sin(eulerAngles(2));

R = [1 s2*t1 c2*t1; 0 c2 -s2; 0 s2*sec1 c2*sec1];
dAngles = R*omega;

end