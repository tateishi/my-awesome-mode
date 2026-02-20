EMACS ?= emacs
ELS = my-awesome-mode.el
TEST_DIR = test

.PHONY: all compile test lint checkdoc clean

all: compile test lint checkdoc

compile:
	$(EMACS) -Q --batch -L . -f batch-byte-compile $(ELS)

test:
	$(EMACS) -Q --batch -L . -l $(TEST_DIR)/my-awesome-mode-test.el -f ert-run-tests-batch-and-exit

lint:
	$(EMACS) -Q --batch -L . \
	  -l package \
	  --eval "(require 'package)" \
	  --eval "(add-to-list 'package-archives '(\"melpa\" . \"https://melpa.org/packages/\") t)" \
	  --eval "(package-initialize)" \
	  --eval "(unless package-archive-contents (package-refresh-contents))" \
	  --eval "(unless (package-installed-p 'package-lint) (package-install 'package-lint))" \
	  -l package-lint \
	  -f package-lint-batch-and-exit $(ELS)

checkdoc:
	$(EMACS) -Q --batch -L . \
	  --eval "(checkdoc-file \"my-awesome-mode.el\")"

clean:
	rm -f *.elc
