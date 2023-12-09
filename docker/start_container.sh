#!/bin/bash

function get_docker_image() {
    docker_images="$(docker images | tail -n +2 | awk '{print $1":"$2}')"
    # Convert the variable into a Bash array
    IFS=$'\n' read -r -d '' -a items <<< "$docker_images"

    # Display the menu
    echo "Select an image from the list, or enter its name:" 1>&2

    select item in "${items[@]}"; do
        # Check if input is a number within the range of the menu
        if [[ "$REPLY" =~ ^[0-9]+$ ]]; then
            if ((REPLY > 0 && REPLY <= ${#items[@]})); then
                echo "${item}"
                exit
            else
                echo "Invalid number" 1>&2
            fi
        else
            # If the input is not a number, assume it's text
            echo "$REPLY"
            exit
        fi
    done
}

xhost +local:

XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

echo IMAGES:
docker images
echo "Enter image name:"
IMAGE_NAME=$(get_docker_image)

echo "Enter the full path of the folder to mount in the container:"
read HOST_FOLDER_PATH

CONTAINER_FOLDER_PATH="/root"  # Change this to your desired path inside the container

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



