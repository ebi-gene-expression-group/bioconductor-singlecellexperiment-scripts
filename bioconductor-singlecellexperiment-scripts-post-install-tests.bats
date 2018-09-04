#!/usr/bin/env bats

@test "SingleCellExperiment creation" {
    if [ "$use_existing_outputs" = 'true' ] && [ -f "$raw_singlecellexperiment_object" ]; then
        skip "$use_existing_outputs $raw_singlecellexperiment_object exists and use_existing_outputs is set to 'true'"
    fi
    
    run rm -f $raw_singlecellexperiment_object && singlecellexperiment-create-single-cell-experiment.R -a $test_matrix_file -c $test_annotation_file -o $raw_singlecellexperiment_object    
    
    [ "$status" -eq 0 ]
    [ -f  "$raw_singlecellexperiment_object" ]
}


@test "Generate a random gene selection" {
    if [ "$use_existing_outputs" = 'true' ] && [ -f "$random_genes_file" ]; then
        skip "$use_existing_outputs $random_genes_file exists and use_existing_outputs is set to 'true'"
    fi

    run rm -f $random_genes_file && singlecellexperiment-get-random-genes.R -i $raw_singlecellexperiment_object -o $random_genes_file -n $n_random_genes

    [ "$status" -eq 0 ]
    [ -f  "$random_genes_file" ]
}
