function arm = quad_arm()
  % Фізичні параметри

  arm.g = 9.806;
  % Властивосты рами F450
  arm.arm_length = 0.455/2;
  arm.arm_mass = 0.282;
  arm.payload = 0.500;

  % Властивості двигуна DJI 2212
  arm.engine_kv = 920;
  arm.engine_mass =  0.055;

  % Властивості батареї Turnigy 2200mAh 3S 40C Lipo
  arm.battery_voltage = 11.2;
  arm.battery_mass = 0.204;

  % Обмеження керування
  arm.u_min = 0;
  arm.u_max = arm.engine_kv*arm.battery_voltage;



  % Властивості гвинта 1045
  arm.propeller_mass = 0.011;
  arm.propeller_thrust = 0.682;


  arm.m = arm.arm_mass + ...
          4*(arm.engine_mass + arm.propeller_mass) + ...
          arm.battery_mass+arm.payload;
  arm.kt = 4*( arm.g * arm.propeller_thrust)/(arm.u_max^2);

end
