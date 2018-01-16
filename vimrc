if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
	set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set nu
set autoindent
set cindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
let autosave=5

call plug#begin('/home/JiRaiYa/.vim/plugged')
"======================================================
Plug 'luochen1990/rainbow'
let g:rainbow_active=1
"======================================================
Plug 'vim-airline/vim-airline'
"======================================================
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
"======================================================
Plug 'davidhalter/jedi-vim'
"======================================================
Plug 'scrooloose/nerdtree'
au VimEnter * NERDTree
au VimEnter * NERDTreeToggle
nmap <F2> :NERDTreeToggle<CR>
"======================================================
Plug 'altercation/vim-colors-solarized'
syntax on
syntax enable
let g:solarized_termcolors=16
let g:solarized_termtrans=1
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_contrast="high"
set background=dark
set t_Co=256
colorscheme solarized
let g:solarized_termcolors=256
"======================================================
Plug 'Yggdroot/indentLine'
let g:indentLine_char='¦'
"======================================================
"Plug 'scrooloose/syntastic'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"======================================================
Plug 'junegunn/fzf'
"======================================================
Plug 'rking/ag.vim'
"======================================================
"Plug 'Chiel92/vim-autoformat'
"au BufWrite * :Autoformat
"======================================================
Plug 'scrooloose/nerdcommenter'
"======================================================
Plug 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"======================================================
"Plug 'python-mode/python-mode'
"======================================================
Plug 'pangloss/vim-javascript'
"======================================================
Plug 'mattn/emmet-vim'
"======================================================
call plug#end()

" Only do this part when compiled with support for autocommands
if has("autocmd")
	augroup redhat
		autocmd!
		" In text files, always limit the width of text to 78 characters
		" autocmd BufRead *.txt set tw=78
		" When editing a file, always jump to the last cursor position
		autocmd BufReadPost *
					\ if line("'\"") > 0 && line ("'\"") <= line("$") |
					\   exe "normal! g'\"" |
					\ endif
		" don't write swapfile on most commonly used directories for NFS mounts or USB sticks
		autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
		" start with spec file template
		autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
	augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add $PWD/cscope.out
		" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

filetype plugin on

if &term=="xterm"
	set t_Co=8
	set t_Sb=[4%dm
	set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
