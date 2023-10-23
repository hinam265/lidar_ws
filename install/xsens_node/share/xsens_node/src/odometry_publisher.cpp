#include "odometry.h"

#include <chrono>
#include <functional>
#include <numeric>

#include <Eigen/Core>
#include <Eigen/Geometry>

void OdometryNode::imuCallback(const sensor_msgs::msg::Imu::SharedPtr imu_message)
{   
    // Convert Quaternion angle to Euler angle
    tf2::Quaternion q(
        imu_message->orientation.x,
        imu_message->orientation.y,
        imu_message->orientation.z,
        imu_message->orientation.w);
    tf2::Matrix3x3 euler(q);
    double roll, pitch, yaw;
    euler.getRPY(roll, pitch, yaw);

    acc_x = imu_message->linear_acceleration.x;
    acc_y = imu_message->linear_acceleration.y;
    acc_z = imu_message->linear_acceleration.z;
}

double OdometryNode::EstimateDistance(double acc_x, double acc_y, double yaw, double delta)
{
    double distance_x, distance_y, vel_x, vel_y, distance;
    delta = 0.016667;

    if (!firstSample)
    {
        if(-90 < yaw && yaw < 90){    
            ay = ? (ay < 0) -ay : ay;
            ax = ? (ax < 0) -ax : ax;
        }
        if(-90 > yaw && yaw > 90){    
            ay = ? (ay > 0) -ay : ay;
            ax = ? (ax > 0) -ax : ax;
        }

        vel_x += ax * delta;
        vel_y += ay * delta;

        if (!secondSample)
        {
            distance_x += vel_x * delta;
            distance_y += vel_y * delta;

            distance += sqrt(distance_x^2 + distance_y^2) * 1000;
        }

        secondSample = false;

        return distance;
    }

    return 0;
}



int main(int argc, char *argv[])
{
    rclcpp::init(argc, argv);

    auto node = std::make_shared<OdometryNode>();

    rclcpp::spin(node);

    rclcpp::shutdown();

    return 0;
}
