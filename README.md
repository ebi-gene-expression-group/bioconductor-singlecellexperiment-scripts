# Wrapper scripts for components of the SingleCellExperiment toolchain

SingleCellExperiment is a base data structure for single cell analyses, in particular via Scater and SC3. This package provides wrapper scripts to create serialised data structures for those pipelines, as part of structured workflows.

## Install

The recommended method for script installation is via a Bioconda recipe called bioconda-singlecellexperiment-scripts. 

With the [Bioconda channels](https://bioconda.github.io/#set-up-channels) configured the latest release version of the package can be installed via the regular conda install command:

```
conda install bioconductor-singlecellexperiment-scripts
```

## Test installation

There is a test script included:

```
bioconductor-singlecellexperiment-scripts-post-install-tests.sh
```

This downloads test data and executes all of the scripts described below.

## Commands

Currently available scripts are detailed below, each of which has usage instructions available via --help.

### singlecellexperiment-create-single-cell-experiment.R: call SingleCellExperiment()

To create a SingleCellExperiment from input files

```
singlecellexperiment-create-single-cell-experiment.R -a <test matrix file> -c <test annotation file> -o <file to store serialized SingleCellExperiment object>   
```

### scater-get-random-genes.R 

This script is used to generate random subsets of feature names from a SingleCellExperiment object. It is called like:

```
singlecellexperiment-get-random-genes.R -i <input SingleCellExperiment in .rds format> -o <output file> -n <numbe of features> -s <random seed>
```

Output is a text file with one feature per line.
