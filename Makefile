### LaTex Makefile
# Author: Djordje Atlialp

### Compilation Flags
PDFLATEX_FLAGS  = -halt-on-error

### File Types (for dependancies)
TEX_FILES = $(shell find . -name '*.tex' -or -name '*.sty' -or -name '*.cls')
BIB_FILES = $(shell find . -name '*.bib')
BST_FILES = $(shell find . -name '*.bst')
IMG_FILES = $(shell find . -path '*.jpg' -or -path '*.png' -or \( \! -path './*.pdf' -path '*.pdf' \) )

### Standard PDF Viewers
# Defines a set of standard PDF viewer tools to use when displaying the result
# with the display target. Currently chosen are defaults which should work on
# most linux systems with GNOME installed and on all OSX systems.

UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
PDFVIEWER = evince
endif

ifeq ($(UNAME), Darwin)
PDFVIEWER = open
endif


####################################
###           Makefile           ###
####################################
.PHONY: clean

clean:
	find . -name "*.aux" -type f -delete
	find . -name "*.bbl" -type f -delete
	find . -name "*.blg" -type f -delete
	find . -name "*.dcs" -type f -delete
	find . -name "*.dvi" -type f -delete
	find . -name "*.fdb_latexmk" -type f -delete
	find . -name "*.fls" -type f -delete
	find . -name "*.gz" -type f -delete
	find . -name "*.log" -type f -delete
	find . -name "*.lof" -type f -delete
	find . -name "*.lot" -type f -delete
	find . -name "*.out" -type f -delete
	find . -name "*.pdf" -type f -delete
	find . -name "*.ps" -type f -delete
	find . -name "*.toc" -type f -delete
	find . -name "*.url" -type f -delete

paper.aux: $(TEX_FILES) $(IMG_FILES)
	pdflatex $(PDFLATEX_FLAGS) paper

paper.bbl: $(BIB_FILES) | paper.aux
	bibtex paper
	pdflatex $(PDFLATEX_FLAGS) paper

paper.pdf: paper.aux $(if $(BIB_FILES), paper.bbl)
	pdflatex $(PDFLATEX_FLAGS) paper
