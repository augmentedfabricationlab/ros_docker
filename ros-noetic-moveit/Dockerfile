# Build:
#  docker build --rm -f Dockerfile --build-arg FROM_IMAGE_TAG=${TAG} -t gramaziokohler/ros-noetic-moveit:${TAG} .
#
# Usage:
#  docker pull gramaziokohler/ros-noetic-moveit

ARG FROM_IMAGE_TAG

FROM augmentedfabricationlab/ros-noetic-base:latest
LABEL maintainer "Gido Dielemans <gido.dielemans@tum.de>"

SHELL ["/bin/bash","-c"]

ENV CATKIN_WS=/root/catkin_ws
WORKDIR $CATKIN_WS/src
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
    && apt-get -y update && apt-get -y upgrade \
    && apt update apt-transport-https \
    # Add Bio-IK kinematic solver
    # && git clone https://github.com/TAMS-Group/bio_ik.git \
    # UR packages
    && git clone -b noetic-devel https://github.com/ros-industrial/universal_robot.git \
    # ABB packages (abb_driver only included because some other packages reference it, but we don't use it)
    && git clone https://github.com/ros-industrial/abb.git \
    && git clone https://github.com/ros-industrial/abb_driver.git \
    && git clone https://github.com/ros-industrial/abb_experimental.git \
    # && git clone https://github.com/gramaziokohler/abb_irb1600_8_145_moveit_config \
    # && git clone https://github.com/gramaziokohler/abb_irb4600_40_255.git \
    # && git clone -b noetic-devel https://github.com/gramaziokohler/abb_irb4600_40_255_moveit_config.git \
    # && git clone https://github.com/gramaziokohler/abb_irb4600_60_205.git \
    # && git clone -b noetic-devel https://github.com/gramaziokohler/abb_irb4600_60_205_moveit_config.git \
    && git clone https://github.com/gramaziokohler/abb_crb15000_5_95_moveit_config.git 
    # && git clone -b noetic-devel https://github.com/gramaziokohler/rfl_description.git \
    # Panda packages
    # && git clone -b master https://github.com/ros-planning/moveit_tutorials.git \
    # && git clone -b noetic-devel https://github.com/moveit/panda_moveit_config.git \
    # Kuka packages
    # && git clone https://github.com/ros-industrial/kuka.git \
    # && git clone https://github.com/ros-industrial/kuka_experimental.git \
    # && git clone https://github.com/gramaziokohler/kr6r900sixx_moveit_config \

RUN echo "Install dependencies" \
    && source /opt/ros/${ROS_DISTRO}/setup.bash \
    && apt-get update && apt-get -y upgrade \    
    && cd $CATKIN_WS \
    && rosdep install -y --from-paths . --ignore-src --skip-keys="abb_driver gazebo" --rosdistro ${ROS_DISTRO} \
    # Build catkin workspace
    && catkin_make -j1 -l1\
    && rm -rf /var/lib/apt/lists/*
