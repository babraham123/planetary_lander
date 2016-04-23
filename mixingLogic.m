function Ft = mixingLogic(u, consts)

Hinv = pinv(consts.H);
Ft = Hinv*u;

end
