function [sum_position_errorsquared, sum_velocity_errorsquared] = DynamicErrorAutomatic(RealFile, Gazebo_raw_File, params)

    % RealFile = '/home/niuniek/OPTYMALIZACJA/przebiegi/rzeczywisty.txt';
    RealValues = readmatrix(RealFile);
    
    % Extract columns into separate variables
    Real_time = RealValues(:, 1);       % Time in milliseconds
    Real_position_rad = RealValues(:, 2)/9.97*2*pi;  % Position in radians
    Real_velocity_ms = RealValues(:, 3)/9.97*2*pi;   % Velocity in m/s
    
    % Gazebo_raw_File = "/home/niuniek/OPTYMALIZACJA/przebiegi/symulowany.txt";
    Gazebo_data = readmatrix(Gazebo_raw_File);  % Read entire matrix from txtGazeboValues
    
    Gazebo_time = Gazebo_data(:, 1);                  % Extract time from first column 
    Gazebo_position_rad = Gazebo_data(:, 2);                 % Extract position from second column
    Gazebo_velocity_ms = Gazebo_data(:, 3);                  % Extract velocity from second column
    GazeboValues=[Gazebo_time,Gazebo_position_rad,Gazebo_velocity_ms];
    
        %PLOTS
        plot(Real_time,Real_position_rad,'DisplayName','Real position')
        hold on
        plot(Real_time,Real_velocity_ms,'DisplayName','Real Velocity')
        hold on
        plot(Gazebo_time,Gazebo_position_rad,'DisplayName', 'Gazebo Position')
        hold on
        plot(Gazebo_time,Gazebo_velocity_ms,'DisplayName','Gazebo Velocity')
        xlabel("Czas [ms]")
        ylabel("Prędkość [m/s]/Pozycja [rad]")
        grid on;
        title("Rzeczywiste i symulowane przebiegi")
        legend
    
    
    %Count the mean error squared
    position_errorsquared=zeros(length(GazeboValues), 1);  %  array to store position error percentages
    velocity_errorsquared=zeros(length(GazeboValues), 1);  %  array to store position error percentages
    for i = 1:length(RealValues)
       position_errorsquared(i)=(Gazebo_position_rad(i)-Real_position_rad(i)).^2;
       velocity_errorsquared(i)=(Gazebo_velocity_ms(i)-Real_velocity_ms(i)).^2;
    end
    
    sum_position_errorsquared=sum(position_errorsquared);
    sum_velocity_errorsquared=sum(velocity_errorsquared);
    
    %Error plots
    % plot(Gazebo_time_ms,position_errorsquared,'g', 'DisplayName','position error')
    % hold on
    % plot(Gazebo_time_ms,velocity_errorsquared,'b', 'DisplayName','velocity error')


    % disp(['Błąd średniokwadratowy pozycji: ', num2str(sum_position_errorsquared)]);
    % disp(['Błąd średniokwadratowy prędkości: ', num2str(sum_velocity_errorsquared)]);
    %Add annotation to the chart    
    errorText = sprintf(['Błąd dynamiczny pozycji: %.4f\n\n', ...
                         'Błąd dynamiczny prędkości: %.4f\n'], ...
                         sum_position_errorsquared, sum_velocity_errorsquared);
    annotation('textbox',[0.905 .5 .1 .2],'String',errorText,'EdgeColor','none')
    % Convert params to a string
    paramsString = sprintf('Parametry: %.4f, %.4f, %.4f %.4f, %.4f, %.4f, %.4f %.4f, %.4f', params);
    % Create annotation on the lower side of the chart
    annotation('textbox', [0.1, 0.1, 0.9, 0.1], 'String', paramsString, 'EdgeColor', 'none');

    % Save the current figure
    persistent counter; % Declare counter as a persistent variable
    if isempty(counter)
        counter = 1; % Initialize counter if it's empty
    else
        counter = counter + 1; % Increment counter
    end
    
    %Save every figure with its name and number
    current_fig = gcf(); % Get handle to the current figure
    % save_dir = '/home/niuniek/OPTYMALIZACJA/przebiegi/wykresy/';
    % save_name = sprintf('%splot_%d.png', save_dir, counter);
    % saveas(current_fig, save_name);
    % Close the figure after saving
    pause(2);
    close(current_fig);
  end
