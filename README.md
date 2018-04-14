.prompt
=======

This setup assumes BASH and GIT. You can set the $PROMPT_TYPE variable to
pre-determined colors.

- local/default: cyan
- dev: pink
- prod: green

Manual Setup
------------

Place this .prompt directory into your home directory.

```console
$ git clone https://github.com/travismiller/.prompt.git ~/.prompt
```

Add the following to `~/.bash_profile`

```bash
# colored prompt w/ git support
source ~/.prompt/profile 'local' 2> /dev/null
```

Screenshot
----------

![.prompt Screenshot](/screenshot.png?raw=true ".prompt Screenshot")
