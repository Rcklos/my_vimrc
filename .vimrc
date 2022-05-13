set pythonthreedll=python39.dll

"关闭菜单，滚动条，工具栏
set guioptions-=m
set guioptions-=r
set guioptions-=L
set guioptions-=T

"插入模式下移动光标
inoremap <C-j> <ESC>ja
inoremap <C-k> <ESC>ka
inoremap <C-h> <ESC>ha
inoremap <C-l> <ESC>la


" Vim's default behavior
if &compatible
  set nocompatible
endif

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

let g:iswin=0
let g:islinux=0
let g:isgui=0

if(has("win32")||has("win64"))
	let g:iswin=1
else
	let g:islinux=1
endif

if(has("gui_running"))
	let g:isgui=1
endif

"最大化打开
autocmd GUIEnter * simalt ~x

" autocmd VimEnter * NERDTree "自动打开文件树

"首先设置编码，否则中文乱码
"vim内部编码，寄存器那些使用
set encoding=utf-8 		
"编码自动识别列表，首先用第一项解码，逐次向后		
set fileencodings=utf-8,gb2312

"设置退格键功能
set backspace=2 "indent,eol,start

"设置颜色主题,该主题不在默认安装，需要下载
colorscheme onedark

"设置字体，该字体需要下载安装
set guifont=Bitstream_Vera_Sans_Mono:h14:cANSI

"自动重载配置文件，只对一部分配置有效，插件配置需要重新启动
"autocmd BufWritePost $MYVIMRC source $MYVIMRC

"语法高亮，需要重启
syntax on

"显示行号
set number

"相对行号
set relativenumber

"设置tab键宽度为4
set tabstop=2
"设置自动缩进长度为4
set shiftwidth=2
set expandtab
"按c语言格式缩进
"set cindent
"根据文件类型自动缩进
filetype plugin indent on
"继承前一行的缩进方式
set autoindent
"解决粘贴缩进异常
"set paste

"显示不可见字符
set list
set listchars=tab:>-,trail:-

"输入搜索内容时高亮
"set incsearch
"搜索结果高亮
set hlsearch

"不需要兼容Vi
set nocompatible

"突出显示光标行列位置
"set cursorline
"set cursorcolumn

"开启底边栏状态条，使用插件不开启
"set ruler
"状态栏行数
"set laststatus=2

"响应鼠标点击，gvim安装时可以配置，不需要
"set mouse=a
"set selection=exclusive
"selectmode=mouse,key

"光标距离顶行底行5滚动
set scrolloff=5

"不使用交换文件，用于异常退出文件恢复
set noswapfile

"***********************************************************************************
"*******************************插件配置区******************************************
"***********************************************************************************
if(g:iswin==1) 
	let g:myplugdir="$VIM/myplug"
elseif(g:islinux==1)
	let g:myplugdir="$HOME/.vim/myplug"
endif
call plug#begin(g:myplugdir)
"文件浏览器
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"tags生成和边栏
" Plug 'preservim/tagbar', { 'on':  'TagbarToggle' }
" 内置终端插件
Plug 'skywind3000/vim-terminal-help'
" 单元测试
Plug 'vim-test/vim-test'
"底栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"buffer管理
Plug 'jlanzarotta/bufexplorer'
"Plug 'ap/vim-buftabline'
"括号自动关闭
Plug 'Townk/vim-autoclose'
"自动函数注释
Plug 'babaybus/DoxygenToolkit.vim'
"补全和语法检测支持
Plug 'neoclide/coc.nvim', {'branch': 'release'}  
"彩色括号
Plug 'luochen1990/rainbow'
"快速注释
Plug 'preservim/nerdcommenter'
"调试
Plug 'puremourning/vimspector', {'do':'./install_gadget.py --enable-c'}
"markdown
"Plug 'iamcco/markdown-preview.vim'
"Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'instant-markdown/vim-instant-markdown'
Plug 'IC-killer/vim-Ken'
"翻译
Plug 'voldikss/vim-translator'
"中文帮助文档
Plug 'yianwillis/vimcdoc'
"二进制编辑插件
Plug 'Shougo/vinarise.vim'
"easymotion
Plug 'easymotion/vim-easymotion'

