%% Day 2 of MCSB Bootcamp
% Julia Assignment
% Yueqi Ren
% 09/02/2020
c = -0.8;
d = 0.156;
N = 22; % total number of values
x = zeros(1,N);
y = zeros(1,N);

%% 1 a)
x(1)=0.1;
y(1)=0.1;
for i = 1:N-1
    x(i+1) = x(i)^2 - y(i)^2 + c;
    y(i+1) = 2*x(i)*y(i) + d;
end
% 1 b)
figure
plot(1:N, x, '*-')
xlabel('N')
ylabel('x')
% 1 c)
figure
plot(x, y, '*')
xlabel('x')
ylabel('y')
% 1 d)
NStartingPoints = 100;
points = -2 + (2+2)*rand(NStartingPoints,1);
% 1 e)
xpoints = -2 + (2+2)*rand(NStartingPoints,1);
ypoints = -2 + (2+2)*rand(NStartingPoints,1);

figure 
plot(xpoints, ypoints, '*')
xlabel('x_{random}')
ylabel('y_{random}')

%% 1 f)
x_random = zeros(100,N);
y_random = zeros(100,N);
x_random(:,1) = xpoints;
y_random(:,1) = ypoints;
for i = 1:N-1
    x_random(:,i+1) = x_random(:,i).^2 - y_random(:,i).^2 + c;
    y_random(:,i+1) = 2*x_random(:,i).*y_random(:,i) + d;
end

%%
xwithin = x_random((abs(x_random(:,22).*y_random(:,22)) <= 4), 1);
ywithin = y_random((abs(y_random(:,22).*x_random(:,22)) <= 4), 1);
xoutside = x_random(~(abs(x_random(:,22).*y_random(:,22)) <= 4), 1);
youtside = y_random(~(abs(y_random(:,22).*x_random(:,22)) <= 4), 1);

figure
plot(xwithin, ywithin, '*b')
hold on
plot(xoutside, youtside, '*r')
xlabel('x')
ylabel('y')
legend({'Within (-2,2)', 'Outside (-2,2)'})