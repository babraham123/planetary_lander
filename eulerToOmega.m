function w = eulerToOmega(angles, dAngles)

% State of rotation
c1 = cos(angles(1));
s1 = sin(angles(1));
c2 = cos(angles(2));
s2 = sin(angles(2));

H = [c2 0 -c1*s2; 0 1 s1; s2 0 c1*c2];
w = H*dAngles;

end