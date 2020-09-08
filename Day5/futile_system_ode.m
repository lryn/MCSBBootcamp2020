%% Project Futile System
% Yueqi Ren
% 09/08/2020

%% Part d) Simulate with the following initial conditions

Ktot = 1; % 然
Itot = 1; % 然
Ptot = 1; % 然
I_0 = Itot; % 然
A_0 = 0; % 然
AP_0 = 0; % 然
K_0 = 0; % 然

tspan = [0 5];
y0 = [A_0 AP_0 I_0 K_0]; % A, AP, I, IK
options = odeset('RelTol',1e-4,'AbsTol',1e-6);
[t,y] = ode45(@(t,y) odefcn(t,y,Ktot,Ptot), tspan, y0, options); % if code is slow, use ODE23S

figure; 
subplot(2,2,1)
plot(t,y(:,1), 'r', 'LineWidth', 2); % A
xlabel('Time (s)', 'FontSize', 12)
ylabel('[A]', 'FontSize', 12)
subplot(2,2,2)
plot(t,y(:,2), 'k', 'LineWidth', 2); % AP
xlabel('Time (s)', 'FontSize', 12)
ylabel('[AP]', 'FontSize', 12)
subplot(2,2,3)
plot(t,y(:,3), 'b', 'LineWidth', 2); % I
xlabel('Time (s)', 'FontSize', 12)
ylabel('[I]', 'FontSize', 12)
subplot(2,2,4)
plot(t,y(:,4), 'c', 'LineWidth', 2); % IK
xlabel('Time (s)', 'FontSize', 12)
ylabel('[IK]', 'FontSize', 12)

%% Part e) Parameter sweep of Ktot
n_steps = 50;
kspan = logspace(-3, 2, n_steps);
A_all = zeros(n_steps,1);
A_only = zeros(n_steps,1);
for n = 1:n_steps
    k = kspan(n);
    [t,y] = ode45(@(t,y) odefcn(t,y,k,Ptot), tspan, y0, options);
    A_all(n) = y(end,1) + y(end,2);
    A_only(n) = y(end,1);
end

figure; hold on
plot(kspan, A_all, 'LineWidth', 2)
plot(kspan, A_only, 'LineWidth', 2)
set(gca,'xscale','log')
xlabel('Log of K_{tot} (然)', 'FontSize', 12)
ylabel('[A] (然)', 'FontSize', 12)
legend({'[A] + [AP]', '[A]'}, 'FontSize', 12, 'Location', 'northwest')

%% Part f) Altering Itot
Itot = 100; % 然
I_0 = Itot; % 然
y0 = [A_0 AP_0 I_0 K_0]; % A, AP, I, IK

n_steps = 50;
kspan = logspace(-3, 2, n_steps);
A_all = zeros(n_steps,1);
A_only = zeros(n_steps,1);
for n = 1:n_steps
    k = kspan(n);
    [t,y] = ode45(@(t,y) odefcn(t,y,k,Ptot), tspan, y0, options);
    A_all(n) = y(end,1) + y(end,2);
    A_only(n) = y(end,1);
end

figure; hold on
plot(kspan, A_all, 'LineWidth', 2)
plot(kspan, A_only, 'LineWidth', 2)
set(gca,'xscale','log')
xlabel('Log of K_{tot} (然)', 'FontSize', 12)
ylabel('[A] (然)', 'FontSize', 12)
legend({'[A] + [AP]', '[A]'}, 'FontSize', 12, 'Location', 'northwest')

function dydt = odefcn(t, y, Ktot, Ptot)
konA = 10; % 1/s*然
koffA = 10; % 1/s
konI = 10; % 1/s*然
koffI = 10; % 1/s
kcatI = 10; % 1/s
kcatA = 100; % 1/s

dydt = zeros(4,1);
A = y(1);
AP = y(2);
I = y(3);
IK = y(4);
% dA/dt, y(1) = A
dydt(1) = -konA*(Ptot - AP)*A + koffA*AP + kcatA*IK;
% dAP/dt y(2) = AP
dydt(2) = konA*(Ptot - AP)*A - (koffA + kcatI)*AP;
% dI/dt y(3) = I
dydt(3) = -konI*(Ktot - IK)*I + koffI*IK + kcatI*AP;
% dIK/dt y(4) = IK
dydt(4) = konI*(Ktot - IK)*I - (koffI + kcatA)*IK;
end
