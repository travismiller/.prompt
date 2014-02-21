#!/bin/sh

CWD=`pwd`

# http://stackoverflow.com/a/7292662/1596013
git --version 2>&1 >/dev/null
GIT_IS_AVAILABLE=$?
if [ $GIT_IS_AVAILABLE -eq 0 ]; then
	git clone https://github.com/puckbag/.prompt.git ~/.prompt
else
	curl -sS https://github.com/puckbag/.prompt/archive/master.zip > ~/.prompt.zip
	cd ~
	unzip ~/.prompt.zip
	rm ~/.prompt.zip
fi


if grep -q '~/.prompt/profile' ~/.profile ~/.bashrc 2>/dev/null; then
	sleep 0
else
	cat ~/.prompt/enable.txt >> ~/.profile
fi

cd $CWD

