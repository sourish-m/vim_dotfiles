"Author: Sourish Mandal
"-------------------My VIMRC File---------------------------------------
"==Sources Included==
" source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/defaults.vim
source $VIMRUNTIME/mswin.vim

"-----------------------------------------------------------------------
 " augroup vimrcEx
 "     au!
 "     " For all text files set 'textwidth' to 78 characters.
 "     autocmd FileType text setlocal textwidth=78
 " augroup END
"--------------------Set Options--------------------------------------

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
set splitbelow "these lines ensure that new splits appear to below and right instead of Vim's default order 
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
set cursorline "highlight current line

"---------------------------------------------------------------------------------------------
set fillchars=stl:\ ,stlnc:\ ,eob:\ ,lastline:~

inoremap jk <Esc>
inoremap kj <Esc> 
"this remaps <Esc> to jk or kj  in insert mode  

augroup prog
    au!
autocmd Filetype c setlocal makeprg=gcc\ -g\ -pipe\ %\ -o\ $*<
autocmd Filetype cpp setlocal makeprg=g++\ -g\ -pipe\ %\ -o\ $*<
" Execute with <cf5>
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

"----------------------------------Copied from Romainl's gist---------------------------------
""Smarter grep using rg
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

"-----------------------Folding-----------------------------------------
"In normal mode, press Space to toggle the current fold open/closed.
"However, if the cursor is not in a fold, move to the right (the default behavior)
 nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
 vnoremap <Space> zf
 set foldmethod=syntax "set folding per syntax
 set foldnestmax=1
 set foldcolumn=0
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

"----------mapping from reddit -----------------------------
vnoremap <silent> <C-j> :m '>+1<CR>gv
vnoremap <silent> <C-k> :m '<-2<CR>gv
"move lines up or down using Control-j/k

" ------------------Window mappings-------------------------
" use arrow keys to move between windows in the terminal
nnoremap <silent><F4> :wincmd c<CR>
if !has('gui')
nnoremap <LEFT> <C-w>h
nnoremap <RIGHT> <C-w>l
nnoremap <DOWN> <C-w>j
nnoremap <UP> <C-w>k
endif

"------------Integrate VIM with Windows File Explorer--------
if has('gui')
nnoremap <leader>bo :browse e!<CR>
nnoremap <leader>bs :browse confirm saveas!<CR>
endif

"---------------------VIM Plug------------------------------
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
Plug 'romainl/vim-cool'
"-> auto-removes search highlight
" Plug 'mhinz/vim-startify'
"-> Cool Start Screen
Plug 'preservim/tagbar'
"-> <F9> for tagbar
Plug 'tweekmonster/startuptime.vim'
"-> :StartupTime
Plug 'sainnhe/everforest'
Plug 'psliwka/vim-smoothie'
"--> Smooth scrolling using CTRL-D and CTRL-U
call plug#end()
"-----------------------------------------------------------------------
colorscheme everforest
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

"----------------------Ale----------------------------------
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

"---------------Termdebug-----------------------------------
let g:termdebug_popup = 0
let g:termdebug_wide = 163

" ----------------Undotree----------------------------------
let g:undotree_ShortIndicators=1
let g:undotree_SetFocusWhenToggle=1
let g:undotree_DiffAutoOpen=0
nnoremap <F1> :UndotreeToggle<cr>


"------------------Vim-cpp-modern---------------------------
let g:cpp_attributes_highlight = 1 "Enable highlighting of C++11 attributes
let g:cpp_member_highlight = 1 "Highlight struct/class member variables (affects both C and C++ files)
"-----------------------------------------------------------
"-----------------------Startify----------------------------
 let g:startify_bookmarks = [  '$VIM\_vimrc', '$VIM\_gvimrc' ]
let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1
" let g:startify_session_persistence = 1
" let g:startify_session_sort = 1
let g:startify_skiplist= ['vimfiles\\plugged', 'vim90', '.git', 'site-packages']
let g:startify_lists = [
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'files',     'header': ['   Recently Used']            },
          \ { 'type': 'dir',       'header': ['   Recently Used at- '. getcwd()] },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]
" let g:startify_custom_header =['   ╔═══════════════╗',
"                               \'         VIM 9      ',
"                               \'   ╚═══════════════╝',]


"-----------------------Tagbar------------------------------
let g:tagbar_autoclose=1
nnoremap <silent> <F9> :TagbarToggle<CR>
