
SRCS=feedlish.less feedlish-night.less

LESSC_INCLUDE=--include-path=$(abspath ..)

DEPS=$(SRCS:.less=.dep)

all: $(SRCS:.less=.css)

clean:
	rm -f $(SRCS:.less=.css)
	rm -f $(SRCS:.less=.css.map)
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
