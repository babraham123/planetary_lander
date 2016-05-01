function [y] = unSkew (x) 
% calculates vector from the cross hat matrix

y = [x(3,2); x(1,3); x(2,1)];
end
