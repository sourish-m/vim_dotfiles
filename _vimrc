"Author: Sourish Mandal
source $VIMRUNTIME/defaults.vim
source $VIMRUNTIME/mswin.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Options & Remaps                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"stop creation of swap files
set noswapfile
set autochdir
set undofile
set encoding=utf-8
set gdefault "this sets global search as default
set ignorecase
set smartcase
set hlsearch
"set wildmode=list:longest
set wildoptions=pum,fuzzy
set tabstop=4
set softtabstop=4
set shiftwidth=0
set expandtab
"====================The lines below show tabs================
" set list
set listchars=tab:<->,nbsp:~,eol:$,space:␣
" ============================================================
set ttyfast
set backspace=indent,eol,start
set formatoptions=qrnltj/
set complete+=kspell
set completeopt+=menuone,noinsert,noselect
set shortmess=xcToOsIF "custom shortmessage format, see help
"the above line shows search numbers
set belloff+=ctrlg " If Vim beeps during completion
packadd! matchit "this is cut-pasted from vimrc_example
packadd! comment "new inbuilt comment plugin in Vim 9.1
packadd! nohlsearch "turns off search highlight after 'updatetime' (default 4 seconds)
let mapleader=","
" remaps leader to ,
if has("termguicolors")
 set termguicolors
endif
set mouse=a
set belloff=all     "this disables vim's built in bell
set number   "this shows line numbers
" set relativenumber "this shows relative line numbers
set splitbelow "splits appear only below and right
set splitright
set browsedir=current
set guioptions+=!
set linebreak
set conceallevel=2
set backup
set bdir=$VIM\\backup\\
"sets backup directory
set undofile
set undodir=$VIM\\undofiles\\
"double \\ means the file names include complete path
set pythonthreehome=C:\Users\Sourish\Desktop\sdk\python\
set pythonthreedll=python310.dll
" set directory=.,,$TEMP
set sidescroll=1 "enables side scrolling
set confirm
set redrawtime=10000
" Hightlight the line number of current line
set cursorline
set cursorlineopt=number
set smoothscroll

set fillchars=vert:\│,stl:\ ,stlnc:\ ,eob:\ ,lastline:~

inoremap jk <Esc>
inoremap kj <Esc>
"this remaps <Esc> to jk or kj  in insert mode
"
colo sorbet

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Code Execution                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ; :
nnoremap : ;
"most useful mapping in VIM
nnoremap / /\v
vnoremap / /\v
"the above two lines change VIM's built in regex to the perl syntax which is
"more common.Be Careful as this may break some search behaviour!!!!
nnoremap ' `
nnoremap ` '
"for navigating marks, ` is better than ' as it remembers position. So we swap these values.
noremap ^ 0
noremap 0 ^
" now 0 reaches beginning of line ignoring space

"TIP-JUST DELETE NETRW FROM VIM, IT IS BUGGY AS HELL AND HANGS VIM OFTEN
let loaded_netrwPlugin = 1
let g:markdown_folding = 1
let $HOME=$VIM
let $HOMEPATH=$VIM

" Don't show cursorline in insert mode
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Better Grep (From Romainl's Gist)                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('rg')
  set grepprg=rg\ --smart-case\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif
function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Folding                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"In normal mode, press Space to toggle the current fold open/closed.
"However, if the cursor is not in a fold, move to the right (the default behavior)
 nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
 vnoremap <Space> zf
 set foldmethod=indent "set folding per syntax
 set foldnestmax=2
 set foldcolumn=1
 set foldtext=

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Moves lines up or down                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

vnoremap <silent> <C-j> :m '>+1<CR>gv
vnoremap <silent> <C-k> :m '<-2<CR>gv
"move lines up or down using Control-j/k

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Movement between Windows                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use arrow keys to move between windows in the terminal
nnoremap <silent><F4> :wincmd c<CR>
if !has('gui')
nnoremap <LEFT> <C-w>h
nnoremap <RIGHT> <C-w>l
nnoremap <DOWN> <C-w>j
nnoremap <UP> <C-w>k
endif

if has ('terminal')
    tnoremap <Esc> <C-\><C-n> "Exit terminal mode with ESC

    " Set cursor style for different modes
    let &t_SI .= "\<Esc>[4 q"
    let &t_SR .= "\<Esc>[3 q" " Blinking underscore in Replace mode
    let &t_EI .= "\<Esc>[4 q" " Solid block in Normal mode
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Windows File Explorer Integration                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('gui')
nnoremap <leader>bo :browse e!<CR>
nnoremap <leader>bs :browse confirm saveas!<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                VIM Plugins                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To install VIM Plug, download from this url with curl and put it in autoload:
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('$VIM/vimfiles/plugged')
Plug 'w0rp/ale'
Plug 'mbbill/undotree'
Plug 'ourigen/skyline.vim'
" Lightweight statusline Alternative
Plug 'preservim/tagbar'
"-> <F9> for tagbar
call plug#end()
"-------------------------Statusline Config----------------------------
set noshowmode " for hiding --INSERT in last line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    ALE                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#ale#enabled=0
let g:ale_detail_to_floating_preview=1 "ALEDetail in preview window"
let g:ale_completion_enabled=1  "Snipmate doesn't work if this is enabled"
let g:ale_virtualtext_cursor=0 "inline error messages"
let g:ale_use_neovim_diagnostics_api=0
let g:ale_cursor_detail=1
let g:ale_lsp_suggestions=1
let g:ale_echo_cursor=0
let g:ale_floating_window_border=['│', '─', '╭', '╮', '╯', '╰']
let g:ale_cache_executable_check_failures=1
let g:ale_use_global_executables=1
let g:ale_fixers = {
\   'python': ['ruff','black'],
\}
if has('gui_running')
    let g:ale_sign_error = '❌'
    let g:ale_sign_warning ='💡'
    highlight clear ALEErrorSign
    highlight clear ALEWarningSign
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 TermDebug                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:termdebug_popup = 0
let g:termdebug_wide = 163

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  UndoTree                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:undotree_ShortIndicators=1
let g:undotree_SetFocusWhenToggle=1
let g:undotree_DiffAutoOpen=0
nnoremap <F1> :UndotreeToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Tagbar                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tagbar_autoclose=1
nnoremap <silent> <F9> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Extra (GEMINI)                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Autocommand for auto removing trailing spaces on save
augroup auto_space
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" Autocommand for auto-reload vimrc
augroup vimrc_reload
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

