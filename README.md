# efas
Jupyter EFAS

In this repository you will find several Jupyter Notebook examples on how to:

Read the EFAS Grib in Python using eccodes and cfgrib
Convert the EFAS Grib to NetCDF
Plot the EFAS NetCDF using Matplotlib, cartopy and basemap.
Plot a discharge timeseries for a point on the river network.
Plot the snow layers.

In order to provide the correct environment we have provided a docker file that you can download within this git repository.

You will need to download an appropriate docker installation for your system.
Information can be found here.

Once you have installed the docker software, you will need to build the docker image.

docker build docker -t efas -f docker/dockerfile

This will take a while to build items like Basemap and GEOS

docker run --publish 8888:8888 --volume ~/docker/efas:/home/jovyan/ efas

As an alternative users who would prefer to install the software directly can follow the instructions here

Installation of ECCodes
Installation of CFGRIB
Installation of NetCDF4
