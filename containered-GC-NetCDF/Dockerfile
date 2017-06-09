# Build NetCDF lib based on the base image
FROM zhuangjw/gc-base:latest
MAINTAINER Jiawei Zhuang <jiaweizhuang@g.harvard.edu>

# Install NetCDF4 (along with zlib and HDF5 it needs) from the source code
# Originally written by Seb Eastham

# Set up an installation directory
ENV installDir $HOME/local
ENV srcDir $HOME/src

RUN mkdir $installDir && \
    mkdir $srcDir

# Needed for NetCDF installation
ENV ZDIR $installDir
ENV H5DIR $installDir
ENV NCDIR $installDir
ENV NFDIR $installDir

# NOTE: The installation instructions for HDF5 and NetCDF will show only "make check" and "make install", but this can
# sometimes result in failure due to a bad build order. Running "make -> make check -> make install" is slower but safer.

RUN echo " The following packages will be downloaded and installed:" && \
    echo " ZLib =============> $ZDIR" && \
    echo " HDF5 =============> $H5DIR" && \
    echo " NetCDF-C =========> $NCDIR" && \
    echo " NetCDF-Fortran ===> $NFDIR"

# 1. Install ZLib
RUN echo "Installing ZLib to $ZDIR" && \
    cd $srcDir && \
    mkdir -p zlib && \
    cd zlib && \
    wget -c -nd "http://www.zlib.net/zlib-1.2.11.tar.gz" && \
    tar -xzf zlib-1.2.11.tar.gz && \
    cd zlib-1.2.11 && \
    ./configure --prefix=${ZDIR} && \
    make && \
    make check && \
    make install

# 2. Install HDF5
RUN echo "Installing HDF-5 to $H5DIR" && \
    cd $srcDir && \
    mkdir -p hdf5 && \
    cd hdf5 && \
    wget -c -nd "https://support.hdfgroup.org/ftp/HDF5/current18/src/hdf5-1.8.18.tar.gz" && \
    tar -xzf hdf5-1.8.18.tar.gz && \
    cd hdf5-1.8.18 && \
    ./configure --with-zlib=${ZDIR} --prefix=${H5DIR} && \
    make && \
    make check && \
    make install

# Add HDF5 libraries to LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH ${H5DIR}/lib:${LD_LIBRARY_PATH}

# 3. Install NetCDF-C
RUN echo "Installing NetCDF-C to $NCDIR" && \
    cd $srcDir && \
    mkdir -p netcdf-c && \
    cd netcdf-c && \
    wget -c -nd "ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.4.1.1.tar.gz" && \
    tar -xzf netcdf-4.4.1.1.tar.gz && \
    cd netcdf-4.4.1.1 && \
    CPPFLAGS=-I${H5DIR}/include LDFLAGS=-L${H5DIR}/lib ./configure --prefix=${NCDIR} && \
    make && \
    make check && \
    make install

# 4. Install NetCDF-Fortran
RUN echo "Installing NetCDF-Fortran to $NFDIR" && \
    cd $srcDir && \
    mkdir -p netcdf-fortran && \
    cd netcdf-fortran && \
    wget -c -nd "ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.4.tar.gz" && \
    tar -xzf netcdf-fortran-4.4.4.tar.gz && \
    cd netcdf-fortran-4.4.4 && \
    CPPFLAGS=-I${NCDIR}/include LDFLAGS=-L${NCDIR}/lib ./configure --prefix=${NFDIR} && \
    make && \
    make check && \
    make install

# Set environment variables
ENV COMPILER $FC
ENV COMPILER_FAMILY GNU

ENV PATH $HOME/local/bin:$PATH
ENV NETCDF_HOME $HOME/local
ENV NETCDF_FORTRAN_HOME $HOME/local

ENV GC_BIN $NETCDF_HOME/bin
ENV GC_INCLUDE $NETCDF_HOME/include
ENV GC_LIB $NETCDF_HOME/lib
ENV LD_LIBRARY_PATH $GC_LIB:$LD_LIBRARY_PATH

ENV GC_F_BIN $NETCDF_FORTRAN_HOME/bin
ENV GC_F_INCLUDE $NETCDF_FORTRAN_HOME/include
ENV GC_F_LIB $NETCDF_FORTRAN_HOME/lib
