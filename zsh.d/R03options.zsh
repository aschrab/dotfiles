setopt \
  Always_Last_Prompt \
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
  Magic_Equal_Subst \
  Mail_Warning \
  No_Equals \
  Notify \
  Numeric_Glob_Sort \
  Print_Exit_Value \
  Prompt_Subst \
  PushD_Ignore_Dups \
  RC_Quotes \
  rm_Star_Silent \
  Typeset_Silent

unsetopt \
  All_Export \
  Beep \
  Clobber \
  Correct_All \
  HUP \
  Ignore_EOF \
  Prompt_CR

if is-at-least 3.0; then
  setopt Function_ArgZero Mult_IOs
fi

unset HISTFILE
export HISTSIZE=2000
export NULLCMD=:
export HISTORY=${ZDOTDIR:=$HOME}/.zsh-history

WORDCHARS='`~!@#$%^&*()-_+{}[]\|:;",.<>/?'\'

typeset -gaU preexec_functions
typeset -gaU precmd_functions
typeset -gaU chpwd_functions
