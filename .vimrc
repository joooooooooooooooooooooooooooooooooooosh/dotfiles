set nocompatible
syntax on
filetype indent plugin on
set omnifunc=syntaxcomplete#Complete
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
set laststatus=2
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set shellpipe=>
noremap ; :
"noremap : ;
"nnoremap <Tab> """>>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nmap <Leader>t :term<CR><C-W>J<C-W>:res 10<CR>
nmap <silent><Leader>g :call setbufvar(winbufnr(popup_atcursor(split(system("git log -n 1 -L " . line(".") . ",+1:" . expand("%:p")), "\n"), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })), "&filetype", "git")<CR>
nnoremap <C-_> :set hlsearch!<CR>
imap <C-L> <Right>
imap <C-S> <Esc>:w<CR>
vmap <C-S> :w<CR>
nmap <C-S> :w<CR>
nnoremap <BS> X
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
"imap <C-A> <Esc>:set list!<CR>i
"nmap <C-A> :set list!<CR>

cnoreabbrev <expr> tn getcmdtype() == ":" && getcmdline() == 'tn' ? 'tabnew' : 'tn'
cnoreabbrev <expr> th getcmdtype() == ":" && getcmdline() == 'th' ? 'tabp' : 'th'
cnoreabbrev <expr> tl getcmdtype() == ":" && getcmdline() == 'tl' ? 'tabn' : 'tl'
cnoreabbrev <expr> te getcmdtype() == ":" && getcmdline() == 'te' ? 'tabedit' : 'te'

cnoreabbrev <expr> Ack getcmdtype() == ":" && getcmdline() == 'Ack' ? 'Ack!' : 'Ack'
nnoremap <Leader>a :Ack!<Space>
nnoremap <Leader>f :AckFile!<Space>

set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

call plug#begin('~/.vim/plugged')
Plug 'dylanaraps/wal.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-dispatch'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

colorscheme wal
"let g:ack_use_dispatch = 1

let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

"let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['5', '4', '2', '11', 'white']

autocmd VimEnter * call SetupLightlineColors()
function SetupLightlineColors() abort
  let l:pallete = lightline#palette()
  let l:pallete.normal.left = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.normal.right = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.visual.left = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.visual.right = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.visual.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.replace.left = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.replace.right = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.replace.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.insert.left = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.insert.right = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.insert.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.inactive.left = [ [ 'NONE', 'NONE', '0', '8' ] ]
  let l:pallete.inactive.right = [ [ 'NONE', 'NONE', '0', '8' ] ]
  let l:pallete.inactive.middle = [ [ 'NONE', 'NONE', '0', '8' ] ]
  let l:pallete.tabline.left = l:pallete.normal.middle
  let l:pallete.tabline.middle = l:pallete.normal.middle
  let l:pallete.tabline.right = l:pallete.normal.middle
  let l:pallete.tabline.tabsel = [ [ 'NONE', 'NONE', 'NONE', '10' ] ]
  call lightline#colorscheme()
endfunction

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
