ARG MINICONDA_VERSION=22.11.1

FROM continuumio/miniconda3:${MINICONDA_VERSION} as interactive

ENV WORKDIR=/environment
WORKDIR ${WORKDIR}

COPY . ${WORKDIR}

RUN conda env update --name base --file environment.yml \
    && conda env update --name base --file .bookshelf/environment.interactive.yml

EXPOSE 8888

CMD ["jupyter-lab", "--ip=0.0.0.0", "--allow-root"]

FROM continuumio/miniconda3:${MINICONDA_VERSION} as processing

ENV WORKDIR=/environment
WORKDIR ${WORKDIR}

COPY . ${WORKDIR}

RUN conda env update --name base --file environment.yml \
    && conda env update --name base --file .bookshelf/environment.processing.yml

VOLUME /inputs /outputs

ENTRYPOINT ["papermill", "notebook.ipynb", "/outputs/notebook.ipynb", "--parameters", "OUTPUT_PREFIX", "/outputs",  "--parameters", "INPUT_PREFIX", "/inputs"]
