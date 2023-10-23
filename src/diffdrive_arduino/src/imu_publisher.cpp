#include <memory>
#include <string>
#include <iostream>
#include <iomanip>


#include "rclcpp/rclcpp.hpp"
#include "xsens_library/xdpchandler.h"
#include "sensor_msgs/msg/imu.hpp"

using namespace std;
bool scan_flag = false;

class XsensPublisher : public rclcpp::Node
{
    public:
        XsensPublisher()
        : Node("xsens_publisher"), count_(0)
        {
            publisher_ = this->create_publisher<sensor_msgs::msg::Imu>("imu_data", 10);
            timer_ = this->create_wall_timer(
            500ms, std::bind(&XsensPublisher::timer_callback, this));
        }

    private:
        XdpcHandler xdpcHandler;
        void GetData();
        bool scanForBluetoothDevices();

        void timer_callback()
        {
            scan_flag = scanForBluetoothDevices();
            if(scan_flag)
            {
                GetData();
            }
        }

        rclcpp::TimerBase::SharedPtr timer_;
        rclcpp::Publisher<sensor_msgs::msg::Imu>::SharedPtr publisher_;
        size_t count_;

};

bool XsensPublisher::scanForBluetoothDevices()
{
    if (!xdpcHandler.initialize())
    {
        cout << "Failed to initialize XdpcHandler." << endl;
        return false;
    }

    xdpcHandler.scanForDots();

    if (xdpcHandler.detectedDots().empty())
    {
        cout << "No Movella DOT device(s) found." << endl;
        xdpcHandler.cleanup();
        return false;
    }

    xdpcHandler.connectDots();

    if (xdpcHandler.connectedDots().empty())
    {
        cout << "Could not connect to any Movella DOT device(s). Aborting." << endl;
        xdpcHandler.cleanup();
        return false;
    }


    for (auto const& device : xdpcHandler.connectedDots())
    {
        
        if (!device->startMeasurement(XsPayloadMode::CompleteQuaternion))
        {
            cout << "Could not put device into measurement mode. Reason: " << device->lastResultText() << endl;
            continue;
            return false;
        }
    }

    return true;
}

void XsensPublisher::GetData()
{
    int64_t startTime = XsTime::timeStampNow();
    bool orientationResetDone = false;

    while (scan_flag)
    {
        if (xdpcHandler.packetsAvailable())
        {
            cout << "\r";
            for (auto const& device : xdpcHandler.connectedDots())
            {
                XsDataPacket packet = xdpcHandler.getNextPacket(device->bluetoothAddress());

                if (!orientationResetDone && (XsTime::timeStampNow() - startTime) > 4000)
                {
                    for (auto const& device : xdpcHandler.connectedDots())
                    {
                        cout << endl << "Resetting heading for device " << device->bluetoothAddress() << ": ";
                        if (device->resetOrientation(XRM_Heading))
                            cout << "OK";
                        else
                            cout << "NOK: " << device->lastResultText();
                    }
                    cout << endl;
                    orientationResetDone = true;
                }

                auto imu_msgs = sensor_msgs::msg::Imu();
                imu_msgs.header.stamp = this->get_clock()->now();
                imu_msgs.header.frame_id = 'base_link';

                if (packet.containsOrientation())
                {
                    XsQuaternion quat = packet.orientationQuaternion();

                    imu_msgs.orientation.x = quat.x();
                    imu_msgs.orientation.y = quat.y();
                    imu_msgs.orientation.z = quat.z();
                    imu_msgs.orientation.w = quat.w();
                }	

                if (packet.containsFreeAcceleration())
                {
                    XsVector freeAcc = packet.freeAcceleration();     
                    
                    // Create a vector to store the converted float numbers.
                    vector<float> float_array(3);

                    // Copy the XsReal data to the float vector.
                    copy(freeAcc.data(), freeAcc.data() + 3, float_array.data());

                    imu_msgs.linear_acceleration.x = float_array[0];
                    imu_msgs.linear_acceleration.y = float_array[1];
                    imu_msgs.linear_acceleration.z = float_array[2];

                }

                publisher_->publish(imu_msgs);
            }
        }   
    
        XsTime::msleep(0);
    }
    cout << endl;

    cout << "Stopping measurement..." << endl;
    for (auto device : xdpcHandler.connectedDots())
    {
        if (!device->stopMeasurement())
             cout << "Failed to stop measurement.";
    }
    xdpcHandler.cleanup();
    rclcpp::shutdown();

}

void signalHandler(int) {
    scan_flag = false;
}

int main(int argc, char * argv[]) {
  rclcpp::init(argc, argv);

  signal(SIGINT, signalHandler);

  rclcpp::spin(std::make_shared<XsensPublisher>());
  rclcpp::shutdown();

  return 0;
}

