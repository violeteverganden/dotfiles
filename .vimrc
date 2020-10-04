set fenc=utf-8
set nobackup
set noswapfile
set autoread
set autowriteall
set hidden
set showcmd
set belloff=all

set cindent
set tabstop=2
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

set number
set cursorline
set virtualedit=onemore
set showmatch
set statusline=%F
set laststatus=2
set wildmode=list:longest
set wildmenu
syntax enable

au ColorScheme * highlight Type ctermfg=11
au ColorScheme * highlight Comment ctermfg=11
au ColorScheme * highlight Identifier ctermfg=46
au ColorScheme * highlight Statement ctermfg=214
au ColorScheme * highlight Structure ctermfg=46
au ColorScheme * highlight PreProc ctermfg=46
au ColorScheme * highlight Constant ctermfg=13
au ColorScheme * highlight Search cterm=NONE ctermbg=9
au ColorScheme * highlight StatusLine cterm=NONE ctermfg=46 ctermbg=0
au ColorScheme * highlight SpecialKey  ctermfg=1
au ColorScheme * highlight NonText ctermfg=1
au ColorScheme * highlight MatchParen ctermfg=11 ctermbg=0
au ColorScheme * highlight Directory ctermfg=11

colorscheme zellner

set whichwrap=b,s,h,l,<,>,[,],~
au BufWritePre * :%s/\s\+$//ge
au BufNewFile *.c Stdheader
au BufNewFile *.h Stdheader
au BufNewFile *.h IncludeGuard
au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

nmap <CR> i<C-m><ESC>
nmap <Space> i<Space><ESC>
nmap <Tab> i<Tab><ESC><Right>
imap <C-d> <Delete>
imap <C-c> <ESC><Right>

nmap <C-g> G
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-n> <Left>

nnoremap z ZZ
nnoremap q :q!<CR>
nnoremap j gj
nnoremap k gk
nnoremap <C-l> :nohl<CR>

map <C-a> <Home>
map <C-e> <End>
map! <C-a> <Home>
map! <C-e> <End>

inoremap { {}<Left><CR><CR><Up><Tab>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

" IncludeGuard "
function! s:include_guard()
	let name = fnamemodify(expand('%'), ':t')
	let name = toupper(name)
	let guard = substitute(name,'\.','_','g')
	let header = '#ifndef '.guard."\n# define ".guard."\n\n\n\n"
	let footer = '#endif'
	silent! execute '13s/^/\=header'
	silent! execute '$s/$/\=footer'
	call cursor(16,0)
endfunction
command! IncludeGuard call s:include_guard()

" SyntaxInfo "
function! s:get_syn_id(transparent)
	let synid = synID(line("."), col("."), 1)
	if a:transparent
		return synIDtrans(synid)
	else
		return synid
	endif
endfunction
function! s:get_syn_attr(synid)
	let name = synIDattr(a:synid, "name")
	let ctermfg = synIDattr(a:synid, "fg", "cterm")
	let ctermbg = synIDattr(a:synid, "bg", "cterm")
	let guifg = synIDattr(a:synid, "fg", "gui")
	let guibg = synIDattr(a:synid, "bg", "gui")
	return {
			\ "name": name,
			\ "ctermfg": ctermfg,
			\ "ctermbg": ctermbg,
			\ "guifg": guifg,
			\ "guibg": guibg}
endfunction
function! s:get_syn_info()
	let baseSyn = s:get_syn_attr(s:get_syn_id(0))
echo "name: " . baseSyn.name .
			\ " ctermfg: " . baseSyn.ctermfg .
			\ " ctermbg: " . baseSyn.ctermbg .
			\ " guifg: " . baseSyn.guifg .
			\ " guibg: " . baseSyn.guibg
let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
echo "link to"
echo "name: " . linkedSyn.name .
			\ " ctermfg: " . linkedSyn.ctermfg .
			\" ctermbg: " . linkedSyn.ctermbg .
			\ " guifg: " . linkedSyn.guifg .
			\ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

" dein.vim "
if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('ConradIrwin/vim-bracketed-paste')
  call dein#add('vim-scripts/vim-auto-save')
	call dein#add('scrooloose/nerdtree')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

	call dein#end()
  call dein#save_state()
	if dein#check_install()
    call dein#install()
  endif
endif

filetype plugin indent on

let g:auto_save=1
let g:auto_save_in_insert_mode=0
let g:auto_save_silent=1

noremap <C-n> :NERDTreeToggle<CR>
