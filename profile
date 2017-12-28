#!/usr/bin/env bash

DOT_PROMPT_TYPE="$1"

# if [ ! -n "$DOT_PROMPT" ] && [ -n "$BASH_VERSION" ]; then
if [ -n "$BASH_VERSION" ]; then

    export DOT_PROMPT=1

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
    case "$DOT_PROMPT_TYPE" in
        "prod")
            PROMPT_PS1_HOST_COLOR=$COLOR_IGREEN
        ;;
        "dev")
            PROMPT_PS1_HOST_COLOR=$COLOR_IPURPLE
        ;;
        "local")
            PROMPT_PS1_HOST_COLOR=$COLOR_ICYAN
        ;;
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

    __user ()
    {
      local git_user_config="$(git config user.email)"
      echo "${GIT_AUTHOR_EMAIL:-$git_user_config}"
    }

    __git_ps1_user ()
    {
      local git_user="$(__user)"

      if [ -n "$git_user" ] && [ "$DOT_PROMPT_TYPE" = 'local' ]; then
        echo "$git_user"
      else
        echo "$(whoami)"
      fi
    }

    __git_ps1_host ()
    {
      local git_user="$(__user)"

      if [ -n "$git_user" ] && [ "$DOT_PROMPT_TYPE" = 'local' ]; then
        echo ""
      else
        echo "@$(hostname -s)"
      fi
    }

    function colored_prompt
    {
        local gitps1=$( [ `type -t __git_ps1` ] && echo '$(__git_ps1 " (%s)")' || echo '' )

        # local user="$PROMPT_PS1_USER_COLOR\u"
        # local host="$PROMPT_PS1_HOST_COLOR@\h"
        local user="$PROMPT_PS1_USER_COLOR"'$(__git_ps1_user)'
        local host="$PROMPT_PS1_HOST_COLOR"'$(__git_ps1_host)'

        # local location="$COLOR_IBLUE\w"
        local location="$COLOR_IBLUE\$PS1_PATH"
        local branch="$COLOR_YELLOW$gitps1"
        local prompt="$PROMPT_PS1_PROMPT_COLOR$PROMPT_PS1_PROMPT_CHARACTER"
        echo "$COLOR_OFF$user$host $location$branch\n$prompt$COLOR_OFF "
    }

    # https://unix.stackexchange.com/a/275016
    PROMPT_COMMAND='PS1_PATH=$(sed "s:\([^/\.]\)[^/]*/:\1/:g" <<< ${PWD/#$HOME/\~})'
    export PS1=$(colored_prompt)

fi
