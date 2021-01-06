" Some interesting settings I'm using were found in:
"  - https://github.com/rzhw/dotfiles/blob/master/vim/vimrc

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim
" defaults sets up an autocmd to restore last position, which I don't like so revert it
augroup vimStartup | au! | augroup END

" let mapleader = ","
let mapleader = "\\"

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

set listchars=tab:>-,trail:-

" add an errorformat for msbuild (used by tslint)
set errorformat+=%f(%l\\,%c):\ %t%*[^\ ]\ %m

" Use ripgrep if it's available as the grep program
"  see http://www.wezm.net/technical/2016/09/ripgrep-with-vim/
"  use w/ quickfix (:copen to open quickfix window :ccl to close see help for more)
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" It's desirable to set the vim working directory to enable better use of cmds like
" :grep and :make...
"   see http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/
"
" set working directory to git project root
" or directory of current file if not git project
function! SetProjectRoot()
  " default to the current file's directory
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction

" follow symlink and set working directory
autocmd BufEnter *
  \ call SetProjectRoot()

" Filetype specific settings
"   see http://learnvimscriptthehardway.stevelosh.com/chapters/14.html for info on augroup
augroup for_ftypes
    autocmd!
    autocmd FileType javascript set tabstop=4 shiftwidth=4 expandtab formatoptions+=j formatoptions-=c textwidth=85
    autocmd FileType typescript set tabstop=4 shiftwidth=4 expandtab formatoptions+=rolqj formatoptions-=tc textwidth=85
    autocmd FileType javascriptreact set tabstop=4 shiftwidth=4 expandtab formatoptions+=j formatoptions-=c textwidth=85
    autocmd FileType typescriptreact set tabstop=4 shiftwidth=4 expandtab formatoptions+=rolqj formatoptions-=tc textwidth=85
    autocmd FileType html,xhtml set tabstop=4 shiftwidth=4 expandtab
    autocmd FileType python set tabstop=4 shiftwidth=4 expandtab

    " set the = (format) command to use an external cmd ie pretty print xml
    autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

    " For these filetypes, strip trailing whitespace on save
    autocmd FileType c,cpp,css,html,java,javascript,javascriptreact,python,sh,typescript,typescriptreact,xhtml autocmd BufWritePre <buffer> :%s/\s\+$//e
augroup END

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

" do a / search then \z will fold all non-matching lines
" zA - toggle fold, zR unfold everything, zM refold everything
" from http://vim.wikia.com/wiki/Folding_with_Regular_Expression
nnoremap <leader>z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

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

" Set the zoom width to the width of the longest currently visible tag
let g:tagbar_zoomwidth = 0

" tagbar sorts by order in file by default
let g:tagbar_sort = 0

" disable the vim-session autoload of the default session
let g:session_autoload = 'no'
let g:session_autosave = 'no'

" custom status line from
"  http://www.wezm.net/technical/2008/09/pimping-vim-on-windows/
"  Not sure I love it, so commenting it out -mjl
"set laststatus=2
"set statusline=%&lt;%f\ %m%a%=%([%R%H%Y]%)\ %-19(%3l\ of\ %L,%c%)%P
"set showcmd
