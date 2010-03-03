# vim: ft=zsh

setopt \
  Always_Last_Prompt \
  All_Export \
  Always_to_End \
  Auto_cd \
  Auto_List \
  Auto_Menu \
  Auto_Param_Keys \
  Auto_Pushd \
  Auto_Remove_Slash \
  Auto_Resume \
  Correct \
  Extended_Glob \
  Glob_Complete \
  List_Types \
  Mail_Warning \
  Notify \
  Numeric_Glob_Sort \
  Print_Exit_Value \
  Prompt_Subst \
  rm_Star_Silent
unsetopt \
  Beep \
  Clobber \
  Correct_All \
  HUP \
  Ignore_EOF \
  Prompt_CR

if [[ $ZSH_MAJOR_VERSION -ge 3 ]]; then
  setopt Equals Function_ArgZero Mult_IOs
else
  unsetopt No_Equals
fi

unset HISTFILE
export HISTSIZE=250
export NULLCMD=:
export HISTORY=${ZDOTDIR:=$HOME}/.zsh-history
