%% Math Modeling
% Yueqi Ren
% 09/03/2020

%% Population Dynamics
% 1 a) Steady state population sizes are x(0) = K and x(0) = 0.
% 1 b) First equation: exponential growth, second equation: S-curve
% 1 c) Generate time series
r = 0.1;
K = 0.6;
n = 50;
x_1 = zeros(1, n);
x_2 = zeros(1, n);
x_1(1) = 0.2;
x_2(1) = 0.2;
for time = 2:n
    x_1(time) = x_1(time-1) + r*x_1(time-1);
    x_2(time) = x_2(time-1) + r*(1 - x_2(time-1)/K)*x_2(time-1);
end
% Model 1
figure
plot(1:n, x_1, '-ob');
title(['r = ', num2str(r), ' K = ', num2str(K)])
% Model 2
figure
plot(1:n, x_2, '-ob'); hold on
plot(0:n+1, ones(1,n)*K)
title(['r = ', num2str(r), ' K = ', num2str(K)])

%% 1 d) 
r = 2.1;
K = 0.6;
x_1 = zeros(1, n);
x_2 = zeros(1, n);
x_1(1) = 1;
x_2(1) = 0.1;
for time = 2:n
    x_2(time) = x_2(time-1) + r*(1 - x_2(time-1)/K)*x_2(time-1);
end
figure
plot(1:n, x_2, '-ob');
plot(0:n+1, ones(1,n)*K)
title(['r = ', num2str(r), ' K = ', num2str(K)])

%% 1 e)
r = 2.5;
K = 0.6;
x_1 = zeros(1, n);
x_2 = zeros(1, n);
x_1(1) = 1;
x_2(1) = 0.1;
for time = 2:n
    x_1(time) = x_1(time-1) + r*x_1(time-1);
    x_2(time) = x_2(time-1) + r*(1 - x_2(time-1)/K)*x_2(time-1);
end
figure
plot(1:n, x_2, '-ob'); hold on
plot(0:n+1, ones(1,n)*K)
title(['r = ', num2str(r), ' K = ', num2str(K)])

%% 1 f) Is it possible to find a 3-cycle?
n = 1e6;
r = 2.836;
K = 0.6;
x_1 = zeros(1, n);
x_2 = zeros(1, n);
x_1(1) = 1;
x_2(1) = 0.1;
for time = 2:n
    x_2(time) = x_2(time-1) + r*(1 - x_2(time-1)/K)*x_2(time-1);
end
figure
plot(1:n, x_2, '-ob'); hold on
plot(0:n+1, ones(1,n+2)*K)
title(['r = ', num2str(r), ' K = ', num2str(K)])
% Not possible to find a 3-cycle
 
%% 1 g) Sweep through varying values of r
num_sweep = 10000;
r_var = linspace(0,3,num_sweep);
K = 0.6;
n_large = 1000;
N_all = zeros(num_sweep*n_large/2,1);
r_all = zeros(num_sweep*n_large/2,1);
x_large = zeros(1, n_large);
x_large(1) = 0.1;
% N_all = [];
for i = 1:num_sweep
    for time = 2:n_large
        x_large(time) = x_large(time-1) + r_var(i)*(1 - x_large(time-1)/K)*x_large(time-1);
    end
    % ps = uniquetol(x_2(n_large/2:end), 1e-2);
    r_all((i-1)*n_large/2+1:i*n_large/2) = ones(1,n_large/2)*r_var(i);
    % N_all(end+1:end+n_large/2) = x_large(n_large+1/2:end);
    N_all((i-1)*n_large/2+1:i*n_large/2) = x_large(n_large/2+1:end);
end

%% Visualize the bifurcation plot
figure
c = linspace(1,20,length(r_all));
fig = scatter(r_all, N_all, 2, c, 'o', 'filled');
xlabel('Values of r', 'fontsize', 12)
ylabel('Values of N in N-cycles at equilibrium', 'fontsize', 12)
title('Population dynamics: discrete logistic growth', 'fontsize', 16)
% saveas(fig, 'bifurcation_plot', 'fig')
