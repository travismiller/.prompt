#!/usr/bin/env bash

PROMPT_COLOR="${1:-local}"

if [ ! -d ~/.prompt ]; then
	# http://stackoverflow.com/a/7292662/1596013
	git --version 2>&1 >/dev/null
	GIT_IS_AVAILABLE=$?
	if [ $GIT_IS_AVAILABLE -eq 0 ]; then
		if [ ! -d ~/.prompt ]; then
			git clone https://github.com/puckbag/.prompt.git ~/.prompt
		fi
	else
		curl -sSL https://github.com/puckbag/.prompt/archive/master.zip > ~/.prompt.zip
		cd ~
		unzip ~/.prompt
		rm ~/.prompt.zip
		mv ~/.prompt-master ~/.prompt
	fi
fi

if ! grep -q '~/.prompt/profile' ~/.bash_profile 2> /dev/null; then
	echo 'Setting DOT_PROMPT_TYPE in ~/.bash_profile…'
	cat ~/.prompt/enable.txt | sed "s/ 'local' / '$PROMPT_COLOR' /" >> ~/.bash_profile
elif ! grep -q '~/.prompt/profile' ~/.profile 2> /dev/null; then
	echo 'Setting DOT_PROMPT_TYPE in ~/.profile…'
	cat ~/.prompt/enable.txt | sed "s/ 'local' / '$PROMPT_COLOR' /" >> ~/.profile
fi
