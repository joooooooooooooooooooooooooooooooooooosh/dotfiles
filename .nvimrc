syntax on
filetype indent plugin on
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nonumber norelativenumber nospell
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufWritePost *.tex exec 'Dispatch! cp % view.tex; pdflatex view.tex'
autocmd BufWritePost *.tex exec 'Dispatch! pdflatex %'
autocmd FileType markdown setlocal spell
autocmd FileType tex setlocal spell
autocmd FileType plaintex setlocal spell
" autocmd * setlocal tabstop=4
" autocmd * setlocal shiftwidth=4
set tabstop=4 shiftwidth=4
set omnifunc=syntaxcomplete#Complete
set mouse=a
set t_Co=256
set belloff=all
set backspace=indent,eol,start
set timeoutlen=750
set updatetime=500
set hidden
set autoindent
set autoread
set ruler
set number
set relativenumber
set signcolumn=number
set ignorecase smartcase
set expandtab
set foldmethod=manual
" set spell
"set clipboard=unnamed
" set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
set clipboard=unnamedplus
set laststatus=2
set incsearch nohlsearch
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set shellpipe=>
set swapfile
set viewoptions-=options
set dir=~/tmp/nvim//,.
set directory=~/tmp/nvim//,.
set backupdir=~/tmp/nvim//,.

let mapleader=" "
let NERDTreeMinimalUI=1
let g:python3_host_prog = '/usr/bin/python'

noremap ; :
"noremap : ;
"nnoremap <Tab> """>>_
"noremap <ESC>[5;5~ :tabnext<CR>
"noremap <ESC>[6;5~ :tabprev<CR>
nnoremap <Leader>; ;

nmap <Leader>p <Leader>aggi#!/usr/bin/python3<CR>import pwn<CR>p = pwn.process("<Esc>:r !echo %<CR>kJx$xxxa")<Esc>yypf.lcwgdb.debug<Esc>0i# <Esc>o# pwn.context.log_level = 'debug'<CR>p.interactive()<Esc>:w<CR><Leader>dchmod +x %<CR><Leader>a

nnoremap <S-Tab> <<_
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-e> $
" nmap <silent><Leader>g :call setbufvar(winbufnr(popup_atcursor(split(system("git log -n 1 -L " . line(".") . ",+1:" . expand("%:p")), "\n"), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })), "&filetype", "git")<CR>

nnoremap / :set hlsearch<CR>/
imap <C-L> <Right>
imap <C-S> <Esc>:w<CR>
vmap <C-S> :w<CR>
nmap <C-S> :w<CR>
nnoremap <BS> X
" nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
" imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
nmap <F11> <BS>
nmap <F12> <Delete>
imap <F11> <BS>
imap <F12> <Delete>

" imap <Leader>c <Esc>:set list!<CR>i
" nmap <Leader>c :set list!<CR>
" nmap <Leader>x :Dispatch latexmk -pvc -pdf %<CR>

" consistent N/n search directions
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

" C-n and C-p match start of command when searching history
cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"

" enter blank lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" edit macros
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

cnoreabbrev <expr> tn getcmdtype() == ":" && getcmdline() == 'tn' ? 'tabnew' : 'tn'
cnoreabbrev <expr> th getcmdtype() == ":" && getcmdline() == 'th' ? 'tabp' : 'th'
cnoreabbrev <expr> tl getcmdtype() == ":" && getcmdline() == 'tl' ? 'tabn' : 'tl'
cnoreabbrev <expr> te getcmdtype() == ":" && getcmdline() == 'te' ? 'tabedit' : 'te'
cnoreabbrev <expr> tc getcmdtype() == ":" && getcmdline() == 'tc' ? 'tabclose' : 'tc'

" cnoreabbrev <expr> Ack getcmdtype() == ":" && getcmdline() == 'Ack' ? 'Ack!' : 'Ack'
" cnoreabbrev <expr> F getcmdtype() == ":" && getcmdline() == 'F' ? 'Files' : 'F'

