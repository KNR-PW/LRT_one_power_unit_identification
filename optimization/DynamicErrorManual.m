clear;
clc;
close all;
%LOAD REAL .TXT FILE
RealFile = '/home/niuniek/OPTYMALIZACJA/przebiegi/final_adjusted_triangle.txt';
RealValues = readmatrix(RealFile);

% Extract columns into separate variables
Real_time = RealValues(:, 1);       % Time in seconds
Real_position_rad = RealValues(:, 2)/9.97*2*pi;  % Position in radians
Real_velocity_ms = RealValues(:, 3)/9.97*2*pi;   % Velocity in rad/s
Real_torque = RealValues(:, 4);    % Torque in Nm

Gazebo_File = "/home/niuniek/OPTYMALIZACJA/przebiegi/symulowany.txt";

Gazebo_data = readmatrix(Gazebo_File);  % Read entire matrix from Gazebo file

Gazebo_time = Gazebo_data(:, 1);                         % Extract time from first column
Gazebo_position_rad = Gazebo_data(:, 2);                 % Extract position from second column
Gazebo_velocity_ms = Gazebo_data(:, 3);                  % Extract velocity from second column
GazeboValues=[Gazebo_time,Gazebo_position_rad,Gazebo_velocity_ms];

    %PLOTS
    plot(Real_time,Real_position_rad,'DisplayName','Real position',LineWidth=1.0)
    hold on
    plot(Real_time,Real_velocity_ms,'DisplayName','Real Velocity')
    % hold on
    plot(Gazebo_time,Gazebo_position_rad,'DisplayName', 'Gazebo Position',LineWidth=1.0)
    hold on
    plot(Gazebo_time,Gazebo_velocity_ms,'DisplayName','Gazebo Velocity')
    xlabel("Czas [s]")
    ylabel("Prędkość [rad/s]/Pozycja [rad]")
    % ylabel("Pozycja [rad]")
    grid on;
    title("Uzyskane przebiegi")
    legend


%Count the mean error squared
position_errorsquared=zeros(length(GazeboValues), 1);  %  array to store position error percentages
velocity_errorsquared=zeros(length(GazeboValues), 1);  %  array to store position error percentages
for i = 1:length(RealValues)
   position_errorsquared(i)=(Gazebo_position_rad(i)-Real_position_rad(i)).^2;
   velocity_errorsquared(i)=(Gazebo_velocity_ms(i)-Real_velocity_ms(i)).^2;
end

sum_position_errorsquared=sqrt(sum(position_errorsquared)/length(RealValues));
sum_velocity_errorsquared=sqrt(sum(velocity_errorsquared)/length(RealValues));


disp(['Błąd średniokwadratowy pozycji: ', num2str(sum_position_errorsquared)]);
disp(['Błąd średniokwadratowy prędkości: ', num2str(sum_velocity_errorsquared)]);
%Add annotation to the chart    

