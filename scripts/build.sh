#!/bin/bash

## Purpose of this script

## Select all files in the folder /content/fr
## Save them to the folder /temp/

## 1: We declare some variables

INPUT="../contents/meta.txt" 
INPUT+=" ../contents/1.Introduction.md"
INPUT+=" ../contents/2.Partie*/*/*.md"
INPUT+=" ../contents/3.Conclusion.md"
# INPUT+=" ../contents/Partie-1-Penser/Level-2/*.*"
INPUT+=" ../contents/outro.txt"

TEMP="../temp/newfile.txt"

TIMESTAMP=$(date -u +%Y%m%d_%H%M%SZ)

OUTPUT="../output/Faire-"$TIMESTAMP".pdf"



## AWK Method

## FNR = the current record number in the current file.
## NR = "Number of Lines seen so far in the current file"

## \\vfill \\columnbreak \\newpage

awk '
BEGIN {
  start = ""; ## \\begin{multicols}{2}
  end = "\\newpage"; ## \\end{multicols}\n
  print start
}
FNR == 1 && FNR != NR {
  print end;
  print start
}
{print} ## {print $0,"  "} ## Adds two spaces after each end-of-line, to keep line returns in Markdown.
END {
  print end
}
' $INPUT > $TEMP


## awk '{print $0,"  x"}' $TEMP > $TEMP2
## mv $TEMP2 $TEMP

## PANDOC processing

## Consolata
## Inconsesi
## "Breite Grotesk"
## "Work Sans"
## "Archivo Narrow"
## "Sophia Nubian"
## "Limousine" - by OSP Foundry
## Monoid - by Andreas Larsen
## HK Grotesk - by Alfredo Marco Pradil, Hanken Design Co.

pandoc -f markdown --template=../templates/custom $TEMP \
	--latex-engine=xelatex \
  --variable lang=french \
  --variable mainfont="HKSerif-Regular" \
  --variable boldfont="HKSerif-Bold" \
  --variable italicfont="HKSerif-Italic" \
  --variable sansfont="HK Grotesk Pro" \
  --variable fontsize=9pt \
  --variable urlcolor=black \
  --variable linkcolor=black \
  --variable documentclass=book \
  --toc --toc-depth=1 \
  --listings \
  --include-before-body=../contents/infocouverture.txt \
  -o $OUTPUT

## End of file
