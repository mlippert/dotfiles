#
# Makefile to build and test analyze-data
#

# force the shell used to be bash in case for some commands we want to use
# set -o pipefail ex:
#    set -o pipefail ; SOMECOMMAND 2>&1 | tee $(LOG_FILE)
SHELL := /bin/bash

# Test if a variable has a value, callable from a recipe
# like $(call ndef,ENV)
ndef = $(if $(value $(1)),,$(error $(1) not set))

GIT_TAG_VERSION = $(shell git describe 2> /dev/null || echo 'no-ver-tag')
export GIT_TAG_VERSION

ANSIBLE = ansible
ESLINT = ./node_modules/.bin/eslint

LINT_LOG := logs/lint.log
TEST_LOG := logs/test.log


.DEFAULT_GOAL := help
.DELETE_ON_ERROR :
.PHONY : all install help

run : ## run the main python script
	$(call ndef,VIRTUAL_ENV)
	python pysrc/main.py

install : VER ?= 3
install : ## create python3 virtual env, install requirements (define VER for other than python3)
	@python$(VER) -m venv venv
	@ln -s venv/bin/activate activate
	@source activate                        	; \
	pip install --upgrade pip setuptools wheel  ; \
	pip install -r requirements.txt ; \
	ansible-galaxy collection install -r requirements.yml

outdated : ## check for newer versions of required python packages
	$(call ndef,VIRTUAL_ENV)
	pip list --outdated

upgrade-deps : ## upgrade to the latest versions of required python packages
	$(call ndef,VIRTUAL_ENV)
	pip install --upgrade -r requirements.txt

upgrade-pip : ## upgrade pip and setuptools
	$(call ndef,VIRTUAL_ENV)
	pip install --upgrade pip setuptools

## Help documentation à la https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
## if you want the help sorted rather than in the order of occurrence, pipe the grep to sort and pipe that to awk
help :
	@echo ""                                                                   ; \
	echo "Useful targets in this analyze-data Makefile:"                       ; \
	(grep -E '^[a-zA-Z_-]+ ?:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = " ?:.*?## "}; {printf "\033[36m%-20s\033[0m : %s\n", $$1, $$2}') ; \
	echo ""                                                                    ; \
	echo "If VIRTUAL_ENV needs to be set for a target, run '. activate' first" ; \
	echo ""

