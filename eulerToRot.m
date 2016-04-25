function R = eulerToRot(eulerAngles)

% State of rotation
c1 = cos(eulerAngles(1));
s1 = sin(eulerAngles(1));
c2 = cos(eulerAngles(2));
s2 = sin(eulerAngles(2));
c3 = cos(eulerAngles(3));
s3 = cos(eulerAngles(3));

R = [c3*c2-s1*s3*s2 -c1*c3 c3*s2+c2*s1*s3;
c2*s3+c3*s1*s2 c1*c3 s3*s2-c3*c2*s1;
-c1*s2 s1 c1*c2];

end