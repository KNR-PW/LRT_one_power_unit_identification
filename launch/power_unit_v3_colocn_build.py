import os
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import xml.etree.ElementTree as ET

class MyHandler(FileSystemEventHandler):
    def __init__(self):
        self.last_modified = 0

    def on_modified(self, event):
        current_time = time.time()
        if event.src_path.endswith("power_unit_v3.urdf.xacro") and current_time - self.last_modified > 1:
            self.last_modified = current_time
            # Change directory to ~/Humanoid_workspace and build the specific package
            workspace_dir = os.path.expanduser('~/meldog-ros')
            if os.path.isdir(workspace_dir):
                os.chdir(workspace_dir)
                # Run colcon build command for the specified package
                command = 'colcon build --packages-select power_unit_v3'
                os.system(command)
                print(f"Built package 'power_unit_v3' in {workspace_dir}.")
            else:
                print(f"Error: Workspace directory not found at {workspace_dir}.")

def monitor_file_changes():
    # Path to the file to monitor
    file_path = '/home/niuniek/meldog-ros/src/power_unit_v3/description/power_unit_v3.urdf.xacro'
    # Create a watchdog observer
    observer = Observer()
    observer.schedule(MyHandler(), path=os.path.dirname(file_path))
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

if __name__ == "__main__":
    monitor_file_changes()
