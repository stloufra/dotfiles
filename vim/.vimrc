"Disable compatibility with vi 
set nocompatible

"Filetype detection, load plugins, load indention
filetype on
filetype plugin on
filetype indent on 

"Turn syntax highlighting on
syntax on

"Add numbers to each line 
set number

"Highlight cursor position
set cursorline
"set cursorcolumn


"more pleasant edit 
set nowrap 

highlight CursorLine   cterm=underline term=underline guibg=NONE gui=underline
"highlight CursorColumn ctermbg=lightgrey guibg=lightgrey

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

nnoremap <space> :

"Go for Enter as a key to accept suggestion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <F2> :w<Enter>                                                                                                                                                                   
nnoremap <F3> :q<Enter>
nnoremap <F4> :wq<Enter>
nnoremap <F5> :q!<Enter>

" fzf
nnoremap <C-t> :Files<CR>
nnoremap <C-r> :Buffers<CR>
nnoremap <leader><leader> :Rg<CR>

"coc
nnoremap gd <Plug>(coc-definition)
nnoremap gi <Plug>(coc-implementation)
nnoremap gr <Plug>(coc-references)

" Highlighting for CoC suggestions
hi! link CocMenuSel PmenuSel
hi! link CocPumMenu Pmenu
hi! link CocPumVirtualText Comment


nnoremap U <C-r>

" Highlighting for CoC suggestions
hi! link CocMenuSel PmenuSel
hi! link CocPumMenu Pmenu
hi! link CocPumVirtualText Comment

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')
   " List your plugins here" 
    Plug 'tpope/vim-sensible'
    Plug 'neoclide/coc.nvim', {'branch':'release'}
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'dracula/vim', { 'as':'dracula' }
call plug#end()

" Set the colorscheme
syntax on

set termguicolors
colorscheme dracula 
