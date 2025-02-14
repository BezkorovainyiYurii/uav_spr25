% Горизонтальний політ квадрокоптера

% Складання математичної моделі
quad_simmodel = @(t,x) quad2d_model(t,x,@quad2d_trajectory,@quad_control,quad2d_arm())

% Імітаційне моделювання
[t,y] = ode45(quad_simmodel,[0,600],[0,0,0,0,0,0]);
disp("Done");

% Візуалізація результатів
quad2d_plot
