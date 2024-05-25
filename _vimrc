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
set shortmess=xcToOsI "custom shortmessage format, see help
"the above line shows search numbers
set belloff+=ctrlg " If Vim beeps during completion
packadd! matchit "this is cut-pasted from vimrc_example
let mapleader=","
" remaps leader to ,
set t_Co=256    "this enables 256 colours in the terminal
if has("termguicolors")
 set termguicolors
endif
set mouse=a
set belloff=all     "this disables vim's built in bell
set number   "this shows line numbers
set splitbelow "splits appear only below and right
set splitright
set browsedir=current
set guioptions+=!
set linebreak
set conceallevel=2
set grepprg=ag
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

set fillchars=vert:\│,stl:\ ,stlnc:\ ,eob:\ ,lastline:~

inoremap jk <Esc>
inoremap kj <Esc> 
"this remaps <Esc> to jk or kj  in insert mode  

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Code Execution                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup prog
    au!
autocmd Filetype c setlocal makeprg=gcc\ -g\ -pipe\ %\ -o\ $*<
autocmd Filetype cpp setlocal makeprg=g++\ -g\ -pipe\ %\ -o\ $*<
" Execute with <f5>
autocmd Filetype c,cpp nnoremap <silent><buffer> <F5> :term %<<cr>
augroup END
" Compile with F7, and navigate errors with :cn, :cp...
nnoremap <silent> <F7> :<c-u>w<cr>:make %<cr>
" While % is a shortcut for the current filename with extension, %< strips the
" extension.
" <c-u> after semicolon is used to remove any ranges VIM may insert in command
" mode

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
 " -------------this function sets fold text-----------------------
 function! MyFoldText()
     let nucolwidth = &fdc + &number * &numberwidth
     let windowwidth = winwidth(0) - nucolwidth - 7 " Change this number into flair character length
     let foldedlinecount = v:foldend - v:foldstart
     let line = strpart(0, windowwidth - 2 -len(foldedlinecount))
     let fillcharcount = windowwidth - strdisplaywidth(line) - len(foldedlinecount)
     return repeat(" ",fillcharcount-5) .' ('. foldedlinecount .' lines) '. '  '
 endfunction
 set foldtext=MyFoldText()

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

call plug#begin('$VIM/vimfiles/plugged')
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'mbbill/undotree'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"-> needed for ultisnips

Plug 'bfrg/vim-cpp-modern',{'for': ['c','cpp']}
"-> better c and c++ syntax highlight
Plug 'mechatroner/rainbow_csv'
"-> rainbow csv highlight for VIM
Plug 'romainl/vim-cool'
"-> auto-removes search highlight

Plug 'preservim/tagbar'
"-> <F9> for tagbar
Plug 'tweekmonster/startuptime.vim'
"-> :StartupTime
Plug 'psliwka/vim-smoothie'
Plug 'sainnhe/everforest'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeFocus' }
"--> Smooth scrolling using CTRL-D and CTRL-U

call plug#end()
"-----------------------------------------------------------------------
let g:everforest_background='hard'
let g:everforest_better_performance=1 "improves loading time
colorscheme everforest
"---------------------------NERDTREE------------------------------------
nnoremap <silent> <leader>e :NERDTreeFocus<CR>
"---------------------------Lightline Plugin----------------------------

"for lightline plugin display
set laststatus=2
set noshowmode " for hiding --INSERT in last line

"to change color of lightline
let g:lightline = { 'colorscheme': 'everforest' }
function! s:set_lightline_colorscheme(name) abort
    let g:lightline.colorscheme = a:name
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

function! s:lightline_colorschemes(...) abort
    return join(map(
                \ globpath(&rtp,"autoload/lightline/colorscheme/*.vim",1,1),
                \ "fnamemodify(v:val,':t:r')"),
                \ "\n")
endfunction

command! -nargs=1 -complete=custom,s:lightline_colorschemes LightlineColorscheme
            \ call s:set_lightline_colorscheme(<q-args>)

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
"                               Vim-CPP-Modern                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:cpp_attributes_highlight = 1 "highlight C++11 attributes
let g:cpp_member_highlight = 1 "Highlight struct/class member variables (both C and C++)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Tagbar                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tagbar_autoclose=1
nnoremap <silent> <F9> :TagbarToggle<CR>
