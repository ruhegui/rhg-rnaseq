process CONCAT{
    tag "$meta.id"
    label 'process_single'

    input:
    tuple val(meta), path(R1), path(R2)

    output:
    tuple val(meta), path("${meta.id}_merged_1.fq.gz"), path("${meta.id}_merged_2.fq.gz"), emit: files
    path "versions.yml", emit: versions

    script:
    """
    cat $R1 > ${meta.id}_merged_1.fq.gz
    cat $R2 > ${meta.id}_merged_2.fq.gz

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        concat: \$(cat --version |& sed '1!d ; s/cat //')
    END_VERSIONS
    """
}
