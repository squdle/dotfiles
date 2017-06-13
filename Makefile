FILES = $(shell ls | grep -v README.md | grep -v Makefile )

all:
	stow $(FILES)
clean:
	stow -D $(FILES)
