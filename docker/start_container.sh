#!/bin/bash

# Function to get a Docker image from the list of available images
function get_docker_image() {
    # Get a list of Docker images, skipping the header row, and format them as "REPOSITORY:TAG"
    docker_images="$(docker images | tail -n +2 | awk '{print $1":"$2}')"
    
    # Convert the list of images into a Bash array for easier handling
    IFS=$'\n' read -r -d '' -a items <<< "$docker_images"

    # Display a prompt for selecting an image
    echo "Select an image from the list, or enter its name:" 1>&2

    select item in "${items[@]}"; do
        # Check if the input is a valid selection number
        if [[ "$REPLY" =~ ^[0-9]+$ ]]; then
            if ((REPLY > 0 && REPLY <= ${#items[@]})); then
                echo "${item}"
                exit
            else
                echo "Invalid number" 1>&2
            fi
        else
            # If the input is not a number, it's considered as direct text input
            echo "$REPLY"
            exit
        fi
    done
}

# Allow local connections to the X server for GUI applications in Docker
xhost +local:

# Setup for X11 forwarding to enable GUI
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# List available Docker images for selection
echo "IMAGES:"
docker images
echo "Enter image name:"
IMAGE_NAME=$(get_docker_image)

# Prompt for the host folder to mount in the container
echo "Enter the full path of the folder to mount in the container:"
read HOST_FOLDER_PATH

# Define the container's folder path where the host folder will be mounted
CONTAINER_FOLDER_PATH="/root"  # Consider using a non-root path for better security practices

# Run the Docker container with the selected image and configurations for GUI applications
docker run -it \
  --user=root \
  --privileged \
  --network=host \
  --env="DISPLAY=$DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --env="XAUTHORITY=$XAUTH" \
  --volume="$XAUTH:$XAUTH" \
  -v "/dev:/dev" \
  -v "$HOST_FOLDER_PATH:$CONTAINER_FOLDER_PATH" \
  $IMAGE_NAME

# Notes:
# - The script assumes a certain level of trust with the containers being run, especially with options like --privileged and X11 forwarding.
# - Consider enhancing security measures and validating input paths for better safety in production environments.