" nnoremap <Leader>a :Ack!<Space>
" nnoremap <Leader>f :AckFile!<Space>
nnoremap <Leader>a :call AutoPairsToggle()<CR>
nnoremap <Leader>t :sp<CR><C-W>J:res 10<CR>:setl wfh<CR>:terminal<CR>
nnoremap <Leader>T :sp<CR><C-W>J:res 10<CR>:terminal<CR><Esc><C-W>o
nnoremap <Leader>/ :set hlsearch!<CR>
nnoremap <Leader>o :FZFExplore<CR>
nnoremap <Leader>l :LspStopServer<CR>
nnoremap <Leader>n :source ~/.nvimrc<CR>
nnoremap <Leader>d :Dispatch 
nnoremap <Leader>D :Dispatch! 
nnoremap <Leader>s :set spell!<CR>
nnoremap <Leader>k "zyiw:!man <C-R>z<CR>g
nnoremap <Leader>z :ZenMode<CR>
nnoremap <Leader>en :tabedit ~/.nvimrc<CR>
nnoremap <Leader>g :GitGutterToggle<CR>
nnoremap <Leader>G :Git 

set splitbelow
set splitright
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <C-P> <C-W>p
nnoremap <silent> <C-W><C-Q> :silent ZoomWinTabOut<CR><C-W><C-Q>

tnoremap <C-W> <C-\><C-n><C-W>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-H> <C-\><C-n><C-W><C-H>
tnoremap <C-J> <C-\><C-n><C-W><C-J>
tnoremap <C-K> <C-\><C-n><C-W><C-K>
" tnoremap <C-L> <C-\><C-n><C-W><C-L>
" tnoremap <C-J> <C-\><C-n><C-W>:tabnext<CR>
" tnoremap <C-K> <C-\><C-n><C-W>:tabprev<CR>
tnoremap <silent> <C-Q> <C-\><C-n>:silent ZoomWinTabOut<CR><C-W><C-Q>
tnoremap <silent> <C-W><C-Q> <C-\><C-n>:silent ZoomWinTabOut<CR><C-W><C-Q>
" tnoremap <ESC>[5;5~ <C-W>:tabnext<CR>
" tnoremap <ESC>[6;5~ <C-W>:tabprev<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <Leader>c :setlocal commentstring=
nmap <silent><C-_> gcc
vmap <silent><C-_> gcc
" TODO: only works for commenting not uncommenting
imap <silent><C-_> <Esc>gccg`^la

augroup remember_folds
    autocmd!
    autocmd BufWinLeave ?* silent! mkview | filetype detect
    autocmd BufWinEnter ?* silent! loadview | filetype detect
augroup END

call plug#begin('~/.vim/plugged')
Plug 'dylanaraps/wal.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'
 Plug 'tpope/vim-commentary'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'folke/which-key.nvim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'troydm/zoomwintab.vim'
Plug 'folke/zen-mode.nvim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
call plug#end()

lua << EOF
  require("zen-mode").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    window = {
      width = 90,
    },
  }
EOF

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}
EOF

nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>
inoremap <silent><expr> <C-x><C-o> coc#refresh()
nnoremap <expr><C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <expr><C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <expr><C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
inoremap <expr><C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>=  <Plug>(coc-format-selected)
nmap <leader>=  <Plug>(coc-format-selected)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gs <Plug>(coc-range-select)
xmap <silent> gs <Plug>(coc-range-select)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" autocmd CursorHold * if ! coc#util#has_float() | call CocActionAsync('doHover') | endif 

colorscheme wal
"let g:ack_use_dispatch = 1

highlight CocErrorSign ctermfg=4
highlight CocErrorVirtualText ctermfg=4
highlight CocWarningSign ctermfg=6
highlight CocWarningVirtualText ctermfg=6

" Search pattern across repository files
function! FzfExplore(...)
    let inpath = substitute(a:1, "'", '', 'g')
    if inpath == "" || matchend(inpath, '/') == strlen(inpath)
        execute "cd" getcwd() . '/' . inpath
        let cwpath = getcwd() . '/'
        call fzf#run(fzf#wrap(fzf#vim#with_preview({'source': 'ls -1ap', 'dir': cwpath, 'sink': 'FZFExplore', 'options': ['--prompt', cwpath]})))
    else
        let file = getcwd() . '/' . inpath
        execute "e" file
    endif
endfunction

command! -nargs=* FZFExplore call FzfExplore(shellescape(<q-args>))

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
