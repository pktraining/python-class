COURSE_FILES=$(wildcard course/*)
BUILD_COURSE_FILES=$(addprefix build/,$(COURSE_FILES:.md=.ipynb))
PDF=build/course/_build/latex/python_course.pdf

all:

html: $(BUILD_COURSE_FILES)
	jupyter-book build build/course

pdf: $(PDF)

$(PDF): $(BUILD_COURSE_FILES)
	jupyter-book build build/course --builder pdflatex

build/course/%.ipynb: course/%.md
	@mkdir -p $(dir $@)
	jupytext -o $@ $<
	jupyter nbconvert --execute --to notebook --inplace $@

build/course/%: course/%
	@mkdir -p $(dir $@)
	cp $< $@

test:

clean:
	$(RM) -r build

.PHONY: all clean test pdf html
