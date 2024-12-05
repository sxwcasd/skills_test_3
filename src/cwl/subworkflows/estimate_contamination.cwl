inputs:
  input_directory:
    type: Directory
  svd_prefix:
    type: string
  reference:
    type: File
  pc_number:
    type: int

outputs:
  ancestry:
    type: File[]
    outputSource: VerifyBamID/ancestries
  contamination:
    type: File[]
    outputSource: VerifyBamID/contaminations

steps:
  ListFiles:
    run: ../tools/listing_file.cwl
    in:
      input_directory: input_directory
    out: [fileList, theBaseNameOfTheDirectory]

  VerifyBamID:
    run: ../tools/verify_bam_id.cwl
    scatter: individual_cram
    scatterMethod: dotproduct
    in:
      svd_prefix: svd_prefix
      reference: reference
      pc_number: pc_number
      individual_cram: ListFiles/fileList
    out: [ancestries, contaminations]

  MergeContamination:
    run: ../tools/merge_contamination.cwl
    in:
      individual_contamination: VerifyBamID/contaminations
    out:
      [ out ]