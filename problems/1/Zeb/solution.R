#!/usr/bin/env Rscript

require(readr, quietly=TRUE)
require(docopt, quietly=TRUE)

"
Description:
  Retrieve the xxx genome for xxx reason.

Usage:
  parse_gff.R [ -f <file> ]

Options:
  -f FILE Input GFF file [default: https://ftp.ncbi.nih.gov/genomes/Alligator_sinensis/GFF/ref_ASM45574v1_scaffolds.gff3.gz]

" -> doc

opts <- docopt(doc)


gff <- read_tsv(
  opts$f,
  quote     = "",
  col_names = c("seqid", "source", "type", "start", "stop", "score", "strand", "phase", "attr"),
  col_types = "ccciicccc",
  comment   = "#"
)

save(gff, file="gff.Rdat")
