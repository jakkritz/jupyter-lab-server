#!/bin/bash
docker run -p 8888:8888 --gpus all -it \
    -v /home/jakkrit/Desktop/jupyter-lab-server/projects:/projects \
    -v /home/jakkrit/.gitconfig:/root/.gitconfig \
    -v /home/jakkrit/.ssh:/root/.ssh \
    -v jupyter-gpu-config:/root/.jupyter/ ppsmart/jupyterlab-torch-fastai:latest \
