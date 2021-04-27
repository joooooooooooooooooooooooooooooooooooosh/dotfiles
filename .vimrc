syntax on
filetype indent plugin on
set t_Co=256
set belloff=all
set backspace=indent,eol,start
set autoindent
set ruler
set number
set relativenumber
set ignorecase
set smartcase
set expandtab
"set clipboard=unnamed
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
set clipboard=unnamedplus
"set laststatus=2
set undofile
set undodir=~/.vim/undo
set undolevels=1000
let g:rainbow_active = 1
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap <C-L> :set hlsearch!<CR><C-L>
imap <C-L> <Right>
imap <C-S> <Esc>:w<CR>
vmap <C-S> :w<CR>
nmap <C-S> :w<CR>
nnoremap <BS> X
"nmap <C-J> <C-D>
"nmap <C-K> <C-U>
"imap jk <Esc>
imap <C-A> <Esc>:set list!<CR>i
nmap <C-A> :set list!<CR>
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

call plug#begin('~/.vim/plugged')
Plug 'dylanaraps/wal.vim'
call plug#end()

colorscheme wal

"set rtp+=~/.vim/tabnine-vim/
"set rtp+=~/.vim/pack/plugins/start/lightline
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  "if has('persistent_undo')
  "  set undofile	" keep an undo file (undo changes after closing)
  "endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
