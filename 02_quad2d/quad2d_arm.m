function arm = quad2d_arm()
  % Фізичні параметри 
  arm.g = 9.806;
  % Характеристики рами F450
  arm.arm_length = 0.455/2/sqrt(2);
  arm.arm_mass = 0.282;
  arm.payload = 0.500;
  % Розміри центральної частини
  arm.width=0.100;
  arm.height=0.04;
    
  % Характеристики двигуна DJI 2212
  arm.engine_kv = 920;
  arm.engine_mass =  0.055; 
 
  % Характеристики батареї Turnigy 2200mAh 3S 40C Lipo
  arm.battery_voltage = 11.2;
  arm.battery_mass = 0.204;

  % Обмеження керування
  arm.u_min = 0;
  arm.u_max = arm.engine_kv*arm.battery_voltage;
  
  % Властивості гвинта 1045
  arm.propeller_mass = 0.011;
  arm.propeller_thrust = 0.682;

  % Вага спорядженого квадрокоптера    
  arm.m = arm.arm_mass + ...
          4*(arm.engine_mass + arm.propeller_mass) + ...
          arm.battery_mass+arm.payload;
  
  % Коефіціент тяги пари гвинтів
  arm.kt = 2*(arm.g * arm.propeller_thrust)/(arm.u_max^2);
  
  arm.Iz = 4*(arm.engine_mass+arm.propeller_mass)*arm.arm_length^2 + ...
           4*arm.arm_mass*arm.arm_length^2/3 + ...
           (arm.payload+arm.battery_mass)/12*(arm.width^2+arm.height^2);
end
