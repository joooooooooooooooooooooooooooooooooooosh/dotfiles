" Vim: set fdm=marker fmr={{{,}}} fdl=0 fdls=-1:
" autocmds {{{
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nonumber norelativenumber nospell

" enter insert mode only if cursor on same line as last prompt
autocmd BufWinEnter,WinEnter,TermOpen term://* silent! $/\$/?\$?mark z
    \| if ( line("'z") == line(".") )
        \| startinsert
    \| endif

autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | silent! checktime | endif
" TODO: only compile tex once and copy resulting pdf to view.pdf
" autocmd BufWritePost *.tex exec 'Dispatch! cp % view.tex; pdflatex view.tex'
autocmd BufWritePost *.tex exec 'Dispatch! tectonic %'
" TODO: some kind of autocmd to unload nvimrc in sessions
" autocmd BufWinLeave ~/.nvimrc exec 'bdelete ~/.nvimrc'

autocmd FileType markdown,text setlocal spell wrap
autocmd FileType tex,plaintex setlocal spell wrap
autocmd FileType text setlocal textwidth=78

" TODO: change comment style automatically
" autocmd BufReadPost,BufNewFile *.c set commentstring=//%s
autocmd BufReadPre,BufNewFile *.s setlocal tabstop=8 shiftwidth=8 expandtab
autocmd BufNewFile *.c  0r ~/.vim/skeletons/skeleton.c
autocmd BufNewFile day*.rs  0r ~/.vim/skeletons/aoc.rs
" }}}

" common settings {{{
syntax on
filetype indent plugin on
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
set clipboard=unnamedplus
set laststatus=3
set incsearch nohlsearch
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set shellpipe=>
set swapfile
set viewoptions-=options,curdir
set dir=$HOME/.vim/swapfiles//
set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/swapfiles//
" }}}

let mapleader=" "
let NERDTreeMinimalUI=1
let NERDTreeHijackNetrw=1
let g:python3_host_prog = '/usr/bin/python'

noremap ; :
"noremap : ;
nnoremap <Leader>; ;

" nnoremap <Tab> >>$
nnoremap <S-Tab> <<_
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
vnoremap > >gv
vnoremap < <gv
nmap <C-n> :NERDTreeFind<CR>
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

" tab navigation
imap <silent> <C-j> <Esc>:tabprevious<CR>
imap <silent> <C-k> <Esc>:tabnext<CR>
nmap <silent> <C-j> :tabprevious<CR>
nmap <silent> <C-k> :tabnext<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 10gt
nnoremap <leader><C-a> :tabfirst<CR>
nnoremap <leader><C-e> :tablast<CR>

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
cnoremap <expr> <C-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <C-p> wildmenumode() ? "\<c-p>" : "\<up>"

nnoremap zj gjzz
nnoremap zk gkzz

" enter blank lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" edit macros
" use "q<Leader>m
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

cnoreabbrev <expr> tn getcmdtype() == ":" && getcmdline() == 'tn' ? 'tabnew' : 'tn'
cnoreabbrev <expr> th getcmdtype() == ":" && getcmdline() == 'th' ? 'tabp' : 'th'
cnoreabbrev <expr> tl getcmdtype() == ":" && getcmdline() == 'tl' ? 'tabn' : 'tl'
cnoreabbrev <expr> te getcmdtype() == ":" && getcmdline() == 'te' ? 'tabedit' : 'te'
cnoreabbrev <expr> tc getcmdtype() == ":" && getcmdline() == 'tc' ? 'tabclose' : 'tc'

cnoreabbrev <expr> T getcmdtype() == ":" && getcmdline() == 'T' ? 'Telescope' : 'T'
cnoreabbrev <expr> t getcmdtype() == ":" && getcmdline() == 't' ? 'Telescope' : 't'

