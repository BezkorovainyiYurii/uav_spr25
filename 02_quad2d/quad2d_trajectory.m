function [X_traj,Y_traj] = quad2d_trajectory(t)
  % Завдання траекторії
  X_min = 0;
  X_max = 100;
  Y_min = 0;
  Y_max = 10;
  
  X_traj=interp1([    0,  100,  200,  300,  400,  500,  600],...
                 [X_min,X_min,X_min,X_min,X_max,X_max,X_max],t);
  Y_traj=interp1([    0,  100,  200,  300,  400,  500,  600],...
                 [Y_min,Y_min,Y_max,Y_max,Y_max,Y_max,Y_min],t);
end
