# Jupyter EFAS

In this repository you will find several Jupyter Notebook examples on how to:

Read the EFAS Grib in Python using eccodes and cfgrib
Retrieve an EFAS Grib from the CDS API.
Convert the EFAS Grib to NetCDF
Plot the EFAS NetCDF using Matplotlib, cartopy and basemap.
Plot a discharge timeseries for a point on the river network.
Calculate and plot the Soil Moisture.

In order to clone this repository use :

```git clone --recurse-submodules https://github.com/enyfeo/efas.git```

We have added some data files in the data folder

You will need to 

```git lfs pull``` to retrieve the files

In order to provide the correct environment we have provided a docker file that you can download within this git repository.

You will need to download an appropriate docker installation for your system.
Information can be found here [Docker Hub Install - Docker CE](https://docs.docker.com/install/).

Once you have installed the docker software, you will need the docker image.

# Pull the Latest Docker Image

It can be pulled from docker hub or built locally. Pulling is faster.

```docker pull enyfeo/efas:latest```

Once it has completed you can start the container using the conmmand for the image pulled from docker hub: 

```docker run --publish 8888:8888 --volume ${PWD}:/home/jovyan/ enyfeo/efas:latest start-notebook.sh --NotebookApp.token=''```

N.B. Windows Users should use the path 'c:/efas' or wherever they checkedout the git repository instead of ${PWD}

# Building the Docker Locally

This can be built locally (takes some time to source the packages) using :

```docker build docker -t jupyter-cds -f docker/dockerfile```

Or if you built the image you just have to make sure you match the tag (-t)

```docker run --publish 8888:8888 --volume ${PWD}:/home/jovyan/ jupyter-cds:latest start-notebook.sh --NotebookApp.token=''```

As an alternative users who would prefer to install the software directly can follow the instructions here

[Installation of ECCodes](https://confluence.ecmwf.int/display/ECC/ecCodes+installation)

[Installation of CFGRIB](https://github.com/ecmwf/cfgrib)

[Installation of NetCDF4](https://pypi.org/project/netCDF4/)

The Jupyter notebooks are limited by resources as they are a container with only the resources available to them.
Installing the software will give the fastest results when processing EFAS Data.

The Jupyter Notebooks are there as a guide on how to begin with the EFAS Data.
