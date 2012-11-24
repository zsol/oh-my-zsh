CLOUD='☁'
SUN='☼'
PROMPT='%(?.%F{yellow}.%F{cyan})%(?.$SUN.$CLOUD)%f %{$fg_bold[blue]%}%D{[%I:%M:%S]} %{$fg[green]%}%~ %{$reset_color%}$(git_prompt_info)$(bzr_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

## Bazaar integration
bzr_prompt_info() {
  BZR_CB=$(bzr nick 2>/dev/null | grep -v "ERROR")
  if [ -n "$BZR_CB" ]; then
    BZR_CB="bzr::$BZR_CB"
    BZR_DIRTY=""
    [[ -n `bzr status` ]] && BZR_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$BZR_CB$BZR_DIRTY$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Checks if working tree is dirty
parse_git_dirty() {
  local SUBMODULE_SYNTAX=''
  if [[ $POST_1_7_2_GIT -gt 0 ]]; then
        SUBMODULE_SYNTAX="--ignore-submodules=dirty"
  fi
  if git diff-index --quiet head ${SUBMODULE_SYNTAX}  2> /dev/null ; then
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  else
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi
}

