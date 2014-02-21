.prompt
=======

This setup assumes BASH and GIT. You can set the $PROMPT_TYPE variable to
pre-determined colors.

local/default: cyan  
dev: pink  
prod: green  


Installer Setup
---------------

```
$ curl -sS https://raw.github.com/puckbag/.prompt/master/install.sh | sh
```

Manual Setup
------------

Place this .prompt directory into your home directory.

```
$ git clone https://github.com/puckbag/.prompt.git ~/.prompt
```

Add the following to .profile or .bashrc

```bash
# colored prompt w/ git support
if [ -f ~/.prompt/profile ]; then
    PROMPT_TYPE="local"
    . ~/.prompt/profile
fi
```

