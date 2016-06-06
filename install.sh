#!/bin/bash
KERNEL="$(uname -s)";

PATH_TO_FILE="$(cd `dirname $0` && pwd)";

export		RED="[0;31m"
export		GREEN="[0;32m"
export		DEFAULT="[0;39m"

if [[ "$EMAIL_GIT" == "" ]]; then
  echo "Please enter your email to use with Git" 
  read EMAIL_GIT
  echo "export EMAIL_GIT=${EMAIL_GIT}" >> ~/.keys
fi

cd ${PATH_TO_FILE} && git submodule init && git submodule update 

# Git
if which git >/dev/null; then
  rm -rf ~/.gitconfig
  touch ${PATH_TO_FILE}/gitconfig 
  ln -s ${PATH_TO_FILE}/gitconfig ~/.gitconfig
  git config --global user.name "Franky W."
  git config --global user.email "${EMAIL_GIT}"
  git config --global merge.tool vimdiff
  git config --global color.ui true
  git config --global core.editor vim
  git config --global core.fileMode false
  git config --global core.excludesfile ${PATH_TO_FILE}/gitignore_global
  git config --global pager.diff ""
  git config --global alias.branchall "!git_branch_all"
  git config --global diff.tool vimdiff
  git config --global alias.vimdiff difftool
  git config --global alias.branchdiff '!git difftool $(git merge-base master HEAD)'
  git config --global alias.lg "log --graph --oneline --decorate --all"
  git config --global alias.s "status"
  git config --global alias.ci "commit"
  git config --global alias.co "checkout"
  git config --global alias.br "branch"
  git config --global alias.df "diff"
  git config --global alias.rb "rebase"
  git config --global alias.amend "commit --amend -C HEAD"
  git config --global alias.wdiff "diff --color-words"
  git config --global alias.aliases "config --get-regexp alias"
  git config --global alias.wip "!git add -A && git commit -m 'wip'"
  git config --global alias.rwd "!git checkout HEAD~"
  git config --global help.autocorrect 5 # Wait 50 ms before autocorrecting
  git config --global color.decorate.remote red
  git config --global color.decorate.head cyan
  git config --global color.decorate.branch green
  git config --global push.default current
  git config --global rerere.enabled true
  git config --global branch.autosetuprebase always
  git config --global fetch.prune true
else
  echo "${RED}Attention: ${DEFAULT} Git not found"
fi

