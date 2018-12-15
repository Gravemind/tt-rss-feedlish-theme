
SRCS=feedlish.less feedlish-night.less

THEMES_DIR=$(abspath ..)
LESSC_INCLUDE=--include-path=$(THEMES_DIR)

DSTS =$(SRCS:.less=.css)
MAPS =$(SRCS:.less=.css.map)
DEPS =$(SRCS:.less=.dep)

SHELL:=/bin/bash

all: $(DSTS) stats

stats:
#
#	Watch out for Combinatorial Explosion
#	  http://lesscss.org/features/#parent-selectors-feature-combinatorial-explosion
#
	@	echo ; \
		echo File sizes compared to default theme: ; \
		{ \
			def=`stat -c %s $(THEMES_DIR)/../css/default.css`; \
			for f in $(DSTS) ; do \
				my=`stat -c %s $$f` ; \
				echo $$f $$my/$$def x$$(( 100 * $$my / $$def ))% ; \
			done ; \
			def=`stat -c %s $(THEMES_DIR)/../css/default.css.map` ; \
			for f in $(MAPS); do \
				my=`stat -c %s $$f` ; \
				echo $$f $$my/$$def x$$(( 100 * $$my / $$def ))% ; \
			done ; \
		} | column -t ; \
		echo

clean:
	rm -f $(DSTS)
	rm -f $(MAPS)
	rm -f $(DEPS)

.PHONY: all clean

%.dep: %.less Makefile
	lessc $*.less $*.css $(LESSC_INCLUDE) -M > $*.dep.tmp
	@sed 's,\($*\.css\)[ :]*,\1 $*.dep : ,g' < $*.dep.tmp > $*.dep
	@rm $*.dep.tmp

%.css: %.less %.dep Makefile
	lessc $*.less $*.css $(LESSC_INCLUDE) --source-map

# FIXME: make clean triggers %.dep because of include !?
-include $(DEPS)
