" Begin vim-plug stuff
" ******************
" ******************

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'

Plug 'itchyny/lightline.vim'

Plug 'terryma/vim-multiple-cursors'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'codota/tabnine-vim'

Plug 'junegunn/vim-easy-align'

Plug 'ludovicchabant/vim-gutentags'

Plug 'timakro/vim-searchant'

Plug 'tpope/vim-surround'

Plug 'rhysd/vim-clang-format'

Plug 'tell-k/vim-autopep8'

call plug#end()

" ****************
" ****************
" End vim-plug stuff



" Start stuff shared by terminal vim and CLion/PyCharm vim
" ********************************************************
" ********************************************************

" Map ; to : so you don't need to press shift all the time when closing files.
nnoremap ; :
vnoremap ; :

" Enable some options.
set nocp

" Show search results while typing search criteria.
set incsearch

" Highlight search results.
set hlsearch

" Adding a mapping so Enter clears the highlighted results.
nnoremap <CR> :noh<CR><CR>

" quick exit out of insert mode.
inoremap jk <esc>

" So backspace functions properly.
set backspace=indent,eol,start

" Set tab space to 4 characters. Use space only, do not use tab.
set tabstop=4
set shiftwidth=4
set expandtab

" ******************************************************
" ******************************************************
" End stuff shared by terminal vim and CLion/PyCharm vim



" Start extra stuff when using terminal vim
" *****************************************
" *****************************************

" Auto indent
" set autoindent

" Making space the leader key
:let mapleader = "\<Space>" 

" Remove all tailing whitespaces by calling F6
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
noremap <F6> :call <SID>StripTrailingWhitespaces()<CR>

" Needed for junegunn/fzf
" ***********************
" Use space-t to search git files through fzf.
nnoremap <leader>t :GFiles<cr>

" Needed for itchyny/lightline
" ****************************
set laststatus=2

" If you use itchyny/lightline.vim, then -- INSERT -- is not needed anymore because the mode information is displayed in the status line
set noshowmode

" Needed for junegunn/vim-easy-align
" **********************************
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Needed for itchyny/lightline, some weird color display issue going on with using terminator.
" ********************************************************************************************
set background=dark
set t_Co=256

" Needed for timakro/vim-searchant, press enter to cancel highlight.
" ******************************************************************
let g:searchant_map_stop = 0
nmap <CR> <Plug>SearchantStop

" Clang format for C/C++ by pressing space-c
nmap <leader>c :ClangFormat<CR>

" Autopep8 for Python by pressing space-p
nmap <leader>p :Autopep8<CR>
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=120

" End extra stuff when using terminal vim
" ***************************************
" ***************************************
