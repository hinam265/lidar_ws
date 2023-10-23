import os

from ament_index_python.packages import get_package_share_directory
from launch.substitutions import Command, LaunchConfiguration

import launch
import launch_ros
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():

    return LaunchDescription([
        #launch.actions.DeclareLaunchArgument(
            #name='use_sim_time',
            #default_value='False',
            #description='Flag to enable'
        #),

        Node(
            package = 'my_bleak',
            namespace = 'odom',
            executable = 'odom_node',
            name = 'odom'
        ),

        Node(
            package = 'my_bleak',
            namespace = 'imu',
            executable = 'bleak_node',
            name = 'imu'
        ),

        #Node(
            #package = 'my_bleak',
            #executable = 'ekf_node',
            #name = 'ekf_filter_node',
            #output = 'screen',
            #parameters = [os.path.join(pkg_share, 'config/ekf.yaml'), {'use_sim_time': LaunchConfiguration('use_sim_time')}]
        #)
    ])
