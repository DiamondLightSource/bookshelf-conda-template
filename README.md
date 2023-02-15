# Bookshelf Notebooks

This template can be used to develop container images with data processing notebooks which will be automatically deployed in two varieties:

1. An interactive - jupyterlab - environment, for running both locally and on the hosted JupyterLab instance
2. A headless processing image, for running both locally and as a cluster job

## Setting up your bookshelf

If possible, it is recommended you use the [`pip` version](https://github.com/DiamondLightSource/bookshelf-template).

1. Add your Python requirements to the `dependencies` section within the `environment.yml`.
2. Fill in `notebook.ipynb` with whatever processing you wish to perform.
3. Update your README to describe what your bookshelf does.

## Releasing a version

Simply "create a release" on github, this will trigger a set of continuous integration (CI) jobs defined in `.github/workflows` to generate and publish the specified container images.

To update the versions available via the diamond module system, run the Project General installation jenkins job for the "bookshelf" package;
This will query the GitHub API and catalogue all container images in the DiamondLightSource repository with the required metadata.

## Running the Containers

### Interactive (local)

```
podman run --publish 8888:8888 ghcr.io/diamondlightsource/bookshelf-conda-template/interactive:latest
```
or
```
module load bookshelf/bookshelf-conda-template/latest
bookshelf-conda-template-interactive
```

### Interactive (hosted)

1.  Go to https://jupyterhub.diamond.ac.uk/hub/home
2.  'Start My Server' with `CONTAINER_IMAGE=ghcr.io/diamondlightsource/bookshelf-conda-template/interactive:latest`

### Processing

```
podman run --volume .:/outputs --volume .:/inputs --security-opt=label=type:container_runtime_t ghcr.io/diamondlightsource/bookshelf-conda-template/processing:latest
```
or
```
module load bookshelf/bookshelf-conda-template/latest
bookshelf-conda-template-processing
```
