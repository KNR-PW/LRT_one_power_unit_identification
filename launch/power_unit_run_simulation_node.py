import os
import subprocess
import time
import json
import csv
import platform

def launch_gazebo_simulation():
    # Open a new terminal and launch Gazebo simulation
    p1 = subprocess.Popen(['gnome-terminal', '--', 'bash', '-c', 'cd meldog-ros &&  source install/local_setup.bash && timeout 13s ros2 launch power_unit_v3 power_unit_v3_optimization.launch.py'])
    time.sleep(13)
    p2 = subprocess.Popen(['gnome-terminal', '--', 'bash', '-c', 'killall ruby'])

if __name__ == '__main__':
    # launch_gazebo_simulation()
    launch_gazebo_simulation()

