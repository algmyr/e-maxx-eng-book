SRCS = $(wildcard e-maxx-eng/src/*/*.md)
TEXS = $(patsubst %.md, %.tex, $(SRCS))
LATEXMK_FLAGS = -pdf

.PHONY: all clean book

# Book
book: e-maxx.pdf misc/imgfetch.sh
travis: LATEXMK_FLAGS += -interaction=nonstopmode -auxdir=aux
travis: book

e-maxx.pdf: e-maxx.tex
	latexmk ${LATEXMK_FLAGS} $<

e-maxx.tex: $(TEXS) misc/assemble.sh misc/parse_navigation.py misc/template.tex
	bash misc/assemble.sh > $@

%.tex: %.md misc/fixes.pl
	perl misc/fixes.pl $< | pandoc -f markdown -o $@

clean:
	@rm -f $(TEXS)
	@rm -f e-maxx.*
