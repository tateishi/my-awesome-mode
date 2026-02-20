EMACS ?= emacs
ELPA_DIR := $(CURDIR)/.elpa
ELS = my-awesome-mode.el
TEST_DIR = test

DEV_PKGS = (package-lint)

define EMACS_PKG_BOOT
  -l package \
  --eval "(require 'package)" \
  --eval "(add-to-list 'package-archives '(\"gnu\" . \"https://elpa.gnu.org/packages/\") t)" \
  --eval "(add-to-list 'package-archives '(\"melpa\" . \"https://melpa.org/packages/\") t)" \
  --eval "(setq package-user-dir \"$(ELPA_DIR)\")" \
  --eval "(package-initialize)" \
  --eval "(unless package-archive-contents (package-refresh-contents))"
endef


.PHONY: bootstrap dev-install test lint clean

all: bootstrap compile test lint checkdoc

bootstrap:
	$(EMACS) -Q --batch $(EMACS_PKG_BOOT)

dev-install: bootstrap
	$(EMACS) -Q --batch $(EMACS_PKG_BOOT) \
	  --eval "(dolist (pkg (quote $(DEV_PKGS))) (unless (package-installed-p pkg) (package-install pkg)))"

compile:
	$(EMACS) -Q --batch -L . -f batch-byte-compile $(ELS)

test: dev-install
	$(EMACS) -Q --batch -L . -l $(TEST_DIR)/my-awesome-mode-test.el -f ert-run-tests-batch-and-exit

lint: dev-install
	$(EMACS) -Q --batch -L . \
	  --eval "(setq package-user-dir \"$(ELPA_DIR)\")" \
	  --eval "(package-initialize)" \
	  -l package-lint \
	  -f package-lint-batch-and-exit $(ELS)

checkdoc:
	$(EMACS) -Q --batch -L . \
	  --eval "(checkdoc-file \"my-awesome-mode.el\")"

clean:
	rm -rf .elpa *.elc
