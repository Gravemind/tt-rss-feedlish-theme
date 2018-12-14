
SRCS=feedlish.less feedlish-night.less

LESSC_INCLUDE=--include-path=$(abspath ..)

DEPS=$(SRCS:.less=.dep)

all: $(SRCS:.less=.css)

clean:
	rm -f $(SRCS:.less=.css)
	rm -f $(SRCS:.less=.css.map)
	rm -f $(DEPS)

.PHONY: all clean

%.dep: Makefile
	lessc "$*.less" "$*.css" $(LESSC_INCLUDE) -M > "$*.dep"

%.css: %.less %.dep Makefile
	lessc "$<" "$@" $(LESSC_INCLUDE) --source-map

-include $(DEPS)
