SRCS = $(wildcard e-maxx-eng/src/*/*.md)
TEXS = $(patsubst %.md, %.tex, $(SRCS))

.PHONY: all clean book

# Book
book: e-maxx.pdf misc/imgfetch.sh

e-maxx.pdf: e-maxx.tex
	latexmk $<

e-maxx.tex: $(TEXS) misc/assemble.sh misc/template.tex
	bash misc/assemble.sh > $@

%.tex: %.md misc/fixes.pl
	perl misc/fixes.pl < $< | pandoc -f markdown -o $@

clean:
	@rm -f $(TEXS)
	@rm -f e-maxx.*
