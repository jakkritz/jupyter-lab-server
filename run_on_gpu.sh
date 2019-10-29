#!/bin/bash
docker run -p 8889:8889 --gpus all -it \
    -v /home/jakkrit/Desktop/jupyter-lab-server/fastai/nbs/dl1:/projects/fastai/dl1 \
    -v /home/jakkrit/Desktop/jupyter-lab-server/fastai/nbs/dl2:/projects/fastai/dl2 \
    -v /home/jakkrit/Desktop/jupyter-lab-server/notebooks:/projects/notebooks \
    -v /home/jakkrit/.gitconfig:/root/.gitconfig \
    -v /home/jakkrit/.ssh:/root/.ssh \
    -v jupyter-gpu-config:/root/.jupyter/ ppsmart/jupyterlab-torch-fastai:latest \
    --restart=always
