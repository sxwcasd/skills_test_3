cwlVersion: v1.0
class: Workflow
id: estimate_contamination_wf
requirements:
  - class: ScatterFeatureRequirement

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
    type: 
      type: array
      items: File
    outputSource: VerifyBamID/ancestries
      
  contamination:
    type: File
    outputSource: ExtractFreemix/contamination

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
      [ merged_file ]
      
  ExtractFreemix:
    run: ../tools/extract_freemix.cwl
    in:
      raw_contamination: MergeContamination/merged_file
    out:
      [ contamination ]

