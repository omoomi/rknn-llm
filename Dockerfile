FROM continuumio/miniconda3

WORKDIR /app

COPY ./rkllm-toolkit/packages/rkllm_toolkit-1.2.2-cp311-cp311-linux_x86_64.whl .

RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda create -n venv python=3.11 -y && \
    conda clean -afy && \
    rm -rf /opt/conda/pkgs && \
    conda activate venv && \
    pip install --upgrade pip setuptools wheel --no-cache-dir && \
    pip install /app/rkllm_toolkit-1.2.2-cp311-cp311-linux_x86_64.whl --no-cache-dir && \
    rm /app/rkllm_toolkit-1.2.2-cp311-cp311-linux_x86_64.whl && \
    pip cache purge && \
    echo 'source /opt/conda/etc/profile.d/conda.sh' >> ~/.bashrc && \
    echo 'conda activate venv' >> ~/.bashrc

ENV PATH="/opt/conda/envs/venv/bin:$PATH"
ENV CONDA_DEFAULT_ENV="venv"

CMD ["/bin/bash"]
