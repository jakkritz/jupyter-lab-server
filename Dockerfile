FROM continuumio/anaconda3:latest

RUN /opt/conda/bin/conda install jupyterlab -y --quiet && \
    /opt/conda/bin/conda install -c conda-forge kaggle  -y --quiet
RUN mkdir /projects && mkdir /root/.kaggle
WORKDIR /projects
ENV PATH="/opt/conda/bin:/opt/conda/condabin:${PATH}"
ENTRYPOINT ["jupyter-lab", "--ip", "0.0.0.0", "--port", "8889", "--allow-root", "--LabApp.token=''"]
