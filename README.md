Recipes for the spt3g_cutter package
==============================================

This repo contains recipes for using the spt3g_cutter package in various contexts, including bundling it as a Conda package and generating a Docker container image.

Docker
------------------

### Build Docker image

The Docker image is based on CentOS, using Conda to install the Python packages. The script below shows an example of how to build the image.

```bash
# Specify the version of spt3g_cutter to build
export SPT3G_CUTTER_VERSION=0.2.1
export IMAGE_REPO=registry.example.com/spt-cutter
# Clone this repo
git clone https://github.com/CMB-NCSA/spt3g_cutter-recipes
cd spt3g_cutter-recipes
# Build the Docker image
docker build -t ${IMAGE_REPO}:${SPT3G_CUTTER_VERSION} \
    --build-arg SPT3G_CUTTER_VERSION \
    -f docker/Dockerfile .
```

### Run Docker image

```bash
$ docker run -ti --rm --name spt-cutter \
    ${IMAGE_REPO}:${SPT3G_CUTTER_VERSION} \
    spt3g_cutter --help

Starting conda env from: /home/sptworker/miniconda
Adding: /home/sptworker/miniconda/spt3g_cutter to paths
...
usage: spt3g_cutter [-h] [-c CONFIGFILE] [--inputList INPUTLIST] ...
                    [--bands [BANDS [BANDS ...]]] [--date_start  ...
                    [--log_format_date LOG_FORMAT_DATE] [--np NP]...
```

Conda
------------------

The Conda package build process is documented by the Dockerfile itself, but you can build the Conda package without Docker. In the script below, the environment variable `MINICONDA_PATH` represents the path to your Miniconda (or Anaconda) installation. We are building with Miniconda version `Miniconda3-py38_4.10.3`.

```bash
# Specify the version of spt3g_cutter to package
export SPT3G_CUTTER_VERSION=0.2.0
# Clone this repo
git clone https://github.com/CMB-NCSA/spt3g_cutter-recipes
# Run the Conda package builder
cd spt3g_cutter-recipes/conda
source ${MINICONDA_PATH}/bin/activate
conda build .
conda install $(ls ${MINICONDA_PATH}/conda-bld/*/spt3g_cutter-${SPT3G_CUTTER_VERSION}*.tar.bz2)
```

See the `conda/build_conda_steps.sh` script for an example of how to publish the package to conda-forge.
