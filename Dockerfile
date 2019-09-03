FROM continuumio/anaconda3:latest
RUN apt-get update && apt-get install -y fish unzip && chsh -s /usr/bin/fish
RUN /opt/conda/bin/conda install jupyterlab tensorflow -y --quiet && \
    /opt/conda/bin/conda install -c conda-forge kaggle keras -y --quiet && \
    /opt/conda/bin/conda install pytorch torchvision cudatoolkit=10.0 -c pytorch -y --quiet 
RUN /opt/conda/bin/conda install -c anaconda cudatoolkit -y --quiet
RUN mkdir /projects && mkdir /root/.kaggle
WORKDIR /projects
ENV PATH="/opt/conda/bin:/opt/conda/condabin:${PATH}"
ENV SHELL="/usr/bin/fish"
ENTRYPOINT ["jupyter-lab", "--ip", "0.0.0.0", "--port", "8889", "--allow-root", "--LabApp.token=''"]
