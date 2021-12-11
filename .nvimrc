syntax on
filetype indent plugin on
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nonumber norelativenumber nospell
autocmd BufWinEnter,WinEnter term://* startinsert
" TODO: only compile tex once and copy resulting pdf to view.pdf
" autocmd BufWritePost *.tex exec 'Dispatch! cp % view.tex; pdflatex view.tex'
autocmd BufWritePost *.tex exec 'Dispatch! pdflatex %'

autocmd FileType markdown,text setlocal spell wrap
autocmd FileType tex,plaintex setlocal spell wrap
autocmd FileType text setlocal textwidth=78

autocmd BufReadPre *.s setlocal tabstop=8
autocmd BufNewFile *.c  0r ~/.vim/skeletons/skeleton.c
autocmd BufNewFile day*.rs  0r ~/.vim/skeletons/aoc.rs

set noequalalways
set nowrap
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
set clipboard=unnamedplus
set laststatus=2
set incsearch nohlsearch
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set shellpipe=>
set swapfile
set viewoptions-=options,curdir
set dir=~/tmp/nvim//,.
set directory=~/tmp/nvim//,.
set backupdir=~/tmp/nvim//,.

let mapleader=" "
let NERDTreeMinimalUI=1
let NERDTreeHijackNetrw=1
let g:python3_host_prog = '/usr/bin/python'

noremap ; :
"noremap : ;
nnoremap <Leader>; ;

nnoremap <S-Tab> <<_
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-e> $
imap <C-e> <Esc>A