call plug#end()

"翻译
"let g:translator_default_engines = 'bing'
nmap <silent> <Leader>t :Translate<cr>
vmap <silent> <Leader>t :TranslateV<cr>
nmap <silent> <Leader>tt <Plug>TranslateW
vmap <silent> <Leader>tt <Plug>TranslateWV
nnoremap <silent> <space><space> :Ken<cr>
"markdown preview
"Uncomment to override defaults:
filetype plugin on 
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 1
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_mermaid = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
let g:instant_markdown_autoscroll = 1
"let g:instant_markdown_port = 8288
"let g:instant_markdown_python = 1

"spector 快捷键
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
"let g:vimspector_enable_mappings = 'HUMAN'

"---------------------------------------------------------------------------------------------------
"快速注释默认配置
let g:NERDCreateDefaultMappings = 1

"---------------------------------------------------------------------------------------------------
"彩色括号配置
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}

"---------------------------------------------------------------------------------------------------
"函数自动注释配置
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Wang Jiancong"
let g:DoxygenToolkit_licenseTag="My own license" 

"---------------------------------------------------------------------------------------------------
"底行配置
let g:airline_theme="molokai"
"let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

"tab切换标签
nmap <tab> :bn<cr>

"---------------------------------------------------------------------------------------------------
"文件树配置
" let g:NERDCreateDefaultMappings = 1 
" let g:NERDTreeShowBookmarks = 1 
" let g:NERDTreeShowHidden = 1 

" 内置终端配置
let g:terminal_kill = 'term'
" 自定义终端程序
if (has("gui_running") && has("win64"))
  " 如果是GVIM且是win64, 则使用git-bash
  let g:terminal_shell='D:\Git\bin\bash.exe'
endif
let g:terminal_cwd = 2

"---------------------------------------------------------------------------------------------------
"ctags 配置
" set tags=tags;
" set autochdir

"---------------------------------------------------------------------------------------------------
"coc相关配置。。。。。。。。
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
'
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"***********************************************************************************
"************************自定义快捷键配置不包含插件*********************************
"***********************************************************************************
"生成tags
" map <F2> :!ctags -R * <CR>
"nnoremap <leader><F2> :!ctags -R * <CR>
"打开/关闭文件树
map <F3> :CocCommand explorer<CR>
" map <F3> :NERDTreeToggle<CR>
"nnoremap <leader><F3> :NERDTreeToggle<CR>
"打开/关闭tagbar
" map <F4> :TagbarToggle<CR>
"nnoremap <leader><F4> :TagbarToggle<CR>


"***********************************************************************************
"******************************自定义功能区*****************************************
"***********************************************************************************
"-----------------------------keil------------------------------
function MakeKeilTarget(options)
    let l:target = ''
    let l:target51 = ''
	wa
    echo '当前目录:'expand('<sfile>:p')

    "-------------------------MDK-------------------------
    if !empty(glob('*.uvprojx'))
        let l:target =  glob('*.uvprojx')
    elseif !empty(glob('../*.uvprojx'))
        let l:target =  glob('../*.uvprojx')
    elseif !empty(glob('../../*.uvprojx'))
        let l:target =  glob('../../*.uvprojx')
    elseif !empty(glob('../MDK-ARM/*.uvprojx'))	"stm32-Cube
        let l:target =  glob('../MDK-ARM/*.uvprojx')
    elseif !empty(glob('../../MDK-ARM/*.uvprojx'))	"stm32-Cube
        let l:target =  glob('../../MDK-ARM/*.uvprojx')
    elseif !empty(glob('./MDK-ARM/*.uvprojx'))	"stm32-Cube
        let l:target =  glob('./MDK-ARM/*.uvprojx')
    endif
    "-------------------------8051-------------------------
    if !empty(glob('*.uvproj'))
        let l:target51 =  glob('*.uvproj')
    elseif !empty(glob('../*.uvproj'))
        let l:target51 =  glob('../*.uvproj')
    elseif !empty(glob('../../*.uvproj'))
        let l:target51 =  glob('../../*.uvproj')
    endif
    
    if !empty(l:target)
        execute ':silent !uv4 '.a:options.l:target.' -j0 -o "\%TEMP\%/mdk_log.txt"'
        "execute ':!uv4 '.a:options.l:target.' -o "\%TEMP\%/mdk_log.txt" && type "\%TEMP\%\mdk_log.txt" && pause'
		execute ':silent !type "\%TEMP\%\mdk_log.txt" && pause'
    elseif !empty(l:target51)
        execute ':silent !uv4 '.a:options.l:target51.' -j0 -o "\%TEMP\%/mdk_log.txt"'
        "execute ':!uv4 '.a:options.l:target51.' -o "\%TEMP\%/mdk_log.txt" && type "\%TEMP\%\mdk_log.txt" && pause'
		execute ':silent !type "\%TEMP\%\mdk_log.txt" && pause'
    else
        echo 'Target not found!'
    endif
