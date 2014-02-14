#!/bin/sh

if [ -n "$BASH_VERSION" ]; then

    if [ -f ~/.prompt/colors.bash ]; then
        . ~/.prompt/colors.bash
    fi

    if [ `type -t git` ]; then
        if [ -f ~/.prompt/git-completion.bash ]; then
            . ~/.prompt/git-completion.bash
        fi
        if [ -f ~/.prompt/git-prompt.sh ]; then
            . ~/.prompt/git-prompt.sh
        fi
    fi

    # local, dev, prod
    #PROMPT_TYPE="local"
    case "$PROMPT_TYPE" in
        "prod") 
            PROMPT_PS1_USER_COLOR=$COLOR_IGREEN
        ;;
        "dev") 
            PROMPT_PS1_USER_COLOR=$COLOR_IPURPLE
        ;;
        # "local") 
        *) 
            PROMPT_PS1_USER_COLOR=$COLOR_ICYAN
        ;;
    esac

    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM=
    GIT_PS1_DESCRIBE_STYLE=
    GIT_PS1_SHOWCOLORHINTS=

    function colored_prompt
    {
        # local gitps1=$( [ `type -t __git_ps1` ] && echo '$(__git_ps1 " (%s)")' || echo '' )
        local gitps1=$( [ `type -t __git_ps1` ] && echo '$(__git_ps1 " (%s)")' || echo '' )
        local user="$PROMPT_PS1_USER_COLOR\u@\h"
        local location="$COLOR_IBLUE\w"
        local branch="$COLOR_YELLOW$gitps1"
        local prompt="$COLOR_IBLUE$"
        echo "$COLOR_OFF$user $location$branch\n$prompt$COLOR_OFF "
    }

    export PS1=$(colored_prompt)

fi