" autofix spell errors
inoremap <C-f> <c-g>u<Esc>[s1z=`]a<c-g>u

nnoremap / :set hlsearch<CR>/
imap <C-L> <Right>
imap <C-S> <Esc>:w<CR>
vmap <C-S> :w<CR>
nmap <C-S> :w<CR>
nnoremap <BS> X
nmap <F11> <BS>
nmap <F12> <Delete>
imap <F11> <BS>
imap <F12> <Delete>
imap <silent> <C-j> <Esc>:tabprevious<CR>
imap <silent> <C-k> <Esc>:tabnext<CR>
nmap <silent> <C-j> :tabprevious<CR>
nmap <silent> <C-k> :tabnext<CR>

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

cnoreabbrev <expr> T getcmdtype() == ":" && getcmdline() == 'T' ? 'Telescope' : 'T'
cnoreabbrev <expr> t getcmdtype() == ":" && getcmdline() == 't' ? 'Telescope' : 't'

nnoremap \gpf :Git push --force-with-lease<CR>
" TODO: make this work in multiple languages, support multiple vars
nnoremap \p ^iprintln!("{}", <Esc>A);<Esc>

nnoremap <Leader>t :sp<CR><C-W>J:res 10<CR>:setl wfh<CR>:terminal<CR>
nnoremap <Leader>T :tabnew<CR>:terminal<CR>
nnoremap <Leader>/ :set hlsearch!<CR>
nnoremap <Leader>, :tabmove -1<CR>
nnoremap <Leader>. :tabmove +1<CR>
nnoremap <Leader>0 ^
nnoremap <Leader>a ^
nnoremap <silent> <Leader>A :CocAction<CR>
" nnoremap <Leader>l :CocDisable<CR>
nnoremap <Leader>l :CocList<CR>
nnoremap <Leader>L :CocList<CR>
nnoremap <Leader>n :source ~/.nvimrc<CR>
nnoremap <Leader>cd :lcd %:h<CR> 
nnoremap <Leader>cj :cnext<CR> 
nnoremap <Leader>ck :cprev<CR> 
nnoremap <Leader>d :Dispatch 
nnoremap <Leader>D :Dispatch! 
nnoremap <Leader>s :set spell!<CR>
nnoremap <Leader>S :CocList symbols<CR>
nnoremap <Leader>k "zyiw:!man <C-R>z<CR>g
nnoremap <Leader>w :set wrap!<CR>
nnoremap <Leader>q :copen<CR>
nnoremap <Leader>z :let &scrolloff=999-&scrolloff<CR>:ZenMode<CR>
nnoremap <Leader>en :tabedit ~/.nvimrc<CR>
nnoremap <Leader>g :Git<CR>
nnoremap <Leader>G :Git 
nnoremap <Leader>R :CocRestart<CR> 

nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fc :Telescope coc 
nnoremap <leader>fds <cmd>Telescope coc document_symbols<cr>
nnoremap <leader>fws <cmd>Telescope coc workspace_symbols<cr>
" is there a difference to find_files?
nnoremap <leader>ff <cmd>Telescope fd<cr> 
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fl <cmd>Telescope loclist<cr>
nnoremap <leader>fm <cmd>Telescope man_pages<cr>
nnoremap <leader>fs <cmd>Telescope spell_suggest<cr>
nnoremap <leader>ft <cmd>Telescope live_grep<cr>TODO
nnoremap <leader>fq <cmd>Telescope quickfix<cr>

set splitbelow
set splitright
nnoremap <silent> <C-W><C-Q> :silent ZoomWinTabOut<CR><C-W><C-Q>

tnoremap <C-W> <C-\><C-n><C-W>
tnoremap <C-W><C-W> <C-W>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-H> <C-\><C-n><C-W><C-H>
tnoremap <C-J> <C-\><C-n><C-W><C-J>
tnoremap <C-K> <C-\><C-n><C-W><C-K>
tmap <silent> <C-Q> <C-\><C-n>:bd!<CR>
tmap <silent> <C-W><C-Q> <C-\><C-n>:bd!<CR>

nmap <Leader>cs :setlocal commentstring=
nmap <silent><C-_> gcc
vmap <silent><C-_> gc
imap <silent><C-_> <Esc>gccA

" augroup remember_folds
"     autocmd!
"     autocmd BufWinLeave ?* silent! mkview | filetype detect
"     autocmd BufWinEnter ?* silent! loadview | filetype detect
" augroup END

call plug#begin('~/.vim/plugged')
Plug 'dylanaraps/wal.vim'
Plug 'p00f/nvim-ts-rainbow'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'
Plug 'machakann/vim-sandwich'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'

Plug 'fannheyward/telescope-coc.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'folke/which-key.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'troydm/zoomwintab.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'fidian/hexmode'

Plug 'github/copilot.vim'
Plug 'sirver/ultisnips'
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

  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }

  require("nvim-treesitter.configs").setup {
    highlight = {
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- This may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    rainbow = {
      enable = true,
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    },
  }

  require("nvim-autopairs").setup {
    fast_wrap = {
      map = '<C-a>',
      end_key = ';',
      chars = { '{', '[', '(', '"', "'", "<" },
      pattern = string.gsub([[ [%s%;%'%"%>%]%)%}%,%.] ]], '%s+', ''),
    },
  }

    local remap = vim.api.nvim_set_keymap
    local Rule = require('nvim-autopairs.rule')
    local cond = require('nvim-autopairs.conds')
    local npairs = require('nvim-autopairs')

    -- npairs.remove_rule("'")
    npairs.add_rules(
        {
            -- TODO: don't add after a space
            Rule("<", ">", "rust")
            :with_pair(cond.not_after_regex_check("[%w%<%[%{%\"%'%.]"))
            :with_move(function(opts)
                return opts.prev_char:match('%>') ~= nil
            end)
        },
        {
            -- TODO: this is broken
            Rule("'", "'", "rust")
            :with_pair(cond.not_before_text_check('&'))
        }
    )

    -- skip it, if you use another global object
    _G.MUtils= {}

    MUtils.completion_confirm=function()
      if vim.fn.pumvisible() ~= 0  then
          return npairs.esc("<cr>")
      else
        return npairs.autopairs_cr()
      end
    end


    remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
    local actions = require('telescope.actions')
  require("telescope").setup{
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          ["<C-h>"] = "which_key",
          -- add_to_qflist if we don't want to overwrite existing entries
          ["<C-q>"] = actions.send_to_qflist,
          ["<Esc>"] = "close",
        },
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      },
    },
  }

  require("telescope").load_extension('fzf')
  require("telescope").load_extension('coc')
EOF

" replace tab mapping
imap <silent><script><expr> <C-T> copilot#Accept("")
let g:copilot_no_tab_map = v:true

nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>
inoremap <silent><expr> <C-x><C-o> coc#refresh()
inoremap <silent><expr> <C-y> :call CocActionAsync('showSignatureHelp')
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
" nmap <silent> gi <Plug>(coc-implementation) " gi used for last insert
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gs <Plug>(coc-range-select)
xmap <silent> gs <Plug>(coc-range-select)

nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

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

highlight CocErrorSign ctermfg=4
highlight CocErrorVirtualText ctermfg=4
highlight CocWarningSign ctermfg=6
highlight CocWarningVirtualText ctermfg=6

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
  let l:pallete.inactive.left = [ [ 'NONE', 'NONE', '10', '8' ] ]
  let l:pallete.inactive.right = [ [ 'NONE', 'NONE', '10', '8' ] ]
  let l:pallete.inactive.middle = [ [ 'NONE', 'NONE', '10', '8' ] ]
  let l:pallete.tabline.left = l:pallete.normal.middle
  let l:pallete.tabline.middle = l:pallete.normal.middle
  let l:pallete.tabline.right = l:pallete.normal.middle
  let l:pallete.tabline.tabsel = [ [ 'NONE', 'NONE', 'NONE', '10' ] ]
  call lightline#colorscheme()
endfunction

colorscheme wal

if v:progname =~? "evim"
  finish
endif

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
