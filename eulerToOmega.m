function w = eulerToOmega(angles, dAngles)

% State of rotation
c1 = cos(eulerAngles(1));
s1 = sin(eulerAngles(1));
c2 = cos(eulerAngles(2));
s2 = sin(eulerAngles(2));

R = [1 0 -s1; 0 c2 s2*c1; 0 -s2 c1*c2];
w = R*dAngles;

end