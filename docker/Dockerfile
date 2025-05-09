FROM ubuntu:24.04

ARG SPT3G_CUTTER_VERSION
ARG UID_NUMBER=1006
ARG SPTUSER=sptworker
ARG SPTHOME=/home/${SPTUSER}

RUN apt-get update --fix-missing
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get update --fix-missing
RUN apt-get install -y wget emacs git
RUN apt-get install -y screen time
RUN apt-get install -y libcfitsio-bin

# Astropy/numpy/scipy
RUN apt-get install -y python3-numpy python3-scipy python3-astropy python3-numexpr
RUN apt-get install -y screen time
RUN apt-get install -y python-is-python3
RUN apt-get install -y python3-healpy python3-fitsio python3-pandas python3-yaml python3-magic python3-sphinx python3-matplotlib
# This trick install distutils under the hood
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-pyaml-env python3-psutil

RUN mkdir -p /opt/spt \
    && cd /opt/spt
WORKDIR /opt/spt

RUN git clone https://github.com/CMB-NCSA/spt3g_cutter -b $SPT3G_CUTTER_VERSION

# Add $SPTUSER as user and create groups wheel and spt
RUN adduser --uid ${UID_NUMBER} --home ${SPTHOME} --shell /bin/bash ${SPTUSER} && \
    groupadd --gid 1003 spt

RUN mkdir -p /data/spt3g && \
    chgrp spt /data/spt3g && \
    chmod g+wrx /data/spt3g

COPY docker/setSPTEnv.sh /opt/spt/setSPTEnv.sh

USER ${SPTUSER}
WORKDIR ${SPTHOME}

# Set environment in the container
ENV PRODUCT_DIR="/opt/spt/spt3g_cutter"
ENV SPT3G_CUTTER_DIR=${PRODUCT_DIR}
ENV PYTHONPATH=${PRODUCT_DIR}/python:${PYTHONPATH}
ENV PATH=${PRODUCT_DIR}/bin:${PATH}

# Start with the right miniconda environment
RUN cat /opt/spt/setSPTEnv.sh >> $HOME/.bashrc
