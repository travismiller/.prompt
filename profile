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
            PROMPT_PS1_HOST_COLOR=$COLOR_IGREEN
        ;;
        "dev") 
            PROMPT_PS1_HOST_COLOR=$COLOR_IPURPLE
        ;;
        # "local") 
        *) 
            PROMPT_PS1_HOST_COLOR=$COLOR_ICYAN
        ;;
    esac

    PROMPT_PS1_USER_COLOR=$PROMPT_PS1_HOST_COLOR
    PROMPT_PS1_PROMPT_COLOR=$COLOR_IBLUE
    PROMPT_PS1_PROMPT_CHARACTER='$'
    if [ `whoami` = "root" ]; then
        PROMPT_PS1_USER_COLOR=$COLOR_RED
        PROMPT_PS1_PROMPT_COLOR=$COLOR_RED
        PROMPT_PS1_PROMPT_CHARACTER='#'
    fi

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
        local user="$PROMPT_PS1_USER_COLOR\u$PROMPT_PS1_HOST_COLOR@\h"
        local location="$COLOR_IBLUE\w"
        local branch="$COLOR_YELLOW$gitps1"
        local prompt="$PROMPT_PS1_PROMPT_COLOR$PROMPT_PS1_PROMPT_CHARACTER"
        echo "$COLOR_OFF$user $location$branch\n$prompt$COLOR_OFF "
    }

    export PS1=$(colored_prompt)

fi
