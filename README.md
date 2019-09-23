# jupyter-lab-server
Hi!  
This is my personal environment for playing with ML/RL using jupyter-lab and anaconda.  

## Requirements
To set-up everything you need execute the following step:  
1. Create projects directory: '/home/<your_username>/projects'

### Kaggle configuration
2. Download your kaggle API token - [instruction here](https://github.com/Kaggle/kaggle-api)
3. Extract `kaggle.json` to '/home/<your_username>/.kaggle' directory and change permisions using
   `chmod 600 ~/.kaggle/kaggle.json`

### CUDA configuration
If you want to use your CUDA-capable GPU in computations:
1. Make sure you have the latest NVIDIA drivers
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
