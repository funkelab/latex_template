.PHONY: default

dir := $(shell pwd)
name := $(shell basename ${dir})

default:
	-mkdir -p figures/tikzexternal
	-mkdir -p .latexmk/figures/tikzexternal
	(ulimit -n 1024; latexmk -auxdir=.latexmk -outdir=.latexmk -pdf -shell-escape -interaction=nonstopmode -halt-on-error -file-line-error main.tex)
	cp .latexmk/main.pdf .

arxiv_export: clean default
	-rm -rf arxiv_export
	-arxiv_latex_cleaner --verbose --use_external_tikz figures/tikzexternal .
	-mv ../${name}_arXiv arxiv_export
	-mv .latexmk/*.bbl arxiv_export
	-rm arxiv_export/Makefile

clean:
	-rm -rf .latexmk
	-rm -rf figures/tikzexternal/*
