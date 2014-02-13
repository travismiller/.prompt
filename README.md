.prompt
=======

This setup assumes BASH and GIT. You can set the $PROMPT_TYPE variable to
pre-determined colors.

local/default: cyan
dev: pink
prod: green

Add the following to .profile or .bashrc

    # colored prompt w/ git support
    if [ -f ~/.prompt/profile ]; then
        PROMPT_TYPE="local"
        . ~/.prompt/profile
    fi

