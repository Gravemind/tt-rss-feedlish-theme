
SRCS=feedlish.less feedlish-night.less

THEMES_DIR=$(abspath ..)
LESSC_INCLUDE=--include-path=$(THEMES_DIR)

DSTS =$(SRCS:.less=.css)
DEPS =$(SRCS:.less=.dep)

SHELL:=/usr/bin/bash

TTRSS_VERSION=$(shell git -C $(THEMES_DIR) --no-pager log --date="format:%y.%m" --pretty="v%cd-%h" --abbrev=7 -n1 $(shell git -C $(THEMES_DIR) merge-base HEAD origin))

all: ttrss-version $(DSTS) stats

ttrss-version:
	@echo "tt-rss version $(TTRSS_VERSION)"

stats:
#
#	Watch out for Combinatorial Explosion
#	  http://lesscss.org/features/#parent-selectors-feature-combinatorial-explosion
#
	@	echo ; \
		echo File sizes compared to default theme: ; \
		{ \
			def=`stat -c %s $(THEMES_DIR)/../themes/light.css`; \
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
	@echo -e "\n---- Backup custom.less ----"
	[ ! -f custom.less.patch ] || patch < custom.less.patch
	git diff -p @ -- custom.less | tee custom.less.patch
	git co @ -- custom.less
	git status -sb
	@echo -e "\n---- Rebuild ----"
	$(MAKE) all
	@echo -e "\n---- Restore custom.less ----"
	patch < custom.less.patch && rm custom.less.patch
	@echo -e "\n---- Commit ----"
	git add $(DSTS)
	git commit -m "(build css, ttrss at $(TTRSS_VERSION))"

uncommit:
	git reset --soft @~

.PHONY: all clean commit uncommit ttrss-version

%.dep: %.less Makefile
	lessc $*.less $*.css $(LESSC_INCLUDE) -M > $*.dep.tmp
	@sed 's,\($*\.css\)[ :]*,\1 $*.dep : ,g' < $*.dep.tmp > $*.dep
	@rm $*.dep.tmp

%.css: %.less %.dep Makefile
	lessc $*.less $*.css $(LESSC_INCLUDE)

# FIXME: make clean triggers %.dep because of include !?
-include $(DEPS)
