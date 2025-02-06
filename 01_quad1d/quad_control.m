function u = quad_control(Hz,H,Vy,arm)
  % Налаштувати функцію керування висотою у вигляді ПД регулятора
  Kp = 1;
  Kd = 0;

  % Реалізація контролера
  u = Kp*(Hz-H)-Kd*Vy + sqrt(arm.g*arm.m/arm.kt);

  % Обмеження керування
  u(u > arm.u_max) = arm.u_max;
  u(u < arm.u_min) = arm.u_min;

end
