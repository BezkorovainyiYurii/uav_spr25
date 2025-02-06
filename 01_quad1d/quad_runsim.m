% Функція симуляції польоту квадрокоптера


quad_simmodel = @(t,x) quad_model(t,x,@quad_trajectory,@quad_control,quad_arm())


[t,y] = ode45(quad_simmodel,[0,600],[0,0]);

yz = quad_trajectory(t);
u = quad_control(yz,y(:,1),y(:,2),quad_arm());

figure(1)
subplot(2,1,1);
plot(t,y,t,yz);
subplot(2,1,2);
plot(t,u);