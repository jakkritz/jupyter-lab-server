# JupyterLab PyTorch FastAI (GPU) with Traefik Reverse Proxy
#### This repos is referenced from [url](https://github.com/jacekplocharczyk/jupyter-lab-server)

1. Start traefik on localhost
```cd traefik```
```docker network create traefik_proxy```
```docker-compose -f docker-compose-local.yml up -d```
```docker volume create jupyter-gpu-config```
or create volume by running
```./set_up_gpu.sh```

2. Build (or pull image from [DockerHub](https://hub.docker.com/r/ppsmart/jupyterlab-torch-fastai))
```docker-compose up -d```
- Note that Dockerfile is using 'th' mirror, change accordingly
- ``` RUN sed --in-place --regexp-extended "s/(\/\/)(archive\.ubuntu)/\1th.\2/" /etc/apt/sources.list && \
     apt-get update && apt-get upgrade --yes
```

3. Clone or subtree or submodule add [fastai repo](https://github.com/Paperspace/fastai-docker/tree/master/fastai-v3)
- ```git subtree add --prefix fastai git@github.com:fastai/course-v3.git master --squash
```
- ```git subtree pull --prefix fastai git@github.com:fastai/course-v3.git master --squash
```

4. Run JupyterLab by
```http://jupyter.localhost```

5. To run on CUDA, use docker command (as opposed to docker-compose)
```./run_on_gpu.sh
# change directory as needed
```
- access JupyterLab by
- ```http://localhost:8889```

6. Dirty trust noteboks
- docker-compose version
- ```docker-compose exec jupyter-lab bash; jupyter trust *.ipynb```
- gpu version
- ```docker exec -ti <container> bash; jupyter trust *.ipynb```

7. You can install jupyter extensions like so.
```
docker exec <container_id> jupyter labextension install jupyterlab_vim
```

8. If you want to keep using the same container so you don't have to sign the notebooks, creat a missing folder, and etc, don't run ```./run_on_gpu``` script. You can simply ```docker start <container_id>```


# Original Readme

# jupyter-lab-server
This is my environment for playing with ML/RL using PyTorch, jupyter-lab, and Anaconda.
It also includes CUDA 10.0.

## What it contains
This docker image has Anaconda installed with all packages from the `environment.yml` 
and the `requrements.txt` files. 

## Requirements
To set-up everything you need execute the following step:  
1. Create projects directory: `/home/${USER}/projects` 1. Configure your git - [add your name and email](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)  
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


### SSL configuration
To add SSL encryption you can use self-signed certificate as follows:

0. ALL THE FOLLOWING STEPS ARE DONE INSIDE THE DOCKER CONTAINER!
1. Add password using `$ jupyter notebook password` command.
2. In the `/root/.jupyter/` directory generate certficate:
   ```bash
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mycert.pem
   ```
3. Add following lines to the `/root/.jupyter/jupyter_notebook_config.json` file:
   ```
   "NotebookApp": {
     "certfile": "/root/.jupyter/mycert.pem",
     "keyfile": "/root/.jupyter/mykey.key"
   }
   ```

Everything will be perserved because of the jupyter `jupyter-gpu-config` volume.

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
