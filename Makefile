SRCS = $(wildcard e-maxx-eng/src/*/*.md)
TEXS = $(patsubst %.md, %.tex, $(SRCS))
STANDALONE_TEXS = $(patsubst %.md, %.standalone.tex, $(SRCS))
STANDALONE_PDFS = $(patsubst %.md, %.standalone.pdf, $(SRCS))
LATEXMK_FLAGS = -pdf

.PHONY: all clean book

# Book
book: e-maxx.pdf misc/imgfetch.sh
pages: $(STANDALONE_PDFS) misc/imgfetch.sh
travis: LATEXMK_FLAGS += -interaction=nonstopmode -auxdir=aux
travis: book

%.standalone.pdf: %.standalone.tex
	latexmk ${LATEXMK_FLAGS} --outdir=$(dir $<) $<

%.pdf: %.tex
	latexmk ${LATEXMK_FLAGS} $<

e-maxx.tex: $(TEXS) misc/assemble.sh misc/parse_navigation.py misc/template.tex
	bash misc/assemble.sh > $@

%.standalone.tex: %.tex
	bash misc/assemble_one.sh $< > $@

%.tex: %.md misc/fixes.pl
	perl misc/fixes.pl $< | pandoc -f markdown -o $@

cleanmess:
	@rm -f *.aux
	@rm -f *.fdb_latexmk
	@rm -f *.fls
	@rm -f *.log
	@rm -f *.out
	@rm -f *.toc

clean:
	@rm -f $(TEXS)
	@rm -f $(STANDALONE_TEXS)
	@rm -f $(STANDALONE_PDFS)
	@rm -f e-maxx.*
	@find e-maxx-eng -name '*.aux' -delete
	@find e-maxx-eng -name '*.fls' -delete
	@find e-maxx-eng -name '*.log' -delete
	@find e-maxx-eng -name '*.out' -delete
	@find e-maxx-eng -name '*.pdf' -delete
	@find e-maxx-eng -name '*.toc' -delete
	@find e-maxx-eng -name '*.fdb_latexmk' -delete
