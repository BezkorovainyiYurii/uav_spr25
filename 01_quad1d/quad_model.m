function dx = quad_model (t,x,traj,control,arm)
  H = x(1);
  Vy = x(2);

  atm = atmosphere(H,15);
  atm0= atmosphere(0,15);

  u = control(traj(t),H,Vy,arm);

  Fy = atm.rho/atm0.rho * arm.kt * u^2;

  dV = (Fy-arm.m*arm.g)/arm.m;
  dH = Vy;

  dx(1,1) = dH;
  dx(1,2) = dV;

end
