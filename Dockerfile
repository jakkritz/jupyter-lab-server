FROM nvidia/cuda:9.0-base

RUN chsh -s /bin/bash
RUN apt-get update && apt-get install -y libgl1-mesa-glx libegl1-mesa libxrandr2 \
    libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 \
    python-opengl xvfb ffmpeg git unzip wget

RUN mkdir /root/.conda && \
    wget -q https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh && \
    chmod +x  Anaconda3-2019.07-Linux-x86_64.sh && \ 
    bash Anaconda3-2019.07-Linux-x86_64.sh -b

ENV PATH="/root/anaconda3/bin:/root/anaconda3/condabin:${PATH}"

COPY environment.yml .
COPY requirements.txt .

RUN conda env update --file environment.yml

# gym cannot be installed via conda
RUN pip install -r requirements.txt

RUN jupyter labextension install @ryantam626/jupyterlab_code_formatter && \
    jupyter serverextension enable --py jupyterlab_code_formatter

RUN mkdir /projects && mkdir /root/.kaggle && mkdir /root/.ssh
WORKDIR /projects
ENV SHELL="/bin/bash"

ENTRYPOINT xvfb-run -s "-screen 0 1400x900x24" jupyter-lab --ip 0.0.0.0 --port 8889 --allow-root --LabApp.token=''
