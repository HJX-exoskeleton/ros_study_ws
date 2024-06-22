#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/hjx/ros_study_ws/src/demo3/src/arbotix_ros/arbotix_python"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/hjx/ros_study_ws/src/demo3/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/hjx/ros_study_ws/src/demo3/install/lib/python3/dist-packages:/home/hjx/ros_study_ws/src/demo3/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/hjx/ros_study_ws/src/demo3/build" \
    "/home/hjx/anaconda3/envs/hjx/bin/python3" \
    "/home/hjx/ros_study_ws/src/demo3/src/arbotix_ros/arbotix_python/setup.py" \
    egg_info --egg-base /home/hjx/ros_study_ws/src/demo3/build/arbotix_ros/arbotix_python \
    build --build-base "/home/hjx/ros_study_ws/src/demo3/build/arbotix_ros/arbotix_python" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/hjx/ros_study_ws/src/demo3/install" --install-scripts="/home/hjx/ros_study_ws/src/demo3/install/bin"
