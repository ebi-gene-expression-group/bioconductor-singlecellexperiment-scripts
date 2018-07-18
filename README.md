# Wrapper scripts for components of the SingleCellExperiment toolchain

SingleCellExperiment is a base data structure for single cell analyses, in particular via Scater and SC3. This package provides wrapper scripts to create serialised data structures for those pipelines, as part of structured workflows.

## Install

You can just download and use the wrappers here as we develop them. But We are intending for these scripts to be available alongside the SingleCellExperiment package in Bioconda. Prior to our finalising a version of this package and making it available through usual channels, it is available from our fork of the bioconda recipes using the commands below. Here we are assuming you have a healthy Bioconda install with the correct channels activate (see https://bioconda.github.io/index.html#set-up-channels). 

You may need to install conda-build:

```
conda install conda-build
```

Now you should be able to install using the following command:

```
cd <directory where you do your Git clones>
git clone git@github.com:ebi-gene-expression-group/bioconda-recipes.git
git checkout bioconductor-singlecellexperiment-scripts
cd bioconda-recipes/recipes/bioconductor-singlecellexperiment-scripts
conda build .
conda install --force --use-local bioconductor-singlecellexperiment-scripts
```
