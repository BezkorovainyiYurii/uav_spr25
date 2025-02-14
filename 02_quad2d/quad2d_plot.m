% Скрипт побудови графіків руху квадрокоптера
arm=quad2d_arm();
% Відновлення вектору стану квадрокоптера
% Висота польоту
Y = y(:,1);
% Вертикальна швидкість
Vy = y(:,2);
% Горизонтальне переміщення
X = y(:,3);
% Горизонтальна швидкість
Vx = y(:,4);
% Кутове прискорення
Pa = y(:,5);
% Кутова швидкість
Pv = y(:,6);

% Відтворення заданної траєкторії руху
[Xz,Yz]=quad2d_trajectory(t);

% Відновлення вектору керування квадрокоптера
[u1,u2,pitch] = quad2d_control(Yz,Xz,Y,X,Vy,Vx,Pa,Pv,quad2d_arm());

% Формування положень рами у часі
T = linspace(t(1),t(end),101);

% Кутове та лінійне відхилення рами
A = interp1(t,Pa,T);
Xq = interp1(t,X,T);
Yq = interp1(t,Y,T);

% Нормовані сигнали керування
U1 = interp1(t,u1,T)/arm.u_max/2;
U2 = interp1(t,u2,T)/arm.u_max/2;

% Відхилення положення двигунів у просторі
ENG1X=Xq-arm.arm_length.*cos(A);
ENG1Y=Yq+arm.arm_length.*sin(A);

ENG2X=Xq+arm.arm_length.*cos(A);
ENG2Y=Yq-arm.arm_length.*sin(A);

% Відхилення положення вектору тяги
ENG1FX=ENG1X+U1.*sin(A);
ENG1FY=ENG1Y+U1.*cos(A);

ENG2FX=ENG2X+U2.*sin(A);
ENG2FY=ENG2Y+U2.*cos(A);


%Графіки

figure(1)
subplot(3,1,1);
plot(t,Xz, t,X);
xlabel("Час, с");
ylabel("Відстань, м");
title("Часовий профіль польоту");

subplot(3,1,2);
plot(t,Yz, t,Y);
xlabel("Час, с");
ylabel("Висота польоту, м");

subplot(3,1,3);
plot(t,u1,t,u2);
xlabel("Час, с");
ylabel("Сигнали керування, RPM");

figure(2);
subplot(2,1,1);
plot(t,pitch*180/pi,t,Pa*180/pi);
xlabel("Час, с");
ylabel("Кутове положення, град");

subplot(2,1,2);
plot(t,u2-u1);
ylim([-5,5]);
xlabel("Час, с");
ylabel("Різниця керування, RPM");


figure(3)
plot(Xz,Yz,X,Y);
ylabel("Відстань, м");
ylabel("Висота польоту, м");
title("Просторовий профіль польоту");

figure(4)
plot(X,Y,'r--',Xz,Yz,'g--');
hold on;
plot([ENG1X(:),ENG2X(:)]',[ENG1Y(:),ENG2Y(:)]','b-o');
plot([ENG1X(:),ENG1FX(:)]',[ENG1Y(:),ENG1FY(:)]','r-');
plot([ENG2X(:),ENG2FX(:)]',[ENG2Y(:),ENG2FY(:)]','r-');
hold off;
title("Просторовий профіль польоту");
ylabel("Відстань, м");
ylabel("Висота польоту, м");
axis equal;
