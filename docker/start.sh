#!/bin/bash

xhost +local:

XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

echo "Enter image name:"
read IMAGE_NAME

echo "Enter the full path of the folder to mount in the container:"
read HOST_FOLDER_PATH

CONTAINER_FOLDER_PATH="/path/in/container"  # Change this to your desired path inside the container

docker run -it \
  --user=root \
  --privileged \
  --network=host \
  --privileged \
  --env="DISPLAY=$DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --env="XAUTHORITY=$XAUTH" \
  --volume="$XAUTH:$XAUTH" \
  -v "/dev:/dev" \
  -v "$HOST_FOLDER_PATH:$CONTAINER_FOLDER_PATH" \
  $IMAGE_NAME


