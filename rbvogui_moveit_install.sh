#!/bin/bash


source /opt/ros/noetic/setup.bash
apt-get -y update 
apt-get -y upgrade
# apt update apt-transport-https
apt-get install -y ros-noetic-moveit --no-install-recommends
apt-get install -y libserial-dev wget
# apt-get install -y ros-noetic-descartes
mkdir -p AfabWorkspace/src
cd AfabWorkspace/src
source /opt/ros/${ROS_DISTRO}/setup.bash
echo "prep done. cloning repos..."

git clone https://github.com/gramaziokohler/ros_file_server.git
git clone https://github.com/TAMS-Group/bio_ik.git
# UR packages
git clone -b calibration_devel https://github.com/fmauch/universal_robot.git
# ABB packages (abb_driver only included because some other packages reference it, but we don't use it)
# git clone https://github.com/ros-industrial/abb.git
git clone https://github.com/ros-industrial/abb_driver.git
# git clone https://github.com/ros-industrial/abb_experimental.git
# git clone https://github.com/gramaziokohler/abb_irb1600_8_145_moveit_config
# git clone https://github.com/gramaziokohler/abb_irb4600_40_255.git
# git clone -b noetic-devel https://github.com/gramaziokohler/abb_irb4600_40_255_moveit_config.git
# git clone https://github.com/gramaziokohler/abb_irb4600_60_205.git
# git clone -b noetic-devel https://github.com/gramaziokohler/abb_irb4600_60_205_moveit_config.git
# git clone https://github.com/gramaziokohler/abb_crb15000_5_95_moveit_config.git
git clone -b noetic-devel https://github.com/gramaziokohler/rfl_description.git
# Panda packages
# git clone -b master https://github.com/ros-planning/moveit_tutorials.git
# git clone -b noetic-devel https://github.com/ros-planning/panda_moveit_config.git
# Kuka packages
# git clone https://github.com/ros-industrial/kuka.git
# git clone https://github.com/ros-industrial/kuka_experimental.git
# git clone https://github.com/gramaziokohler/kr6r900sixx_moveit_config.git
git clone -b noetic-devel https://github.com/ros/xacro.git
# git clone -b noetic-devel https://github.com/RobotnikAutomation/rbvogui_common.git
git clone -b melodic-devel-desc-only https://github.com/gidodielemans/rbvogui_common
git clone -b melodic-devel https://github.com/RobotnikAutomation/robotnik_sensors.git
# git clone https://github.com/RobotnikAutomation/velodyne_simulator.git
git clone https://github.com/RobotnikAutomation/robotnik_msgs.git
git clone https://github.com/RobotnikAutomation/ewellix_description.git
git clone https://github.com/augmentedfabricationlab/robotic_setups_description.git
# git clone https://github.com/utexas-bwi/eband_local_planner.git

echo "cloning done."

cd ..
rosdep install -y --from-paths . --ignore-src --skip-keys="abb_driver gazebo" --rosdistro ${ROS_DISTRO}
# Build catkin workspace
catkin_make