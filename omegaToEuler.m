function dAngles = omegaToEuler(angles, omega)

% State of rotation
sec1 = sec(angles(1));
tan1 = tan(angles(1));
s1 = sin(angles(1));
c2 = cos(angles(2));
s2 = sin(angles(2));

Hinv = [c2 0 s2; tan1*s2 1 -tan1*c2; -sec1*s2 0 sec1*c2];
dAngles = Hinv*omega;

end