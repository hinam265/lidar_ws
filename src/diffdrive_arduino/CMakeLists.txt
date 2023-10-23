cmake_minimum_required(VERSION 3.16)
project(diffdrive_arduino LANGUAGES CXX)

if(CMAKE_CXX_COMPILER_ID MATCHES "(GNU|Clang)")
  add_compile_options(-Wall -Wextra)
endif()

# find dependencies
find_package(ament_cmake_python REQUIRED)
find_package(ament_cmake REQUIRED)
find_package(xsens_library REQUIRED)
find_package(nav_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(yaml_cpp_vendor REQUIRED)
find_package(tf2_geometry_msgs REQUIRED)

# find dependencies
set(THIS_PACKAGE_INCLUDE_DEPENDS
  hardware_interface
  pluginlib
  rclcpp
  rclcpp_lifecycle
)

# find dependencies
foreach(Dependency IN ITEMS ${THIS_PACKAGE_INCLUDE_DEPENDS})
  find_package(${Dependency} REQUIRED)
endforeach()

# let the compiler search for headers in the include folder
set(MOVELLA_INSTALL_PREFIX /usr/local/movella/)
include_directories(${MOVELLA_INSTALL_PREFIX}/include ${MOVELLA_INSTALL_PREFIX}/include/movelladot_pc_sdk ${CMAKE_CURRENT_SOURCE_DIR}/include/diffdrive_arduino)
link_directories(${MOVELLA_INSTALL_PREFIX}/lib)

add_executable(imu_pub src/imu_publisher.cpp)
add_executable(imu_rec src/imu_receiver.cpp)

ament_target_dependencies(imu_pub xsens_library rclcpp std_msgs sensor_msgs)
ament_target_dependencies(imu_rec xsens_library rclcpp std_msgs sensor_msgs)

# install the executable in the lib folder to make it detectable through setup.bash
install(TARGETS
  imu_pub
  imu_rec
  DESTINATION lib/${PROJECT_NAME}/
)

## COMPILE
add_library(
  diffdrive_arduino
  SHARED
  hardware/diffbot_system.cpp
)
target_compile_features(diffdrive_arduino PUBLIC cxx_std_17)
target_include_directories(diffdrive_arduino PUBLIC
$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/hardware/include>
$<INSTALL_INTERFACE:include/diffdrive_arduino>
)
ament_target_dependencies(
  diffdrive_arduino PUBLIC
  ${THIS_PACKAGE_INCLUDE_DEPENDS}
)

target_link_libraries(diffdrive_arduino PUBLIC serial)

# Causes the visibility macros to use dllexport rather than dllimport,
# which is appropriate when building the dll but not consuming it.
target_compile_definitions(${PROJECT_NAME} PRIVATE "DIFFDRIVE_ARDUINO_BUILDING_DLL")

# Export hardware plugins
pluginlib_export_plugin_description_file(hardware_interface diffdrive_arduino.xml)

# INSTALL
install(
  DIRECTORY hardware/include/
  DESTINATION include/diffdrive_arduino
)
install(
  DIRECTORY description/launch description/ros2_control description/urdf description/rviz
  DESTINATION share/diffdrive_arduino
)
install(
  DIRECTORY bringup/launch bringup/config
  DESTINATION share/diffdrive_arduino
)
install(TARGETS diffdrive_arduino
  EXPORT export_diffdrive_arduino
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

if(BUILD_TESTING)
  find_package(ament_cmake_gtest REQUIRED)
endif()

## EXPORTS
ament_export_targets(export_diffdrive_arduino HAS_LIBRARY_TARGET)
ament_export_dependencies(${THIS_PACKAGE_INCLUDE_DEPENDS})
ament_package()
