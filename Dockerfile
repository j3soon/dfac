ARG DOCKER_BASE
FROM $DOCKER_BASE
ARG DEVICE

# CUDA includes
ENV CUDA_PATH /usr/local/cuda
ENV CUDA_INCLUDE_PATH /usr/local/cuda/include
ENV CUDA_LIBRARY_PATH /usr/local/cuda/lib64

# Ubuntu Packages
RUN apt-get update -y && apt-get install software-properties-common -y && \
    add-apt-repository -y multiverse && apt-get update -y && apt-get upgrade -y && \
    apt-get install -y apt-utils nano vim man build-essential wget sudo && \
    rm -rf /var/lib/apt/lists/*

# Install curl and other dependencies
RUN apt-get update -y && apt-get install -y curl libssl-dev openssl libopenblas-dev \
    libhdf5-dev hdf5-helpers hdf5-tools libhdf5-serial-dev libprotobuf-dev protobuf-compiler git

# Install python3 pip3
RUN apt-get update
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN pip3 install --upgrade pip

# Python packages we use (or used at one point...)
RUN pip3 install numpy scipy pyyaml matplotlib
RUN pip3 install imageio
RUN pip3 install tensorboard-logger
RUN pip3 install pygame

RUN pip3 install jsonpickle==0.9.6

WORKDIR /root
# install Sacred (from OxWhirl fork)
RUN pip3 install setuptools
RUN pip3 install munch
COPY sacred /root/sacred
RUN cd /root/sacred && python3 setup.py install

#### -------------------------------------------------------------------
#### install pytorch
#### -------------------------------------------------------------------
RUN pip3 install torch
RUN pip3 install torchvision snakeviz pytest probscale

RUN pip3 install pysc2

## -- SMAC
COPY smac /root/smac
RUN cd /root/smac && pip3 install .
COPY StarCraftII /root/StarCraftII
COPY smac/smac/env/starcraft2/maps/SMAC_Maps /root/StarCraftII/Maps/SMAC_Maps
ENV SC2PATH /root/StarCraftII

RUN apt-get update && apt-get install -y mesa-utils x11-xserver-utils
# COPY pymarl /root/pymarl

WORKDIR '/root'