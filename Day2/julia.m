%% Day 2 of MCSB Bootcamp
% Julia Assignment
% Yueqi Ren
% 09/02/2020
clear all
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
%% 1 b) N vs x
figure
plot(1:N, x, '*-')
xlabel('N')
ylabel('x')

%% 1 c) x vs y
figure
plot(x, y, '*')
xlabel('x')
ylabel('y')

%% 1 d) Generate 100 points uniformly randomly selected from [-2 2]
NStartingPoints = 100;
points = -2 + (2+2)*rand(NStartingPoints,1);

%% 1 e) Visualize the random x and y points at step 1
xpoints = -2 + (2+2)*rand(NStartingPoints,1);
ypoints = -2 + (2+2)*rand(NStartingPoints,1);
figure 
plot(xpoints, ypoints, '*')
xlabel('x_{random}')
ylabel('y_{random}')

%% 1 f) Visualize (x,y) at step 1 based upon their values at step 22
NStartingPoints = 100;
x_random = zeros(NStartingPoints,N);
y_random = zeros(NStartingPoints,N);
x_random(:,1) = xpoints;
y_random(:,1) = ypoints;
for i = 1:N-1
    x_random(:,i+1) = x_random(:,i).^2 - y_random(:,i).^2 + c;
    y_random(:,i+1) = 2*x_random(:,i).*y_random(:,i) + d;
end
% Check if (x,y) fit within (-2,2) box by checking if the absolute value of
% the pair is each less than 2
xwithin = x_random((abs(x_random(:,22)) <= 2 & abs(y_random(:,22)) <= 2), 1);
ywithin = y_random((abs(x_random(:,22)) <= 2 & abs(y_random(:,22)) <= 2), 1);
xoutside = x_random(~(abs(x_random(:,22)) <= 2 & abs(y_random(:,22)) <= 2), 1);
youtside = y_random(~(abs(x_random(:,22)) <= 2 & abs(y_random(:,22)) <= 2), 1);
figure
plot(xwithin, ywithin, '*c')
hold on
plot(xoutside, youtside, '*b')
xlabel('x')
ylabel('y')
legend({'Within (-2,2)', 'Outside (-2,2)'})

%% 1 g) and h) increase NStartingPoints, change c & d 
% Scan across 4 different values of c and d each
c_all = [-.84 -.82 -0.8 -0.78]; % The "twistedness" of branches
d_all = [.16 .158 .154 .15]; % Thickness of "main stem", skew (axis of symmetry)
figure;
num = 1;
for c = c_all
    for d = d_all
        NStartingPoints = 1e6;
        xpoints = -2 + (2+2)*rand(NStartingPoints,1);
        ypoints = -2 + (2+2)*rand(NStartingPoints,1);
        x_large = zeros(NStartingPoints,N);
        y_large = zeros(NStartingPoints,N);
        x_large(:,1) = xpoints;
        y_large(:,1) = ypoints;
        for i = 1:N-1
            x_large(:,i+1) = x_large(:,i).^2 - y_large(:,i).^2 + c;
            y_large(:,i+1) = 2*x_large(:,i).*y_large(:,i) + d;
        end
        % Check if (x,y) fit within (-2,2) box by checking if the absolute value of
        % the pair is each less than 2
        xwithin_large = x_large((abs(x_large(:,22)) <= 2 & abs(y_large(:,22)) <= 2), 1);
        ywithin_large = y_large((abs(x_large(:,22)) <= 2 & abs(y_large(:,22)) <= 2), 1);
        xoutside_large = x_large(~(abs(x_large(:,22)) <= 2 & abs(y_large(:,22)) <= 2), 1);
        youtside_large = y_large(~(abs(x_large(:,22)) <= 2 & abs(y_large(:,22)) <= 2), 1);
        % Gather plots into subplots to visualize together
        subplot(4, 4, num)
        plot(xwithin_large, ywithin_large, '.g')
        hold on
        plot(xoutside_large, youtside_large, '.k')
        xlabel('x')
        ylabel('y')
        title(['c = ', num2str(c), ', d = ', num2str(d)])
        num = num + 1;
    end
end

%% 1 i) Bonus Part: 
% Make a version that records what n each initial x,y leaves  the (-2,2) 
% box. Call this n_at_exit. Then, when you plot the points that exist, 
% color the points by the n_at_exit.
c = -0.8;
d = 0.156;
n_at_exit = zeros(size(x_large,1),1);
for i = 1:size(x_large,1)
    % Check if the (x,y) pair does exit the (-2,2) box
    if max(abs(x_large(i,:))) > 2 || max(abs(y_large(i,:))) > 2
        % Take the first instance (using min) when the (x,y) pair exits
        n_at_exit(i) = min([find(abs(x_large(i,:)) > 2, 1,'first'), ...
            find(abs(y_large(i,:)) > 2, 1,'first')]);
    end
end
% Discard the x/y within values (n_at_exit == 0)
n_at_exit(n_at_exit(:) == 0) = []; 
% Visualize the plot from g) with the colors of (x,y) outside determined by
% their index when they exited the (-2,2) box
figure;
scatter(xwithin_large, ywithin_large, 1, 'b')
hold on
scatter(xoutside_large, youtside_large, 1, n_at_exit)
xlabel('x')
ylabel('y')
title(['c = ', num2str(c), ', d = ', num2str(d)])