import launch
import launch_ros
import os

from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        # Node(
        #     package='robot_localization',
        #     executable='ekf_node',
        #     name='ekf_filter_node',
        #     output='screen',
        #     parameters=[os.path.join('/home/ngocdai/lidar_ws/src/xsens_node', 'config/ekf.yaml')]
        # ),

        Node(
            package='xsens_node',
            namespace='imu',
            executable='xsens_data_publisher',
            name='xens_pub'
        ),
])