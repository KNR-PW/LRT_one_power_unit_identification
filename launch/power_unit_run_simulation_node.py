import os
import subprocess
import time
import json
import csv
import platform

def launch_gazebo_simulation():
    # Open a new terminal and launch Gazebo simulation
    # subprocess.Popen(['gnome-terminal', '--', 'ros2', 'launch', 'one_dynamixel_simulation', 'MX28AR_gazebo.launch.py'])
    subprocess.Popen(['gnome-terminal', '--', 'bash', '-c', 'cd ~/meldog-ros/ && source install/local_setup.bash && timeout 10s ros2 launch power_unit_v3 power_unit_v3_optimization.launch.py'])
    

def open_terminal_and_run_command(command):
    """
    Opens a new terminal window and runs a command.

    Parameters:
    - command (str): The command to run in the new terminal.
    """
    os_type = platform.system()

    if os_type == "Windows":
        # On Windows, use `start` to open a new terminal and run the command
        subprocess.run(["cmd", "/c", f"start cmd /k {command}"])
    elif os_type in ("Linux", "Darwin"):  # Darwin is macOS
        # On Linux, use `terminator` terminal emulator
        try:
            subprocess.run(["terminator", "-e", f"bash -c \"{command} ; exec bash\""])
        except FileNotFoundError:
            print("Terminator is not installed. Please install it using 'sudo apt install terminator' or adjust the script.")
    else:
        print(f"Unsupported operating system: {os_type}")

# def send_joint_trajectory_command():
#     # Wait for sending the joint trajectory command
#     time.sleep(4)

#     # Open a new terminal and send the joint trajectory command
#     trajectory = {
#         "trajectory": {
#             "joint_names": ['joint1'],
#             "points": [
#                 {"positions": [0.0], "time_from_start": {"sec": 1}},
#                 {"positions": [-1.5708], "time_from_start": {"sec": 3}}
#             ]
#         }
#     }

#     # Convert the trajectory dictionary to a JSON-formatted string
#     trajectory_json = json.dumps(trajectory)

#     subprocess.Popen(['gnome-terminal', '--','ros2', 'action', 'send_goal', '/joint_trajectory_controller/follow_joint_trajectory', 'control_msgs/action/FollowJointTrajectory', '-f', trajectory_json])

# def save_trajectory_data(feedback_file_path):
#     # Open a new process to execute the ROS command and capture output
#     with open(feedback_file_path, 'w') as output_file:
#         process = subprocess.Popen(
#             ['ros2', 'topic', 'echo', '--csv', '/joint_states'],
#             stdout=output_file,
#             stderr=subprocess.PIPE,
#             universal_newlines=True
#         )
#         time.sleep(10)       
#         # Terminate the subprocess after the specified duration
#         process.terminate()

if __name__ == '__main__':
    launch_gazebo_simulation()
    # open_terminal_and_run_command('cd ~/meldog-ros/ && source install/local_setup.bash && timeout 10s ros2 launch power_unit_v3 power_unit_v3_optimization.launch.py')
    # send_joint_trajectory_command()
    # output_csv_file = '/home/jaku6m/Desktop/OPTYMALIZACJA/OptcsvGazeboFiles/feedback_data.csv'  # Path to the output CSV file
    # Send the joint trajectory command and capture feedback
    # send_joint_trajectory_command() 
    # save_trajectory_data(output_csv_file)

