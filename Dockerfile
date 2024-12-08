FROM redhat/ubi9-minimal:latest


ENV IMAGE_MAINTAINER="Bartholomaeuss" \
    IMAGE_DECRIPTION="Base Image From Bartholomaeuss For CI Pipelines" \
    IMAGE_DISPLAY_NAME="Base Image" \
    BUILD_TIMESTAMP="${BUILD_TIMESTAMP}" \
    TZ="Europe/Berlin" \
    LANG="de_DE.UTF-8" \
    LANGUAGE="de_DE:de" \
    RUNTIMEUSER=1001 \
    RUNTIMEUSERNAME=pipeline \
    PIPELINE_ROOT_PREFIX=/home/pipeline

USER root

RUN microdnf -y update

RUN microdnf -y install sudo which tar unzip jq
RUN microdnf -y install git shadow-utils

RUN useradd -u "${RUNTIMEUSER}" "${RUNTIMEUSERNAME}"
RUN mkdir "${PIPELINE_ROOT_PREFIX}" -p
RUN touch "${PIPELINE_ROOT_PREFIX}/.bashrc"
RUN chmod -R 777 /tmp
RUN chown -R "${RUNTIMEUSERNAME}" "${PIPELINE_ROOT_PREFIX}"
RUN chown -R "${RUNTIMEUSERNAME}" /tmp

RUN echo "alias ll='ls -alF'" >> "${PIPELINE_ROOT_PREFIX}/.bashrc"
RUN echo "alias la='ls -A'" >> "${PIPELINE_ROOT_PREFIX}/.bashrc"
RUN echo "alias l='ls -CF'" >> "${PIPELINE_ROOT_PREFIX}/.bashrc"

USER ${RUNTIMEUSER}

ENV BASH_ENV=/home/ingest/.bashrc
