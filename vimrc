" misc settings
set noerrorbells
set relativenumber
set number
set nocompatible
set mouse=a
syntax on
set termguicolors
set showcmd
set nohlsearch
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
let mapleader=" "
set backspace=indent,eol,start
set updatetime=300
set cmdheight=2

if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
else
    " colorscheme base16-materia
   "colorscheme base16-tomorrow-night-transparent
   colorscheme base16-dracula
endif

hi NonText guifg=bg
hi vertsplit guifg=fg guibg=bg

" enable filetype plugin
filetype plugin on

" split navigation rebinds
nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>l :wincmd l<CR>
nnoremap <Leader><bar> :wincmd v<CR>:wincmd l<CR>:enew<CR>

" since we have J, why can't we have K?
map K i<Enter><Esc>

" indentation settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" file browser tweaks
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" binding for a new terminal tab
" nnoremap <A-t> :tabnew term://zsh<CR>A
" inoremap <A-t> <ESC>:tabnew term://zsh<CR>A
" tnoremap <A-t> <C-\><C-n>:tabnew term://zsh<CR>A
" nnoremap <A-\> :wincmd v<CR>:wincmd l<CR>:term<CR>:setlocal nonumber norelativenumber<CR>A

" when entering a terminal buffer, disable numbers and releative numbers
au BufEnter,TabEnter,WinEnter * if &buftype == 'terminal' | setlocal nonumber | setlocal norelativenumber | endif

" Organise imports on save
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" bind Control+s to :w
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" map escape to C-\ C-n while in terminal mode
tnoremap <ESC> <C-\><C-n>

" set font and colorscheme if in gvim
if has( "gui_running" )
    set guifont=Jetbrains\ Mono\ Regular\ 11
else
    " else if in terminal vim, bind Ctrl+h & Ctrl-l Keys to next/previous tabs
    nnoremap <C-h> gT
    nnoremap <C-l> gt
endif

" keep current line in above or equal to centre of screen
nnoremap j jzz
nnoremap k kzz
nnoremap gg ggzz
nnoremap G Gzz
nnoremap n nzz
nnoremap N Nzz

" bindings for opening a file in the current working directory
nnoremap <C-o> :e 
inoremap <C-o> <ESC>:e 

" bindings for closing current buffer and creating a new empty one and closing
" tabs
nnoremap qQ :enew\|bdelete# <CR>
inoremap qQ <ESC>:enew\|bdelete# <CR>
nnoremap qq :q<CR>
inoremap qq <ESC>:q<CR>
nnoremap QQ :tabclose<CR>
inoremap QQ <ESC>:tabclose<CR>
tnoremap QQ <C-\><C-n>:tabclose<CR>

" bindings for opening tabs
" inoremap <C-t> <ESC>:tabnew<CR>
" nnoremap <C-T> :tabnew 
" inoremap <C-T> <ESC>:tabnew 
" nnoremap <C-t> :tabnew<CR>
nnoremap qt :tabnew<CR>:e 
inoremap qt <ESC>:tabnew<CR>:e 

" binding for closing tabs

" use tab key to indent
nnoremap <Tab> >>
vnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <S-Tab> <<
inoremap <S-Tab> <ESC><<i

" autocmd VimLeave * set guicursor=a:hor20

" plugins
call plug#begin( '~/.vim/plugged' )

Plug 'rust-lang/rust.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'jremmen/vim-ripgrep'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'thaerkh/vim-indentguides'
Plug 'OmniSharp/omnisharp-vim'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-rooter'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'voldikss/vim-floaterm'
Plug 'itchyny/lightline.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'elmcast/elm-vim'
Plug 'preservim/tagbar'
Plug 'rhysd/vim-clang-format'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'mattn/emmet-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'vim-syntastic/syntastic'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tbastos/vim-lua'
Plug 'Chiel92/vim-autoformat'
Plug 'leafo/moonscript-vim'
Plug 'zivyangll/git-blame.vim'
Plug 'puremourning/vimspector'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

