" Vim: set fdm=marker fmr={{{,}}} fdl=0 fdls=-1:
" autocmds {{{
autocmd TermOpen * startinsert
autocmd TermOpen * setlocal nonumber norelativenumber nospell winfixheight

" enter insert mode only if cursor on same line as last prompt
autocmd BufEnter term://* silent! $/\$/?[$>]?mark z
    \| if ( line("'z") == line(".") )
        \| startinsert
    \| endif

autocmd BufLeave term://* silent! stopinsert

" crappy proportion replacement
autocmd VimResized * wincmd =

autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | silent! checktime | endif
" TODO: only compile tex once and copy resulting pdf to view.pdf
autocmd BufWritePost *.tex exec 'Dispatch! cp % view.tex; tectonic view.tex'
autocmd BufWritePost *.tex exec 'Dispatch! tectonic %'
" TODO: some kind of autocmd to unload nvimrc in sessions
" autocmd WinClosed ~/.nvimrc exec 'bunload \~\/\.nvimrc | bdelete \~\/\.nvimrc'

autocmd FileType markdown,text setlocal spell wrap
autocmd FileType tex,plaintex setlocal spell wrap
autocmd FileType text setlocal textwidth=78
autocmd FileType make setlocal list
autocmd FileType typescript,javascript,typescriptreact,yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType sh,bash,zsh setlocal tabstop=8 shiftwidth=8 expandtab list

" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" TODO: change comment style automatically
" autocmd BufReadPost,BufNewFile *.c set commentstring=//%s
autocmd BufReadPre,BufNewFile *.s setlocal tabstop=8 shiftwidth=8 expandtab
autocmd BufNewFile *.c  0r ~/.vim/skeletons/skeleton.c
autocmd BufNewFile day*.rs  0r ~/.vim/skeletons/aoc.rs
" autocmd BufWritePre *.hs CocCommand editor.action.formatDocument
" }}}

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" common settings {{{
syntax on
filetype indent plugin on
set titlestring=%F
set noequalalways
set nowrap
set tabstop=4 shiftwidth=4
set scrolloff=4
set omnifunc=syntaxcomplete#Complete
set mouse=a
set t_Co=256
set belloff=all
set backspace=indent,eol,start
set timeoutlen=750
set updatetime=500
set hidden
set spell
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

" 3141 hack
nnoremap <Space>re <C-W>l:r<CR>

let mapleader=" "
let NERDTreeMinimalUI=1
let NERDTreeHijackNetrw=1
let g:python3_host_prog = '/usr/bin/python3'
let g:netrw_browsex_viewer = "open"

noremap ; :
"noremap : ;
" nnoremap <Leader>; ;

" nnoremap <Tab> >>$
nnoremap <S-Tab> <<_
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
vnoremap > >gv
vnoremap < <gv
vnoremap . :normal .<CR>
nmap <C-n> <CMD>NvimTreeFindFileToggle<CR>
nnoremap <silent> <Plug>(default-ctrl-e) <C-e>
nnoremap <silent> <Plug>(default-ctrl-y) <C-y>
nmap <C-e> $
imap <C-e> <Esc>A
imap <C-a> <Esc>^i

nmap <silent> <C-h> <Plug>(default-ctrl-e)
" nmap <silent> zj <Plug>(default-ctrl-e)
" nmap <silent> zk <Plug>(default-ctrl-y)

" clear quickfix list
nmap <Leader>cc <CMD>cexpr []<CR>

nmap <Leader>cp <CMD>%y<CR>

