
SRCS=feedlish.less feedlish-night.less

THEMES_DIR=$(abspath ..)
LESSC_INCLUDE=--include-path=$(THEMES_DIR)

DSTS =$(SRCS:.less=.css)
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
				echo $$f $$my/$$def $$(( 100 * $$my / $$def ))% ; \
			done ; \
		} | column -t ; \
		echo

clean:
	rm -f $(DSTS)
	rm -f $(DEPS)

commit: clean
	@echo -e "\n---- Backup local.less ----"
	[ ! -f local.less ] || mv -fu local.less local.less.bak
	@echo -e "\n---- Rebuild ----"
	$(MAKE) all
	@echo -e "\n---- Restore local.less ----"
	[ ! -f local.less.bak ] || mv -fu local.less.bak local.less
	@echo -e "\n---- Commit ----"
	git add $(DSTS)
	git commit -m "(build css, ttrss at $$(cd $(THEMES_DIR); git describe --always --long --abbrev=12))"

uncommit:
	git reset --soft @~

.PHONY: all clean commit uncommit

%.dep: %.less Makefile
	lessc $*.less $*.css $(LESSC_INCLUDE) -M > $*.dep.tmp
	@sed 's,\($*\.css\)[ :]*,\1 $*.dep : ,g' < $*.dep.tmp > $*.dep
	@rm $*.dep.tmp

%.css: %.less %.dep Makefile
	lessc $*.less $*.css $(LESSC_INCLUDE)

# FIXME: make clean triggers %.dep because of include !?
-include $(DEPS)
