FROM jupyter/base-notebook:6c85e4b43a26 AS build

USER root

# Ensure ECMWF's HTTP proxy does not get in the way (thanks to bentorey.hernandez@ecmwf.int).
RUN set -ex \
	&& echo 'Acquire::http::Pipeline-Depth "0";' > /etc/apt/apt.conf.d/99fixbadproxy \
	&& echo 'Acquire::http::No-Cache=True;' >> /etc/apt/apt.conf.d/99fixbadproxy \
	&& echo 'Acquire::BrokenProxy=true;' >> /etc/apt/apt.conf.d/99fixbadproxy


# Install build-time dependencies.
RUN set -ex \
	&& apt-get update \
	&& apt-get install --yes --no-install-suggests --no-install-recommends \
	bison \
	cmake \
	file \
	flex \
	g++ \
	gcc \
	gfortran \
	git \
	libarmadillo-dev \
	libatlas-base-dev \
	libboost-dev \
	libbz2-dev \
	libc6-dev \
	libcairo2-dev \
	libcurl4-openssl-dev \
	libeigen3-dev \
	libexpat1-dev \
	libffi-dev \
	libfftw3-dev \
	libfreetype6-dev \
	libfribidi-dev \
	libgdal-dev \
	libgdbm-dev \
	libgeos-dev \
	libgeos-3.6.2 \
	libharfbuzz-dev \
	libhdf5-dev \
	libjpeg-dev \
	liblapack-dev \
	liblzma-dev \
	libncurses5-dev \
	libncursesw5-dev \
	libnetcdf-cxx-legacy-dev \
	libnetcdf-dev \
	libpango1.0-dev \
	libpcre3-dev \
	libpng-dev \
	libproj-dev \
	libreadline-dev \
	libsqlite3-dev \
	libssl-dev \
	libxml-parser-perl \
	libxml2-dev \
	libxslt1-dev \
	libyaml-dev \
	make \
	patch \
	swig \
	uuid-dev \
	zlib1g-dev


# Install Python modules.
RUN set -ex \
	&& pip install \
	https://github.com/matplotlib/basemap/archive/master.zip \
        netcdf4==1.5.0 \
        cdsapi==0.1.1 \
	cfgrib==0.9.6.post1 \
	ecmwf-api-client==1.4.2 \
	ipyleaflet==0.9.1 \
	ipywidgets==7.4.2 \
	jupyterhub==0.9.4 \
	jupyterlab==0.35.2 \
        matplotlib==3.0.3 \
	notebook==5.7.0 \
	numpy==1.15.2 \
	pandas==0.23.4 \
	scipy==1.1.0 \
	xarray==0.11.0 \
	&& fix-permissions $CONDA_DIR \
	&& fix-permissions /home/$NB_USER


WORKDIR /tmp

ENV HTTP=https://confluence.ecmwf.int/download/attachments/45757960 \
  ECCODES=eccodes-2.12.0-Source
RUN cd /tmp && wget --output-document=${ECCODES}.tar.gz ${HTTP}/${ECCODES}.tar.gz?api=v2
RUN tar -zxvf ${ECCODES}.tar.gz

RUN cd ${ECCODES} && mkdir build && cd build && cmake .. && make -j2 && make install

#ENV HTTP=https://github.com/matplotlib/basemap/archive \
#  BASEMAP=1.2.0rel
#RUN cd /tmp && wget --output-document=v${BASEMAP}.tar.gz ${HTTP}/v${BASEMAP}.tar.gz

#RUN tar xzf v${BASEMAP}.tar.gz
#RUN export GEOS_DIR=/tmp/GEOS
#ENV GEOS_DIR=/tmp/GEOS
#RUN mkdir -p ${GEOS_DIR}
#RUN cd /tmp 
#ENV HTTP=http://download.osgeo.org/geos \
#   GEOS=geos-3.6.2
#RUN cd /tmp && wget --output-document=${GEOS}.tar.bz2 ${HTTP}/${GEOS}.tar.bz2
#RUN tar xf ${GEOS}.tar.bz2
#RUN cd ${GEOS} && pwd && ls
#RUN /tmp/${GEOS}/configure --prefix=${GEOS_DIR}
#RUN make --silent  && make install --silent
#RUN ls /tmp && cd /tmp/basemap-${BASEMAP} && python setup.py install


#
# Run-time image.
#

FROM jupyter/base-notebook:6c85e4b43a26

USER root

# Ensure ECMWF's HTTP proxy does not get in the way (thanks to bentorey.hernandez@ecmwf.int).
RUN set -ex \
	&& echo 'Acquire::http::Pipeline-Depth "0";' > /etc/apt/apt.conf.d/99fixbadproxy \
	&& echo 'Acquire::http::No-Cache=True;' >> /etc/apt/apt.conf.d/99fixbadproxy \
	&& echo 'Acquire::BrokenProxy=true;' >> /etc/apt/apt.conf.d/99fixbadproxy

# Install run-time dependencies.
RUN set -ex \
	&& apt-get update \
	&& apt-get install --yes --no-install-suggests --no-install-recommends \
	ghostscript \
	imagemagick \
	ksh \
	libarmadillo8 \
	libbz2-1.0 \
	libcairo-gobject2 \
	libcairo-script-interpreter2 \
	libcairo2 \
	libcroco3 \
	libcurl4 \
	libexif12 \
	libexpat1 \
	libfftw3-double3 \
	libfftw3-long3 \
	libfftw3-quad3 \
	libfftw3-single3 \
	libfontconfig1 \
	libfreetype6 \
	libfribidi0 \
	libgdal20 \
	libgeoip1 \
	libgeos-c1v5 \
	libgif7 \
	libgomp1 \
	libgssrpc4 \
	libharfbuzz0b \
	libhdf5-100 \
	libicu60 \
	libilmbase12 \
	libjbig0 \
	libjpeg-turbo8 \
	libjpeg8 \
	libjs-jquery \
	liblcms2-2 \
	liblqr-1-0 \
	libnetcdf-c++4 \
	libnetcdf13 \
	libopenexr22 \
	libpangocairo-1.0-0 \
	libpangoxft-1.0-0 \
	libpcrecpp0v5 \
	libpng16-16 \
	libproj12 \
	libreadline7 \
	libsqlite3-0 \
	libtiff5 \
	libtiffxx5 \
	libwebp6 \
	libxft2 \
	libxml2 \
	libxslt1.1 \
	poppler-utils \
	rsync

# Copy build artifacts.
COPY --from=build /opt/conda/lib/python3.6/site-packages/ /opt/conda/lib/python3.6/site-packages/
COPY --from=build /usr/local/share/eccodes/ /usr/local/share/eccodes/
COPY --from=build /usr/local/bin/ /usr/local/bin/
COPY --from=build /usr/local/lib/ /usr/local/lib/

# Ensure shared libs installed by the previous step are available.
RUN set -ex \
	&& /sbin/ldconfig

# Switch back to jovyan to avoid accidental container runs as root.
USER $NB_UID

# Configure Python runtime.
ENV \
	PYTHONDONTWRITEBYTECODE=1 \
	PYTHONPATH=/usr/local/lib/python3.6/site-packages \
PYTHONUNBUFFERED=1
