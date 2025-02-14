function [u1,u2,pitch_angle] = quad2d_control(Yz,Xz,Y,X,Vy,Vx,pitch,omega_p,arm)
  % Налаштувати функцію керування висотою у вигляді ПД регулятора
  Kph = 1;
  Kdh = 0.5;
  
  % Налаштувати функцію керування положенням у вигляді ПД регулятора
  Kpx = 1;
  Kdx = 0.5;
  
  % Налаштувати функцію керування нахилом у вигляді ПД регулятора
  Kpa = 10;
  Kda = 5;
  
  % Налаштувати обмеження максимального кута нахилу
  angle_max = 1*pi/180;
  
  % Контроль висоти польоту
  u0 = Kph*(Yz-Y)-Kdh*Vy + sqrt(arm.g*arm.m/2/arm.kt./cos(pitch));
  
  % Реалізація контролеру нахилу
  pitch_angle = Kpx*(Xz-X)-Kdx*Vx;
  
  % Обмеження допустимого значення кута нахилу
  pitch_angle( pitch_angle > angle_max) = angle_max;
  pitch_angle( pitch_angle <-angle_max) =-angle_max;
  
  % Реалізація контролеру нахилу
  du = Kpa*(pitch_angle-pitch) - Kda*omega_p;
  % Формування сигналів керування двигунами
  u1=u0+du;
  u2=u0-du;
  
  % Обмеження керування
  u1(u1 > arm.u_max) = arm.u_max;
  u1(u1 < arm.u_min) = arm.u_min;
  u2(u2 > arm.u_max) = arm.u_max;
  u2(u2 < arm.u_min) = arm.u_min;
    
end
