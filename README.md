# jupyter-lab-server
This is my environment for playing with ML/RL using PyTorch, jupyter-lab, and Anaconda.
It also includes CUDA 10.0.

## What it contains
This docker image has Anaconda installed with all packages from the `environment.yml` 
and the `requrements.txt` files. 

## Requirements
To set-up everything you need execute the following step:  
1. Create projects directory: `/home/${USER}/projects`
1. Configure your git - [add your name and email](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)  
   (docker requires `/home/${USER}/.gitconfig` directory)
1. Configure your ssh key to use remote git services inside the container - [GitLab example](https://docs.gitlab.com/ee/ssh/)  
   (docker requires `/home/${USER}/.ssh` directory)

### CUDA configuration
If you want to use your CUDA-capable GPU in computations:
1. Make sure you have the latest NVIDIA drivers and Docker 19.03 or higher.
2. Install `nvidia-container-toolkit`:
    ```bash
    # Add the package repositories
    $ distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    $ curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    $ curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
  
    $ sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
    $ sudo systemctl restart docker
    ```
    If you use Ubuntu 19.04 use:
    ```bash
    # Add the package repositories
    $ distribution="ubuntu18.04"
    $ curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    $ curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
  
    $ sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
    $ sudo systemctl restart docker   
    ```

    In case of `docker: Error response from daemon: Unknown runtime specified nvidia.` run:
    ```bash
    $ sudo systemctl daemon-reload
    $ sudo systemctl restart docker
    ```


2. Run `set_up_gpu.sh` to set up local storage for the jupyter configuration  
   (docker-compose isn't compatible with using GPUs inside the docker container)

## Start the container
To start run `docker-compose up -d` in the repo directory. (Non-CUDA Version)  

To start CUDA version run `./run_on_gpu.sh`

## Access the jupyter-lab
Jupyter-lab can be found under the following path http://localhost:8889/

## Stop the container
To stop run `docker-compose down` in the repo directory.

## Customization
If you want to change some of the installed packages you can modify file `environment.yml` and build new image  
```
docker build -t jupyter .
```

You also need to edit `docker-compose.yml` file and change following lines:
```
services:
  vs-code:
    image: jacekplocharczyk/jupyter:latest
```
to
```
services:
  vs-code:
    image: jupyter:latest
```