" autofix spell errors
inoremap <C-x><C-x> <c-g>u<Esc>[s1z=`]a<c-g>u

nnoremap / :set hlsearch<CR>/
imap <C-L> <Right>
imap <C-S> <Esc><CMD>silent w<CR>
vmap <C-S> <Esc><CMD>silent w<CR>
nmap <C-S> <CMD>silent w<CR>
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

" function! s:Gx()
"   let l:url = expand("<cWORD>")
"   " execute "!xdg-open " . shellescape(l:url, 1)
"   execute "Dispatch! xdg-open " . shellescape(l:url, 1)
" endfunction

" nmap <silent> gx :call <SID>Gx()<CR>

nnoremap gp `[v`]

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
nnoremap \ap :s/\(\<[^ ]\+\)/{\1}/g<CR>^iprintln!("<Esc>A");<Esc>==:set nohlsearch<CR>
nnoremap \dp :s/\(\<[^ ]\+\)/{\1:?}/g<CR>^iprintln!("<Esc>A");<Esc>==:set nohlsearch<CR>
nnoremap \ep :s/\(\<[^ ]\+\)/{\1:#?}/g<CR>^iprintln!("<Esc>A");<Esc>==:set nohlsearch<CR>

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

nmap \gr [m]ngr
nmap \gd ?(<CR>Bgd

nmap \f :%!rustfmt<CR>

nnoremap <expr> \z foldclosed('.') != -1 ? 'zO' : 'zC'

" Terminal Function
let g:term_height = 12
let g:term_buf = 0
let g:term_win = 0
function! TermToggle()
    if win_gotoid(g:term_win)
        let g:term_height = winheight("")
        hide
    else
        botright new
        exec "resize " . g:term_height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction
nnoremap <silent> <Leader><C-t> :let g:term_height=50<CR>:call TermToggle()<CR>
nnoremap <silent> <C-t> :call TermToggle()<CR>
inoremap <silent> <C-t> <Esc>:call TermToggle()<CR>
tnoremap <silent> <C-t> <C-\><C-n>:call TermToggle()<CR>


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
nnoremap <silent> <Leader>A <CMD>CocAction<CR>
nnoremap <Leader>L  <CMD>CocList<CR>
nnoremap <Leader>cr <CMD>CocRestart<CR>
nnoremap <Leader>n  <CMD>source ~/.nvimrc<CR>
nnoremap <Leader>cd <CMD>lcd %:h<CR>
nnoremap <Leader>j <CMD>cnext<CR>zz
nnoremap <Leader>k <CMD>cprev<CR>zz
nnoremap <Leader>d      :Dispatch 
nnoremap <Leader>D      :Dispatch! 
nnoremap <Leader>sl  <CMD>set list!<CR>
nnoremap <Leader>ss  <CMD>set spell!<CR>
nnoremap <Leader>S  <CMD>let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" nnoremap <Leader>k  "zyiw:!man <C-R>z<CR>g
nnoremap <Leader>ww  <CMD>set wrap!<CR>
nnoremap <Leader>q  <CMD>copen<CR>
nnoremap <Leader>z  <CMD>let &scrolloff=999-&scrolloff<CR>:ZenMode<CR>zz
nnoremap <Leader>en <CMD>tabedit ~/.nvimrc<CR>
nnoremap <Leader>lg <CMD>LazyGit<CR>
nnoremap <Leader>gst <CMD>Gitsigns toggle_numhl<CR>
nnoremap <Leader>gsc <CMD>Gitsigns toggle_signs<CR>
nnoremap <Leader>gsb <CMD>Gitsigns toggle_current_line_blame<CR>
nnoremap <Leader>gg  <CMD>Git<CR>
nnoremap <Leader>gon <CMD>Dispatch! zsh -ic "gon"<CR>
nnoremap <Leader>G  <CMD>tabnew<CR><CMD>Git<CR>
nnoremap <Leader>R  <CMD>CocRestart<CR>
nnoremap <Leader>u  <CMD>UndotreeToggle<CR>

nnoremap <Leader>fb  <cmd>Telescope buffers<cr>
nnoremap <Leader>fc      :Telescope coc 
nnoremap <Leader>fds <cmd>Telescope coc document_symbols<cr>
nnoremap <Leader>fe  <cmd>Telescope coc diagnostics<cr>
nnoremap <Leader>fp  <cmd>Telescope coc commands<cr>
nnoremap <Leader>fws <cmd>Telescope coc workspace_symbols<cr>
nnoremap <Leader>fwe <cmd>Telescope coc workspace_diagnostics<cr>
" is there a difference to find_files?
nnoremap <Leader>ff  <cmd>Telescope fd<cr>
nnoremap <Leader>fg  <cmd>Telescope live_grep<cr>
nnoremap <Leader>fl  <cmd>Telescope loclist<cr>
nnoremap <Leader>fm  <cmd>Telescope man_pages<cr>
nnoremap <Leader>fr  <cmd>Telescope resume<cr>
nnoremap <Leader>fs  <cmd>Telescope spell_suggest<cr>
nnoremap <Leader>ft  <cmd>TodoTelescope<cr>
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
Plug '~/misc/vim-proportions'

Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'
Plug 'dylanaraps/wal.vim'

" Plug 'HiPhish/nvim-ts-rainbow2'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'windwp/nvim-autopairs'
Plug 'machakann/vim-sandwich'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sleuth'
" Plug 'akinsho/git-conflict.nvim'
Plug 'kdheepak/lazygit.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sitiom/nvim-numbertoggle'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'

Plug 'fannheyward/telescope-coc.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plug 'DNLHC/glance.nvim' " doesn't seem to work
" Plug 'rmagatti/goto-preview'

Plug 'phaazon/hop.nvim'
Plug 'https://gitlab.com/yorickpeterse/nvim-window.git'
" Plug 'drzel/vim-in-proportion'

" Plug 'rcarriga/nvim-notify'
" Plug 'hrsh7th/nvim-cmp'
" Plug 'MunifTanjim/nui.nvim'
" Plug 'folke/noice.nvim'

Plug 'folke/todo-comments.nvim'
Plug 'folke/which-key.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'Cassin01/wf.nvim', { 'tag': '*' }
" Plug 'liuchengxu/vista.vim'

Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'kevinhwang91/rnvimr'
Plug 'mbbill/undotree'

Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'google/vim-searchindex'

Plug 'kevinhwang91/nvim-ufo'
Plug 'kevinhwang91/promise-async'

Plug 'fidian/hexmode'
" Plug 'samodostal/image.nvim'
" Plug 'm00qek/baleia.nvim', { 'tag': 'v1.3.0' } " color support for image.nvim

" Plug 'github/copilot.vim'
Plug 'eandrju/cellular-automaton.nvim'
call plug#end()
" }}}
		
" nmap <Leader>v <cmd>Vista!!<cr>
" nmap <Leader>fv <cmd>Vista finder! coc<cr>

let g:sonokai_better_performance = 1
" let g:sonokai_transparent_background = 1
let g:everforest_better_performance = 1
let g:everforest_transparent_background = 1
set termguicolors
" colorscheme wal
" colorscheme sonokai
colorscheme everforest
" set background=light
let g:lightline = {'colorscheme' : 'everforest'}
" highlight DiffAdd  guibg=#145214
highlight DiffText guibg=#004d66

" lua configuration {{{
lua << EOF
-- require("image").setup({
--     render = {
--         min_padding = 5,
--         show_label = true,
--         show_image_dimensions = true,
--         use_dither = true,
--         foreground_color = true,
--         background_color = true,
--     },
--     events = {
--         update_on_nvim_resize = true,
--     },
-- })

require('gitsigns').setup {
  current_line_blame = true,
  signcolumn = false,
  numhl = true,
}

require("ibl").setup()

require("which-key").setup {}

require("wf").setup()

--  require("notify").setup({
--      background_color = "#000000",
--  })
--  vim.notify = require("notify")

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
    view = {
        preserve_window_proportions = true,
    },
})

require('nvim-web-devicons').setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}

require("todo-comments").setup {}

-- require("goto-preview").setup {}

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

-- local which_key = require("wf.builtin.which_key")
local register = require("wf.builtin.register")
local buffer = require("wf.builtin.buffer")
local mark = require("wf.builtin.mark")

-- Register
vim.keymap.set(
  "n",
  "<Space>wr",
  register(),
  { noremap = true, silent = true, desc = "[wf.nvim] register" }
)

-- Buffer
vim.keymap.set(
  "n",
  "<Space>wb",
  buffer({}),
  { noremap = true, silent = true, desc = "[wf.nvim] buffer" }
)

-- Mark
vim.keymap.set(
    "n",
    "<Space>wm",
    mark(),
    { noremap = true, silent = true, desc = "[wf.nvim] mark" }
)
-- vim.keymap.set(
--     "n",
--     "'",
--     mark(),
--     { nowait = true, noremap = true, silent = true, desc = "[wf.nvim] mark" }
-- )

-- Which Key
-- vim.keymap.set(
--     "n",
--     "<Leader>",
--     which_key({ text_insert_in_advance = "" }),
--     { noremap = true, silent = true, desc = "[wf.nvim] which-key" }
-- )

require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
        disable = { "yaml", },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- This may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
        },
    indent = {
        enable = true,
    },
    -- rainbow = {
    --     enable = true,
    --     -- disable = { 'jsx', 'cpp' },
    --     query = {
    --         'rainbow-parens',
    --         html = 'rainbow-tags',
    --     },
    --     strategy = require("ts-rainbow").strategy.global,
    --     hlgroups = {
    --         'Red',
    --         'Orange',
    --         'Yellow',
    --         'Blue',
    --         'Purple',
    --     },
    -- },
}

require("nvim-autopairs").setup {
    fast_wrap = {
        map = '<C-f>',
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
    -- {
    --     -- TODO: don't add after a space
    --     Rule("<", ">", "rust")
    --     :with_pair(cond.not_after_regex_check("[%w%<%[%{%\"%'%.]"))
    --     :with_move(function(opts)
    --         return opts.prev_char:match('%>') ~= nil
    --     end)
    -- },
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
local lga_actions = require("telescope-live-grep-args.actions")

require("telescope").load_extension('fzf')
require("telescope").load_extension('coc')
require("telescope").load_extension('live_grep_args')

require("telescope").setup {
defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    file_ignore_patterns = {
        "target", -- rust build dir
    },
    mappings = {
        i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-h>"] = "which_key",
            -- add_to_qflist if we don't want to overwrite existing entries
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-l>"] = actions.smart_add_to_qflist + actions.open_qflist,
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
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = { -- extend mappings
            i = {
              ["<C-o>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
          -- ... also accepts theme settings, for example:
          -- theme = "dropdown", -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane
        }
    },
}

-- require('git-conflict').setup {
--     default_mappings = true, -- disable buffer local mapping created by this plugin
--     disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
--     highlights = { -- They must have background color, otherwise the default color will be used
--         incoming = 'DiffText',
--         current = 'DiffAdd',
--     }
-- }

-- require("treesitter-context").setup {
--     mode = 'topline',
-- }

require("nvim-treesitter.configs").setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = true,
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]n"] = "@name",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[n"] = "@name",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
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
        'f', 'd', 's', 'r', 'e', 'w', 'j', 'i', 'o', 'k', 'l', 'u', ';',
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
let g:nvim_tree_window_picker_chars = "asdfkjlqweruiop"
" }}}

" imap <silent><script><expr> <C-T> copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true

" Git diff hunk commands from the perspective of the working copy.
" nnoremap [d :diffget //2 | diffup<CR>
" nnoremap =d :diffput % | diffup<CR>
" nnoremap ]d :diffget //3 | diffup<CR>

" plugin key mappings {{{
map <silent> <C-p> :lua require('nvim-window').pick()<CR>
nmap <silent> <Leader>; :HopWord<CR>

autocmd FileType c,cpp setlocal commentstring=//%s
nnoremap \cx :Dispatch! chmod u+x %<CR>
nnoremap \gpf :Git push --force-with-lease<CR>
nnoremap \gh :GBrowse<CR>

nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>
inoremap <silent><expr> <C-x><C-o> coc#refresh()

inoremap <silent><expr> <C-y> CocActionAsync('showSignatureHelp')

" inoremap <silent><expr> <Tab>   coc#pum#visible() ? "\<C-n>" : "\<Tab>"
" inoremap <silent><expr> <S-Tab> coc#pum#visible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <Tab>    coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"

nnoremap <expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
inoremap <expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
nnoremap <silent> \ca <plug>(coc-codeaction-cursor)
nnoremap <silent> \cl <plug>(coc-codeaction-line)
nnoremap <silent> \cc <plug>(coc-codeaction)
nnoremap <silent> \cs <plug>(coc-codeaction-selected)
vnoremap <silent> \cs <plug>(coc-codeaction-selected)
nnoremap <silent> \cr <CMD>CocRestart<CR>

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

nmap \cg <cmd>CellularAutomaton game_of_life<cr>
nmap \cm <cmd>CellularAutomaton make_it_rain<cr>

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

" lightline {{{;
autocmd VimEnter * call SetupLightlineColors()
function SetupLightlineColors() abort
  let l:pallete = lightline#palette()
  " let l:pallete.normal.left = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.normal.right = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.visual.left = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.visual.right = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.visual.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.replace.left = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.replace.right = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.replace.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.insert.left = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.insert.right = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.insert.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.inactive.left = [ [ 'NONE', 'NONE', '10', '8' ] ]
  " let l:pallete.inactive.right = [ [ 'NONE', 'NONE', '10', '8' ] ]
  " let l:pallete.inactive.middle = [ [ 'NONE', 'NONE', '10', '8' ] ]
  let l:pallete.tabline.left = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.tabline.right = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:pallete.tabline.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  " let l:pallete.tabline.tabsel = [ [ '#f39660', 'NONE', 'NONE', '10' ] ]
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
