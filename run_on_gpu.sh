#!/bin/bash
docker run -p 8889:8889 --gpus all -it -v /home/jacek/projects:/projects/ -v /home/jacek/.gitconfig:/root/.gitconfig -v /home/jacek/.ssh:/root/.ssh -v jupyter-gpu-config:/root/.jupyter/ jacekplocharczyk/jupyter:cuda
