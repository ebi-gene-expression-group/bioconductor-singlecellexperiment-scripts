#!/usr/bin/env Rscript 

# Load optparse we need to check inputs

suppressPackageStartupMessages(require(optparse))

# Source common functions

ca <- commandArgs()
script_dir <- dirname(sub('--file=', '', ca[grep('--file', ca)]))
source(file.path(script_dir, 'bioconductor-singlecellexperiment-scripts-accessory.R'))

# parse options

option_list = list(
  make_option(
    c("-a", "--assays"),
    action = "store",
    default = NA,
    type = 'character',
    help = "Comma-separated list of file names specifying tsv-format matrices. All elements of the list must have the same dimensions, and dimension names (if present) must be consistent across elements and with the row names of rowRanges and colData. The first column of all files is assumed to be feature names."
  ),
  make_option(
    c("-r", "--row-data"),
    action = "store",
    default = NULL,
    type = 'character',
    help = "Path to TSV format file describing the features. Row names, if present, become the row names of the SingleCellExperiment."
  ),
  make_option(
    c("-c", "--col-data"),
    action = "store",
    default = NULL,
    type = 'character',
    help = "Path to TSV format file describing the samples. Row names, if present, become the column names of the SummarizedExperiment object. The number of rows of the DataFrame must equal the number of rows of the matrices in assays."
  ),
  make_option(
    c("-s", "--spike-names"),
    action = "store",
    default = NA,
    type = 'character',
    help = "Path to file containing spike names (column 1) and types (e.g. ERCC, column 2), in TSV format."
  ),
  make_option(
    c("-o", "--output-object-file"),
    action = "store",
    default = NA,
    type = 'character',
    help = "File name in which to store serialized SingleCellExperiment object."
  )
)

opt <- rsw_parse_args(option_list, mandatory = c('assays', 'output_object_file'))

# Check parameter values

assayfiles <- unlist(strsplit(opt$assays, ','))
for (af in assayfiles){
  if ( ! file.exists(af) ){
    stop(paste('File', af, 'does not exist'))
  }
}

# Now we're hapy with the arguments, load SingleCellExperiment and do the work

suppressPackageStartupMessages(require(SingleCellExperiment))

# Read the assay data

assays <- lapply(assayfiles, read.delim, row.names = 1)
assays <- lapply(assays, as.matrix)

# Read row and column annotations

rowdata <- opt$row_data

if ( ! is.null(opt$row_data) ){
  rowdata <- read.delim(opt$row_data)
}

coldata <- opt$col_data

if ( ! is.null(opt$col_data) ){
  coldata <- read.delim(opt$col_data)
}

# Now build the object

single_cell_experiment <- SingleCellExperiment( assays = assays, colData = coldata, rowData = rowdata)

# Define spikes (if supplied)

if ( ! is.na(opt$spike_names) ){
  
  if ( ! file.exists(opt$spike_names) ){
    stop(paste("Supplied spikes file", opt$spike_names, "does not exist"))
  }
  
  spike_names <- read.table(opt$spike_names)
  
  spikes_by_type <- split(spike_names, spike_names$V2)
  for ( st in names(spikes_by_type) ){
    isSpike(single_cell_experiment, st) <- match(spikes_by_type[[st]]$V1, rownames(single_cell_experiment))
  }
}

# Output to a serialized R object

saveRDS(single_cell_experiment, file = opt$output_object_file)
