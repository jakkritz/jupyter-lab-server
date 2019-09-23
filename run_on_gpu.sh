#!/bin/bash
docker run -p 8889:8889 --gpus all -it -v /home/jacek/projects:/projects/ -v jupyter-gpu-config:/root/.jupyter/ jacekplocharczyk/jupyter:cuda
