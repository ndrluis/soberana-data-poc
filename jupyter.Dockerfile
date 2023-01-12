FROM jupyter/scipy-notebook

USER root

RUN apt-get update --yes && \
    apt-get install --yes libpq-dev

USER jovyan