endfunction

nnoremap <leader>kb :call MakeKeilTarget('-b ')<CR>
"nnoremap <leader>kr :call MakeKeilTarget('-b -z ')<CR>
nnoremap <leader>kr :call MakeKeilTarget('-cr ')<CR>
nnoremap <leader>kd :call MakeKeilTarget('-f ')<CR>

"窗口切换
nnoremap <leader>s <C-W>h<CR>
nnoremap <leader>d <C-W>l<CR>
nnoremap <leader>j <C-W>x<CR>
"窗口大小调整
nnoremap <leader>w :vertical resize -10<CR>
nnoremap <leader>e :vertical resize +10<CR>
"bin
nnoremap <leader>hex :Vinarise<CR>


"保存工作区
" manually save a session with <F5>
"noremap <F5> :mksession! $VIM/manual_session.vim<cr>
" recall the manually saved session with <F6>
"noremap <F6> :source $VIM/manual_session.vim<cr>

"hi BufTabLineCurrent guifg=bg guibg=LightGreen
"hi BufTabLineActive guifg=bg guibg=#E5C07B
"hi BufTabLineHidden guifg=bg guibg=#98C379

" toggle fullscreen mode by pressing F11
"noremap <leader>aa :call libcallnr('gvim_fullscreen.dll', 'ToggleFullscreen', 0)<cr>
" toggle window transparency to 247 or 180 by pressing F12
"noremap <leader>ii :call libcallnr('gvim_fullscreen.dll', 'ToggleTransparency', "247,180")<cr>
" toggle fullscreen mode by pressing F11



if has('gui_running') && has('libcall')
	let g:MyVimLib = $VIMRUNTIME.'/gvimfullscreen.dll'
	function ToggleFullScreen()
		call libcallnr(g:MyVimLib, "ToggleFullScreen", 0)
	endfunction
    
	"Alt+Enter
	map <A-Enter> <Esc>:call ToggleFullScreen()<CR>
  " 上面的最大化打开是fake的!!!!
  au VimEnter * :call ToggleFullScreen()


	let g:VimAlpha = 240
	function! SetAlpha(alpha)
		let g:VimAlpha = g:VimAlpha + a:alpha
		if g:VimAlpha < 180
			let g:VimAlpha = 180
		endif
		if g:VimAlpha > 255
			let g:VimAlpha = 255
		endif
		call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
	endfunction
    
	"Shift+Y
	nmap <A-y> <Esc>:call SetAlpha(3)<CR>
	"Shift+T
	nmap <A-t> <Esc>:call SetAlpha(-3)<CR>

	let g:VimTopMost = 0
	function! SwitchVimTopMostMode()
		if g:VimTopMost == 0
			let g:VimTopMost = 1
		else
			let g:VimTopMost = 0
		endif
		call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
	endfunction
      
	"nmap <A-r> <Esc>:call SwitchVimTopMostMode()<CR>
endif

set timeoutlen=1 ttimeoutlen=0
