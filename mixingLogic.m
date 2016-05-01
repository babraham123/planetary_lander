function Ft = mixingLogic(u, consts)

% Hinv = pinv(consts.H);
Ft = consts.Hinv * u;

end
