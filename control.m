function f = control(xe,dxe, kp,kd)
f = kp*xe + kd*dxe;
end