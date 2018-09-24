#!/usr/bin/env bats

# Create a SingleCellExperiment based on text inputs

@test "SingleCellExperiment creation" {
    if [ "$use_existing_outputs" = 'true' ] && [ -f "$raw_singlecellexperiment_object" ]; then
        skip "$use_existing_outputs $raw_singlecellexperiment_object exists and use_existing_outputs is set to 'true'"
    fi
    
    run rm -f $raw_singlecellexperiment_object && singlecellexperiment-create-single-cell-experiment.R -a $test_matrix_file -c $test_annotation_file -o $raw_singlecellexperiment_object    
    echo "status = ${status}"
    echo "output = ${output}"
    
    [ "$status" -eq 0 ]
    [ -f  "$raw_singlecellexperiment_object" ]
}

# Select gene names randomly from the rows of a SingleCellExperiment

@test "Generate a random gene selection" {
    if [ "$use_existing_outputs" = 'true' ] && [ -f "$random_genes_file" ]; then
        skip "$use_existing_outputs $random_genes_file exists and use_existing_outputs is set to 'true'"
    fi

    run rm -f $random_genes_file && singlecellexperiment-get-random-genes.R -i $raw_singlecellexperiment_object -o $random_genes_file -n $n_random_genes
    echo "status = ${status}"
    echo "output = ${output}"

    [ "$status" -eq 0 ]
    [ -f  "$random_genes_file" ]
}

# Select cell names randomly from the columns of a SingleCellExperiment

@test "Generate a random cell selection" {
    if [ "$use_existing_outputs" = 'true' ] && [ -f "$random_cells_file" ]; then
        skip "$use_existing_outputs $random_cells_file exists and use_existing_outputs is set to 'true'"
    fi

    run rm -f $random_cells_file && singlecellexperiment-get-random-cells.R -i $raw_singlecellexperiment_object -o $random_cells_file -n $n_random_cells
    echo "status = ${status}"
    echo "output = ${output}"

    [ "$status" -eq 0 ]
    [ -f  "$random_cells_file" ]
}
