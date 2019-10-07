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
1. Make sure you have the latest NVIDIA drivers
2. Run `set_up_gpu.sh` to set up local storage for the jupyter configuration  
   (docker-compose isn't compatible with using GPUs inside the docker container)


### SSL configuration
To add SSL encryption you can use self-signed certificate as follows:
0. ALL THE FOLLOWING STEPS ARE DONE INSIDE DOCKER CONTAINER!
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
