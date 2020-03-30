 set runtimepath^=~/.vim runtimepath+=~/.vim/after
 let &packpath = &runtimepath
 source ~/.vimrc
 " load local vimrc configs
if filereadable(expand("~/.local/vimrc"))
  source ~/.local/vimrc
endif
