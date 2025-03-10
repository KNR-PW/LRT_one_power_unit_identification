
function combined_error = combined_error_function(RealFile, Gazebo_raw_File, params)
    %show the params:
    display(params);
    % Send parameters to python
    python_script_path = '/home/niuniek/meldog-ros/src/power_unit_v3/launch/power_unit_optimization_changeVals.py';
    command = sprintf('gnome-terminal -- python3 %s %f %f %f %f %f %f %f', python_script_path, params);
    system(command);
    pause(1);
    % Call simulation
    system('python3 /home/niuniek/meldog-ros/src/power_unit_v3/launch/power_unit_run_simulation_node.py')
    pause(1);
    % Call DynamicErrorAutomatic with current parameter values
    [sum_position_errorsquared, sum_velocity_errorsquared] = DynamicErrorAutomatic(RealFile, Gazebo_raw_File, params);
    % Combine the errors into a single scalar value 
    combined_error = 10*sum_position_errorsquared + sum_velocity_errorsquared;
end