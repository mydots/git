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
if command -v git >/dev/null; then
  rm -rf ~/.gitconfig
  touch ${PATH_TO_FILE}/gitconfig 
  ln -s ${PATH_TO_FILE}/gitconfig ~/.gitconfig
  git config --global user.name "Franky W."
  git config --global user.email "${EMAIL_GIT}"
  git config --global merge.tool vimdiff
  git config --global color.ui true
  git config --global column.ui auto
  git config --global branch.autosetuprebase always
  git config --global branch.sort -committerdate
  git config --global tag.sort version:refname

  git config --global core.editor vim
  git config --global core.fileMode false
  git config --global core.excludesfile ${PATH_TO_FILE}/gitignore_global
  git config --global core.attributesfile ${PATH_TO_FILE}/gitattributes

  git config --global diff.rspec.xfuncname "^[ \t]*((RSpec|describe|context|it|before|after|around|feature|scenario|background)[ \t].*)$"
  if command -v brew >/dev/null; then
    git config --global core.pager "\`brew --prefix\`/share/git-core/contrib/diff-highlight/diff-highlight | less"
  fi
  git config --global diff.algorithm histogram
  git config --global diff.tool vimdiff
  git config --global diff.sopsdiffer.textconv "sops --decrypt"
  git config --global diff.colorMoved plain
  git config --global diff.mnemonicPrefix true
  git config --global diff.renames true
  git config --global grep.lineNumber true

  git config --global help.autocorrect 5 # Wait 50 ms before autocorrecting
  git config --global color.decorate.remote red
  git config --global color.decorate.head cyan
  git config --global color.decorate.branch green
  git config --global push.default current
  git config --global push.autoSetupRemote true
  git config --global push.followTags true
  git config --global rerere.enabled true
  git config --global rerere.autoupdate true
  git config --global fetch.prune true
  git config --global fetch.pruneTags true
  git config --global fetch.all true
  git config --global commit.verbose true


  git config --global alias.vimdiff difftool
  git config --global alias.branchdiff 'diff main...HEAD'
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
  git config --global alias.pushf "!git push --force-with-lease"
  git config --global alias.addnw "!sh -c 'git diff -U0 -w --no-color \"\$@\" | git apply --cached --ignore-whitespace --unidiff-zero -'"
  git config --global diff.sposdiffer.textconv "sops --decrypt"

  git config --global pull.rebase true
  for binary in $(ls ${PATH_TO_FILE}/bin); do
    git config --global alias.${binary} "!${PATH_TO_FILE}/bin/${binary}"
  done
  git config --global url.ssh://git@github.com/.insteadOf https://github.com/
  git config --global init.defaultBranch main
else
  echo "${RED}Attention: ${DEFAULT} Git not found"
fi

