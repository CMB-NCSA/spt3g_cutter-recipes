FROM centos:7

ARG MINICONDA_PATH
ARG SPT3G_CUTTER_VERSION=0.2.0

RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install which wget git make
RUN yum -y install fpack screen

# Conda installation, using python38
RUN mkdir -p ${MINICONDA_PATH} \
    && cd ${MINOCONDA_PATH} \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh\
    && chmod +x Miniconda3-py38_4.10.3-Linux-x86_64.sh \
    && ./Miniconda3-py38_4.10.3-Linux-x86_64.sh -b -p ${MINICONDA_PATH} -u

# Start the env and add channels
RUN source $MINICONDA_PATH/bin/activate &&\
    conda config --add channels conda-forge

RUN source $MINICONDA_PATH/bin/activate && \
    conda install -y astropy=4.1 fitsio pandas && \
    conda install -y -c conda-forge esutil pyaml-env && \
    conda install -y -c menanteau spt3g_cutter==${SPT3G_CUTTER_VERSION}

# Add $SPTUSER as user and create groups wheel and spt
ARG UID_NUMBER
ARG SPTUSER
RUN adduser --shell /bin/bash -u $UID_NUMBER $SPTUSER && \
    groupadd --gid 1003 spt

# Make mount directory to mirror /data/spt3g
RUN mkdir -p /data/spt3g && \
    chgrp spt /data/spt3g && \
    chmod g+wrx /data/spt3g

ENV USER $SPTUSER
ENV HOME /home/$SPTUSER
ENV SHELL /bin/bash

COPY docker/startup.sh $HOME/.startup.sh

RUN chmod a+x /home/$SPTUSER/.startup.sh && \
    chown $SPTUSER:$SPTUSER /home/$SPTUSER/.startup.sh

ARG SPTHOME=/home/${SPTUSER}

USER $SPTUSER
WORKDIR /home/$SPTUSER
ENV MINICONDA_PATH ${MINICONDA_PATH}

# Start with conda and spt_cutter initialized
ENTRYPOINT ["sh",".startup.sh"]
