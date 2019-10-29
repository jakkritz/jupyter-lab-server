FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04

RUN chsh -s /bin/bash

RUN sed --in-place --regexp-extended "s/(\/\/)(archive\.ubuntu)/\1th.\2/" /etc/apt/sources.list && \
	apt-get update && apt-get upgrade --yes

RUN apt-get update --fix-missing && apt-get install -y libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 python-opengl xvfb ffmpeg git unzip wget

RUN mkdir /root/.conda && \
    wget -q https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh && \
    chmod +x  Anaconda3-2019.10-Linux-x86_64.sh && \ 
    bash Anaconda3-2019.10-Linux-x86_64.sh -b

ENV PATH="/root/anaconda3/bin:/root/anaconda3/condabin:${PATH}"

COPY environment.yml .
COPY requirements.txt .

RUN conda env update --file environment.yml
RUN conda clean --all -f -y

# gym cannot be installed via conda
RUN pip install -r requirements.txt
RUN jupyter labextension install @ryantam626/jupyterlab_code_formatter && \
    jupyter serverextension enable --py jupyterlab_code_formatter && jupyter labextension install jupyterlab_vim

RUN mkdir /projects && mkdir -p /projects/notebooks && mkdir /root/.kaggle && mkdir /root/.ssh && mkdir -p /root/.cache/black/19.3b0

WORKDIR /projects

ENV SHELL="/bin/bash"

CMD /bin/bash -c "jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/projects --allow-root"
