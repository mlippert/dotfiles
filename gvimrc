" Turn off wrap and turn on the bottom scrollbar
set nowrap
set guioptions+=b

" Set how special chars are shown when list is on and set the prefix for
" wrapped lines when wrap is on.
" set listchars=tab:»·,trail:·
set listchars=tab:⇢‧,trail:‧
" let &showbreak = '↳ '
let &showbreak = '╪╡ '

" for other possible fonts see:
" http://www.codinghorror.com/blog/2004/12/progamming-fonts.html
if has("gui_running")
  if has("gui_gtk2")
    if has("win32unix")
      set guifont=Consolas\ 8
    else
      set guifont=Inconsolata\ 10
    endif
  elseif has("gui_win32")
    set guifont=Consolas:h8:cDEFAULT
	set lines=50 columns=110
  endif
endif

" override some of the colors from the solarized colorscheme
hi Comment					guifg=#804080
hi javaScriptDocComment		guifg=#a050c0
hi javaScriptDocTags		guifg=#7050a0	guibg=#ede6b3
