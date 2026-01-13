" Turn off wrap, turn on the bottom scrollbar, turn off the toolbar at the top
set nowrap
set guioptions+=b
set guioptions-=T

" Override keeping 3 lines below and above the cursor from vimrc because
" having the lines jump when selecting w/ the mouse is disconcerting
set scrolloff=0

" Set how special chars are shown when list is on and set the prefix for
" wrapped lines when wrap is on.
" set listchars=tab:»·,trail:·
set listchars=tab:⇢‧,trail:‧
" let &showbreak = '↳ '
let &showbreak = '╪╡ '

" for other possible fonts see:
" http://www.codinghorror.com/blog/2004/12/progamming-fonts.html
if has("gui_running")
  if has("gui_gtk2") || has("gui_gtk3")
    if has("win32unix")
      set guifont=Consolas\ 8
    else
"      switched from Inconsolata to IntelOne Mono 2023-06-09, it uses more vertical space but seems easier to read -mjl
"      get IntelOne Mono from https://github.com/intel/intel-one-mono/releases
"      set guifont=Inconsolata\ 11
      set guifont=IntelOne\ Mono\ 10
    endif
  elseif has("gui_win32")
    set guifont=Consolas:h8:cDEFAULT
	set lines=50 columns=110
  endif
endif

" code for changing the font size from http://vim.wikia.com/wiki/Change_font_size_quickly
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_running") && (has("gui_gtk2") || has("gui_gtk3"))
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(2)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-2)
endfunction
command! SmallerFont call SmallerFont()


" override some of the colors from the solarized colorscheme
hi Comment					guifg=#804080
hi javaScriptDocComment		guifg=#a050c0
hi javaScriptDocTags		guifg=#7050a0	guibg=#ede6b3