" TODO: make this work in multiple languages
nnoremap \p iprintln!("");<Esc>==0ci"
nnoremap \ap :s/\(\<[^ ]\+\)/{\1}/g<CR>^iprintln!("<Esc>A");<Esc>==
nnoremap \dp :s/\(\<[^ ]\+\)/{\1:?}/g<CR>^iprintln!("<Esc>A");<Esc>==
nnoremap \ep :s/\(\<[^ ]\+\)/{\1:#?}/g<CR>^iprintln!("<Esc>A");<Esc>==

nmap \op  o<Esc>\p
nmap \oap "zyiwo<C-R>z<Esc>\ap
nmap \odp "zyiwo<C-R>z<Esc>\dp
nmap \oep "zyiwo<C-R>z<Esc>\ep

nmap \t iTODO<Esc>gcc==A
nmap \j \t(joshh)
" cc clears auto comments added if this is being performed from a commented line
nmap \ot o<Esc>cc<Esc>\t: 
nmap \Ot O<Esc>cc<Esc>\t: 
nmap \oj o<Esc>cc<Esc>\j: 
nmap \Oj O<Esc>cc<Esc>\j: 

nmap \gr ?{<CR>?(<CR>Bgr
nmap \gd ?(<CR>Bgd

nnoremap <expr> \z foldclosed('.') != -1 ? 'zO' : 'zC'

" strip trailing whitespace
nnoremap <silent> \ws :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR><C-o>
" leader mappings {{{
nnoremap <Leader>t  :sp<CR><C-W>J:res 10<CR>:setl wfh<CR>:terminal<CR>
nnoremap <Leader>T  :tabnew<CR><Esc>:terminal<CR>
nnoremap <Leader>/  :set hlsearch!<CR>
nnoremap <Leader>,  :tabmove -1<CR>
nnoremap <Leader>.  :tabmove +1<CR>
nnoremap <Leader>0  ^
nnoremap <Leader>a  ^
nnoremap <silent> <Leader>A :CocAction<CR>
" nnoremap <Leader>l :CocDisable<CR>
nnoremap <Leader>l  :CocList<CR>
nnoremap <Leader>L  :CocList<CR>
nnoremap <Leader>n  :source ~/.nvimrc<CR>
nnoremap <Leader>cd :lcd %:h<CR>
nnoremap <Leader>cj :cnext<CR>
nnoremap <Leader>ck :cprev<CR>
nnoremap <Leader>d  :Dispatch 
nnoremap <Leader>D  :Dispatch! 
nnoremap <Leader>s  :set spell!<CR>
nnoremap <Leader>S  :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nnoremap <Leader>k  "zyiw:!man <C-R>z<CR>g
nnoremap <Leader>w  :set wrap!<CR>
nnoremap <Leader>q  :copen<CR>
nnoremap <Leader>z  :let &scrolloff=999-&scrolloff<CR>:ZenMode<CR>zz
nnoremap <Leader>en :tabedit ~/.nvimrc<CR>
nnoremap <Leader>g  :Git<CR>
nnoremap <Leader>G  :tabnew<CR>:Git<CR>
nnoremap <Leader>R  :CocRestart<CR>
nnoremap <Leader>u  :UndotreeToggle<CR>

nnoremap <Leader>fb  <cmd>Telescope buffers<cr>
nnoremap <Leader>fc  :Telescope coc 
nnoremap <Leader>fds <cmd>Telescope coc document_symbols<cr>
" don't hit enter for now since it tends to hang
nnoremap <Leader>fws <cmd>Telescope coc workspace_symbols<cr>
" is there a difference to find_files?
nnoremap <Leader>ff  <cmd>Telescope fd<cr>
nnoremap <Leader>fg  <cmd>Telescope live_grep<cr>
nnoremap <Leader>fl  <cmd>Telescope loclist<cr>
nnoremap <Leader>fm  <cmd>Telescope man_pages<cr>
nnoremap <Leader>fr  <cmd>Telescope grep_string<cr>
nnoremap <Leader>fs  <cmd>Telescope spell_suggest<cr>
" TODO: broken
" nnoremap <Leader>ft  <cmd>Telescope live_grep<cr>TODO
nnoremap <Leader>fu  <cmd>Telescope grep_string<cr>
nnoremap <Leader>fq  <cmd>Telescope quickfix<cr>
" }}}

set splitbelow
set splitright

" terminal mappings {{{
tnoremap <C-W> <C-\><C-n><C-W>
tnoremap <C-W><C-W> <C-W>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-J> <C-\><C-n>:tabprevious<CR>
tnoremap <C-K> <C-\><C-n>:tabnext<CR>
tmap <silent> <C-Q> <C-\><C-n>:bd!<CR>
tmap <silent> <C-W><C-Q> <C-\><C-n>:bd!<CR>
" }}}

" augroup remember_folds
"     autocmd!
"     autocmd BufWinLeave ?* silent! mkview | filetype detect
"     autocmd BufWinEnter ?* silent! loadview | filetype detect
" augroup END

" plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'joooooooooooooooooooooooooooooooooooosh/lightline.vim'
Plug 'joooooooooooooooooooooooooooooooooooosh/zoomwintab.vim'

Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'
Plug 'dylanaraps/wal.vim'

Plug 'p00f/nvim-ts-rainbow'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'
Plug 'machakann/vim-sandwich'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'akinsho/git-conflict.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'

Plug 'fannheyward/telescope-coc.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'phaazon/hop.nvim'
Plug 'https://gitlab.com/yorickpeterse/nvim-window.git'
Plug 'folke/which-key.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'

Plug 'kevinhwang91/nvim-ufo'
Plug 'kevinhwang91/promise-async'

Plug 'fidian/hexmode'
call plug#end()
" }}}

let g:sonokai_better_performance = 1
let g:sonokai_transparent_background = 1
let g:everforest_better_performance = 1
let g:everforest_transparent_background = 1
set termguicolors
" colorscheme wal
" colorscheme sonokai
colorscheme everforest
" highlight DiffAdd  guibg=#145214
highlight DiffText guibg=#004d66

" lua configuration {{{
lua << EOF
require("hop").setup {
    multi_windows = true,
}

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
    plugins = {
        spelling = {
            enabled = true,
            suggestions = 20,
        }
    },
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
require("telescope").setup {
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
            -- ["<Esc>"] = "close",
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

require('git-conflict').setup {
    default_mappings = true, -- disable buffer local mapping created by this plugin
    disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
    highlights = { -- They must have background color, otherwise the default color will be used
        incoming = 'DiffText',
        current = 'DiffAdd',
    }
}

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' ...  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

vim.o.foldcolumn = '0'
vim.o.foldlevel = 99 -- feel free to decrease the value
vim.o.foldenable = true

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- global handler
require('ufo').setup({
    fold_virt_text_handler = handler
})

-- buffer scope handler
-- will override global handler if it is existed
local bufnr = vim.api.nvim_get_current_buf()
require('ufo').setFoldVirtTextHandler(bufnr, handler)

require('nvim-window').setup({
    -- The characters available for hinting windows.
    chars = {
        'q', 'w', 'e', 'o', 'k', "'", 'd', 'i', 'j', 'l', ';', 's', 'a',
    },

    -- A group to use for overwriting the Normal highlight group in the floating
    -- window. This can be used to change the background color.
    normal_hl = 'BlackOnLightYellow',

    -- The highlight group to apply to the line that contains the hint characters.
    -- This is used to make them stand out more.
    hint_hl = 'Bold',

    -- The border style to use for the floating window.
    border = 'none'
})

EOF
hi BlackOnLightYellow guifg=#000000 guibg=#f2de91
" }}}

" Git diff hunk commands from the perspective of the working copy.
" nnoremap [d :diffget //2 | diffup<CR>
" nnoremap =d :diffput % | diffup<CR>
" nnoremap ]d :diffget //3 | diffup<CR>

" plugin key mappings {{{
map <silent> <C-p> :lua require('nvim-window').pick()<CR>
nmap <silent> <Leader>; :HopWord<CR>

autocmd FileType c,cpp setlocal commentstring=//%s
nnoremap \cx :Dispatch! chmod +x %<CR>
nnoremap \gpf :Git push --force-with-lease<CR>

nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>
inoremap <silent><expr> <C-x><C-o> coc#refresh()

inoremap <silent><expr> <C-y> CocActionAsync('showSignatureHelp')

" inoremap <silent><expr> <Tab>   coc#pum#visible() ? "\<C-n>" : "\<Tab>"
" inoremap <silent><expr> <S-Tab> coc#pum#visible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <Tab>    coc#pum#visible() ? coc#pum#confirm() : "\<cr>"

nnoremap <expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
inoremap <expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
nnoremap <silent> \ca <plug>(coc-codeaction-cursor)
nnoremap <silent> \cl <plug>(coc-codeaction-line)
nnoremap <silent> \cc <plug>(coc-codeaction)
nnoremap <silent> \cs <plug>(coc-codeaction-selected)
vnoremap <silent> \cs <plug>(coc-codeaction-selected)

nnoremap \s  :CocCommand clangd.switchSourceHeader<CR>

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>=  <Plug>(coc-format-selected)
nmap <leader>=  <Plug>(coc-format-selected)
nmap <silent> gd :Telescope coc definitions<CR>
nmap <silent> gy :Telescope coc type_definitions<CR>
nmap <silent> gi :Telescope coc implementations<CR>
nmap <silent> gr :Telescope coc references<CR>
nmap <silent> gs <Plug>(coc-range-select)
xmap <silent> gs <Plug>(coc-range-select)

nnoremap gl gi
nnoremap <silent> <C-W><C-Q> :silent ZoomWinTabOut<CR><C-W><C-Q>

nmap <Leader>cs :setlocal commentstring=
nmap <silent><C-_> gcc
vmap <silent><C-_> gc
imap <silent><C-_> <Esc>gccA

nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    silent call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

highlight CocErrorSign ctermfg=4
highlight CocErrorVirtualText ctermfg=4
highlight CocWarningSign ctermfg=6
highlight CocWarningVirtualText ctermfg=6
" }}}

" lightline {{{
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
  let l:pallete.tabline.tabsel = [ [ '#f39660', 'NONE', 'NONE', '10' ] ]
  call lightline#colorscheme()
endfunction
" }}}

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
