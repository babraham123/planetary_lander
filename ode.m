function Y = ode(odefun, tspan, y0, Yd, varargin)

neq = length(y0);
N = length(tspan);
Y = zeros(neq, N);

h = diff(tspan);
y0 = y0(:);

Y(:,1) = y0;
for k = 2:N
  ti = tspan(k-1);
  hi = h(k-1);
  yi = Y(:,k-1);
  ydi = Yd(:,k-1);  
  
  F = feval(odefun, ti, k, yi, ydi, varargin{:});  
  Y(:,k) = yi + F*hi;
end
Y = Y.';

end
