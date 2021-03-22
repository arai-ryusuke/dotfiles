if &compatible
	set nocompatible
endif

"# dein.vimインストール時に指定したディレクトリをセット
let s:dein_dir = expand('~/.cache/dein')

"# dein.vimの実体があるディレクトリをセット
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimが存在していない場合はgithubからclone
if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	"# dein.toml, dein_layz.tomlファイルのディレクトリをセット
	let s:toml_dir = expand('~/.vim/rc')

	"# 起動時に読み込むプラグイン群
	call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})

	"# 遅延読み込みしたいプラグイン群
	call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
	call dein#install()
endif

colorscheme molokai
set t_Co=256

autocmd BufRead,BufNewFile *.mkd  set filetype=markdown
autocmd BufRead,BufNewFile *.md  set filetype=markdown
"Need: kannokanno/previm
nnoremap <silent> <C-p> :PrevimOpen<CR> " Ctrl-pでプレビュー
" 自動で折りたたまないようにする
let g:vim_markdown_folding_disabled=1
let g:previm_enable_realtime = 1

syntax enable
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set number
set cursorline
set virtualedit=onemore
set smartindent
set showmatch
set laststatus=2
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set wildmenu
set wildmode=list:longest
set ruler
set scrolloff=5

set virtualedit=block
set shiftwidth=2
set softtabstop=2
set tabstop=2

set whichwrap=b,s,h,l,<,>,[,],~
set backspace=indent,eol,start

nmap <silent><Esc><Esc> :nohlsearch<CR><Esc>

nnoremap Y y$
nnoremap + <C-a>
nnoremap - <C-x>
nnoremap <silent> <F10> ggVG
nnoremap <silent> <F5> :e!<CR>

inoremap <silent> jj <ESC>
tnoremap <silent> <C-\> <C-w><S-n>
tnoremap <silent> <C-l> <C-w>l
tnoremap <silent> <C-h> <C-w>h

nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sw <C-w>w
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>

nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap <silent><C-n> :vert term<CR>

nnoremap <S-j> :ALENextWrap<CR>
nnoremap <S-k> :ALEPreviousWrap<CR>
nnoremap <C-j> 5j
nnoremap <C-k> 5k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
vnoremap <C-j> 5j
vnoremap <C-k> 5k
vnoremap <C-l> <C-w>l
vnoremap <C-h> <C-w>h

let g:ale_ruby_rubocop_options = '--except Style/BlockDelimiters'
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_fixers = { 'ruby': ['rubocop'], }
let g:ale_fix_on_save = 1
