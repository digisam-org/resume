.PHONY: all pdf clean watch

MAIN = resume
TEXBIN ?= /Library/TeX/texbin
LATEX = $(shell if [ -x $(TEXBIN)/pdflatex ]; then echo $(TEXBIN)/pdflatex; else echo pdflatex; fi)
LATEX_FLAGS = -interaction=nonstopmode -halt-on-error

all: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex page1sidebar.tex altacv.cls
	$(LATEX) $(LATEX_FLAGS) $(MAIN).tex
	$(LATEX) $(LATEX_FLAGS) $(MAIN).tex

pdf: $(MAIN).pdf

clean:
	@rm -f $(MAIN).aux $(MAIN).bbl $(MAIN).bcf $(MAIN).blg $(MAIN).log $(MAIN).out $(MAIN).run.xml $(MAIN).synctex.gz

watch:
	@which fswatch >/dev/null 2>&1 || (echo "fswatch not found. Install with: brew install fswatch" && exit 1)
	@echo "Watching for changes... (press Ctrl+C to stop)"
	fswatch -o $(MAIN).tex page1sidebar.tex altacv.cls | xargs -n1 -I{} make pdf
