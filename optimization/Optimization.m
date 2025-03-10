clear;
clc;
RealFile = '/home/niuniek/OPTYMALIZACJA/przebiegi/final_adjusted_sine.txt';
Gazebo_raw_File = "/home/niuniek/OPTYMALIZACJA/przebiegi/symulowany.txt";
% Define initial guess for parameters:
% [friction, damping,P, I, D, spring_stiffness, spring_reference_value]
initial_guess = [0.0, 0.0, 1.7, 0.0, 0.05, 0.0, 0.0]
% Set up bounds for parameters
lower_bounds = [0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0];
upper_bounds = [1.5, 1.5, 4.0, 4.0, 0.8, 1.5, 6.28];
% Run optimization
options = optimoptions('patternsearch', 'Display', 'iter');
[opt_params, fval] = patternsearch(@(params) combined_error_function(RealFile, Gazebo_raw_File, params), initial_guess, [], [], [], [], lower_bounds, upper_bounds, [], options);
% Display optimized parameters and objective value
disp('Optimized Parameters:');
disp(opt_params);
disp('Optimized Objective Value:');
disp(fval);

% The final values
[sum_position_errorsquared, sum_velocity_errorsquared] = DynamicErrorAutomatic(RealFile, Gazebo_raw_File);
disp('Sum of position error squared:');
disp(sum_position_errorsquared);
disp('Sum of velocity error squared:');
disp(sum_velocity_errorsquared);