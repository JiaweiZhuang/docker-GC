# Build the basic C and Fortran compiler. Not yet the NetCDF lib.
FROM ubuntu:latest
MAINTAINER Jiawei Zhuang <jiaweizhuang@g.harvard.edu>

# Note:
# build-essential contains gcc, g++ and GNU make
# m4 is the prerequisite for NetCDF  
# apt (not apt-get) fails for unknown reasons
RUN apt-get update -y && \
    apt-get install -y build-essential gfortran m4 wget vim

# avoid logging in as root
RUN mkdir /home/GC && \
    useradd GC -d /home/GC && \
    chown -R GC:GC /home/GC

USER GC
ENV HOME /home/GC

# choose the default option during installation processes
ENV DEBIAN_FRONTEND noninteractive

# the default directory 
WORKDIR $HOME

# default compilers
ENV CC gcc
ENV CXX g++
ENV FC gfortran
ENV F90 $FC
ENV F9X $FC
ENV F77 $FC

COPY bashrc_template $HOME/.bashrc
