LATEXMK=latexmk \
  -interaction=nonstopmode \
  -pdf -pdflatex="pdflatex --shell-escape %O %S" \
  -bibtex

.PHONY : all watch
all:
	$(LATEXMK) main.tex

watch:
	$(LATEXMK) -pvc main.tex



.PHONY : clean
clean :
	git clean -fX
