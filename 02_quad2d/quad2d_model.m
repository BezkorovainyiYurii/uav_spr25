function dx = quad2d_model (t,x,traj,control,arm)
  Y  = x(1);
  Vy = x(2);
  X  = x(3);
  Vx = x(4);
  Pa = x(5);
  Pv = x(6);
  
  atm = atmosphere(Y);
  atm0= atmosphere(0);
  [Xz,Yz]=traj(t);
  [u1,u2,~] = quad2d_control(Yz,Xz,Y,X,Vy,Vx,Pa,Pv,arm);
  
  F1 = atm.rho/atm0.rho * arm.kt * u1.^2;
  F2 = atm.rho/atm0.rho * arm.kt * u2.^2;
  Fg = arm.m*arm.g;
  
  Mz = (F1 - F2)*arm.arm_length;
  Fy = F1+F2;
  
  dPv=Mz/arm.Iz;
  dPa=Pv;
  
  
  dVy=(Fy*cos(Pa)-Fg)/arm.m;
  dY=Vy;
  
  dVx = Fy*sin(Pa)/arm.m;
  dX = Vx;
  
  dx(1) = dY;
  dx(2) = dVy;
  dx(3) = dX;
  dx(4) = dVx;
  dx(5) = dPa;
  dx(6) = dPv;
 
end
