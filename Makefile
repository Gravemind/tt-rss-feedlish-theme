
SRCS=feedlish.less feedlish-night.less

LESSC_INCLUDE=--include-path=$(abspath ..)

all: $(SRCS:.less=.css)

clean:
	rm -f $(SRCS:.less=.css)
	rm -f $(SRCS:.less=.css.map)

%.css: %.less Makefile
	lessc --source-map $(LESSC_INCLUDE) "$<" "$@"
	lessc $(LESSC_INCLUDE) -M "$<" "$@" > "$@.dep"

-include $(SRCS:.less=.css.dep)
