# This was taken from https://discourse.ubuntu.com/t/enabling-gpu-acceleration-on-ubuntu-on-wsl2-with-the-nvidia-cuda-platform/26604

# First: Install the appropriate Windows vGPU driver for WSL

# Install NVIDIA CUDA on Ubuntu

sudo apt-key del 7fa2af80

wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin

sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600

sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/3bf863cc.pub

sudo add-apt-repository 'deb https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/ /'

sudo apt-get update

sudo apt-get -y install cuda
