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
$ curl -s https://raw.githubusercontent.com/puckbag/.prompt/master/install.sh | bash -s -- local
```

Manual Setup
------------

Place this .prompt directory into your home directory.

```
$ git clone https://github.com/puckbag/.prompt.git ~/.prompt
```

Add the following to .profile or .bash_profile

```bash
# colored prompt w/ git support
source ~/.prompt/profile 'local' 2> /dev/null
```
