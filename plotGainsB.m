
consts = get_consts();
range = 0.25:0.25:2;
gains = range .* consts.K(1);

kpx = [
0.39118 0.24977 0.21506 0.21099 0.22585 0.26005 0.3211 0.42805;
0.32989 0.20477 0.16735 0.1538 0.15272 0.16203 0.18346 0.22314;
0.33663 0.20253 0.15925 0.13948 0.13071 0.12975 0.13669 0.15454 ];

figure;
set(gcf,'color','w');
grid on;
hold on;
for cc=1:3
    plot(gains, kpx(cc,:));
end
xlabel('gain');
ylabel('MSE (m^2)');
title('L2 Norm of the Position MSE vs Kp,xy gain');
legend({'linear', 'geometric', 'weighted geometric'});
hold off;


gains = range .* consts.K(4);
kdx = [
3.9562 0.44129 0.25049 0.21099 0.25997 0.45412 1.1039 7.3487;
2.8676 0.35377 0.19462 0.1538 0.19659 0.38769 0.93278 3.2248;
2.94 0.36249 0.19712 0.13948 0.12443 0.18313 0.4445 1.6678 ];

figure;
set(gcf,'color','w');
grid on;
hold on;
for cc=1:3
    plot(gains, kdx(cc,:));
end
xlabel('gain');
ylabel('MSE (m^2)');
title('L2 Norm of the Position MSE vs Kd,xy gain');
legend({'linear', 'geometric', 'weighted geometric'});
hold off;

