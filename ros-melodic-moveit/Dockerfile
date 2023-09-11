# Build:
#  docker build --rm -f Dockerfile -t gramaziokohler/ros-noetic-moveit .
#
# Usage:
#  docker pull gramaziokohler/ros-noetic-moveit

FROM augmentedfabricationlab/ros-melodic-base
LABEL maintainer "Gido Dielemans <gido.dielemans@tum.de>"

SHELL ["/bin/bash","-c"]

ENV CATKIN_WS=/root/catkin_ws

# All apt-get commands start with an update, then install
# and finally, a cache cleanup to keep the image size small.

# MoveIt
RUN echo "Install MoveIt" \
    && source /opt/ros/${ROS_DISTRO}/setup.bash \
    && apt-get update && apt-get -y upgrade \
    # ROS MoveIt
    && apt-get install -y ros-${ROS_DISTRO}-moveit --no-install-recommends \    
    && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=noninteractive

# Add robot packages to local catkin workspace
RUN echo "Building common MoveIt Planners" \
    && source /opt/ros/${ROS_DISTRO}/setup.bash \
    && apt-get update && apt-get -y upgrade \
    # UR packages
    && git clone https://github.com/UniversalRobots/Universal_Robots_ROS_Driver \
    && git clone -b melodic-devel https://github.com/ros-industrial/universal_robot.git \
    # Install dependencies
    && cd $CATKIN_WS \
    && rosdep install -y --from-paths . --ignore-src --rosdistro ${ROS_DISTRO} \
    # Build catkin workspace
    && catkin_make \
    && rm -rf /var/lib/apt/lists/*
