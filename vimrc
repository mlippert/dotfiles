" Some interesting settings I'm using were found in:
"  - https://github.com/rzhw/dotfiles/blob/master/vim/vimrc

" pathogen is maintained by Tim Pope at https://github.com/tpope/vim-pathogen
execute pathogen#infect()
execute pathogen#helptags()

let mapleader = ","

" put all backup and swap files in the tmp directory and include the path
" (trailing double slash) so duplicate names don't clash
set backup
if has("gui_win32")
    set backupdir=~/vimfiles/tmp//
    set directory=~/vimfiles/tmp//
else
    set backupdir=~/.vim/tmp//
    set directory=~/.vim/tmp//
endif

" Allow windowless unsaved buffers
set hidden

"set number      " Line numbers
set ruler        " Show current line number and char
set backspace=2  " Conventional backspace behaviour
set scrolloff=3

set encoding=utf-8
set laststatus=2

filetype plugin indent on

syntax enable

colorscheme solarized
if has('gui_running')
    set background=light
else
    set background=dark
endif

set tabstop=4 shiftwidth=4 smarttab
set autoindent smartindent

set listchars=tab:>-,trail:-

" Filetype specific settings
autocmd FileType javascript set tabstop=4 shiftwidth=4 expandtab
autocmd FileType xhtml set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab

" This keymap uses the blackhole register to paste what is in the default
" register on top of a change target. Described and copied from:
" http://stackoverflow.com/questions/2471175/vim-replace-word-with-contents-of-paste-buffer/2471282#2471282
" This allows for change paste motion cp{motion}
nnoremap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction

" keep taglist available on ctrl-F8 while putting tagbar on F8
nmap <S-F8> :TlistToggle<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
"noremap <silent> <F12> :LustyJuggler<CR>
noremap <silent> <F12> :Bufferlistsw<CR>

" recognize the javascript typedef type I've added to ctags and don't show the
" property type.

let g:tagbar_type_javascript = {
    \ 'kinds' : [
        \ 'v:global variables:0:0',
        \ 'c:classes',
        \ 't:typedefs:0:0',
        \ 'm:methods',
        \ 'f:functions',
    \ ],
\ }

" disable the vim-session autoload of the default session
let g:session_autoload = 'no'
let g:session_autosave = 'no'

" custom status line from
"  http://www.wezm.net/technical/2008/09/pimping-vim-on-windows/
"  Not sure I love it, so commenting it out -mjl
"set laststatus=2
"set statusline=%&lt;%f\ %m%a%=%([%R%H%Y]%)\ %-19(%3l\ of\ %L,%c%)%P
"set showcmd