call plug#end(  ) 

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end


-- rust-analyzer setup
nvim_lsp["rust_analyzer"].setup({
    on_attach = on_attach,
    settings = {
        ["rust_analyzer"] = {
            procMacro = { enable = true },
            inlayHints = { refreshOnInsertMode = true },
            diagnostics = {
                disabled = {"unresolved-proc-macro"}
            },
        }
    }
})

-- HTML LSP setup
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp["html"].setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

--This line is important for auto-import
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
EOF

autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

let g:coc_global_extensions = [
    \ "coc-git",
    \ "coc-json",
    \ "coc-kotlin",
    \ "coc-omnisharp",
    \ "coc-prettier",
    \ "coc-python",
  \ ]

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" --- plugin specific bindings --- 

" toggle NERDTree
" map <C-b> :NERDTreeToggle<CR>

" list opened files
nnoremap <C-\> :W<CR>

" jump to definition and jump to references
" nmap <Leader>gd <Plug>(coc-definition)
" nmap <Leader>gr <Plug>(coc-references)
" nmap <Leader>gi <Plug>(coc-implementation)
" nmap <Leader>gt <Plug>(coc-type-definition)
" nmap <F2> <Plug>(coc-rename)


let g:fzf_command_expect = ''

" command! -bang -nargs=? -complete=dir Files
"         \ call fzf#vim#files(FindRootDirectory(), {'options': ['--layout=reverse', '--info=inline']})

" open file search
map <A-p> :Buffers<CR>
map <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
map <C-c> :Commits<CR>
map <C-a-c> :Colors<CR>

nmap <F8> :TagbarToggle<CR>

" binding for commenting out lines
nnoremap ## :Commentary<CR>
inoremap ## <ESC>:Commentary<CR>i

" --- plugin specific settings ---

autocmd FileType rust nnoremap <F5> :make run<CR>
autocmd FileType rust nnoremap <F6> :make build<CR>

augroup rainbow
    autocmd FileType rust,cpp,c,h,hpp,cs,py,js,ts,vim,cfg RainbowParentheses
augroup END

au BufWrite *.cs :Autoformat

autocmd FileType c,cpp ClangFormatAutoEnable
au BufEnter,BufNew *.h setfiletype c

let g:clang_format#code_style = "llvm"

let g:lightline = {
    \ 'colorscheme': 'Tomorrow_Night_Bright',
    \ 'active': {
    \   'left':[['mode', 'paste'],
    \           ['gitbranch', 'readonly', 'filename', 'modified']]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
    \ }

let g:tagbar_type_elm = {
    \ 'kinds' : [
    \   'f:function:0:0',
    \   'm:modules:0:0',
    \   'i:imports:1:0',
    \   't:types:1:0',
    \   'a:type aliases:0:0',
    \   'c:type constructors:0:0',
    \   'p:ports:0:0',
    \   's:functions:0:0',
    \ ]
    \}

let g:rooter_change_directory_for_non_project_files = 'current'

let g:AutoPairsShortcutToggle = ''

let g:formatdef_my_custom_cs = '"astyle --mode=cs --style=1tbs --delete-empty-lines -z2 -pUCNcHs".&shiftwidth'
let g:formatters_cs=['my_custom_cs']

" set indent guide character
let g:indentguides_spacechar='│'
let g:indentguides_tabchar='│'

" set to nightly rustfmt
let g:rustfmt_command="~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustfmt"
" autorun rustfmt on save
let g:rustfmt_autosave=1

if executable('rg')
    let g:rg_derive_root='true'
endif

nmap <F1> :FloatermToggle<CR>
imap <F1> <ESC>:FloatermToggle<CR>
tmap <F1> <ESC>:FloatermToggle<CR>


nmap <A-n><A-n> :CocAction<CR>
imap <A-n><A-n> <Esc>:CocAction<CR>

nnoremap '' :setlocal nu!<CR>:setlocal rnu!<CR>

inoremap <silent><expr> <C-Space>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<C-Space>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
