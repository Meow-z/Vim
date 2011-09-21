set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"��ɫ
colorscheme slate
"����
set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
"�к�,�к���Ŀ���
set nu
set numberwidth=2
"tab����
set tabstop=2
"�Զ�����
set autoindent
"�﷨����
syntax on
"����gbk�ַ����б������⣬�����ַ���
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
"�м��
set linespace=2
"<>��������ʱ�ĳ���
set shiftwidth=2
"��ʼ�����ڿ�ȸ߶�
set columns=150
set lines=30
"��ʼ������λ��
winpos 52 42

"��ֹ�Զ�����
set nowrap
"����������ʱ�г�ƥ����Ŀ
set wildmenu
"��ʾ���λ��
set ruler
"�ָ�ڱ�����ȿ��
set equalalways

"ƥ�����Ź�������html��<>
set matchpairs=(:),{:},[:],<:>
"���˸񣬿ո����¼�ͷ��������λ�Զ��Ƶ���һ��(����insertģʽ)
set whichwrap=b,s,<,>,[,]
"ȡ���Զ�����
set nobackup
"�ر��ļ�֮ǰ����һ������
set writebackup

"js�﷨�����ű�
let g:javascript_enable_domhtmlcss=1

"���׼��
set cursorline
hi cursorline guibg=NONE gui=underline
set cursorcolumn
hi cursorcolum gui=underline

"�Զ��޸�
set autoread

"���������ȣ�����double����
set ambiwidth=double
"��javascript�۵�
"
setlocal foldlevel=1
let g:tlist_javascript_settings = 'javascript;s:string;a:array;o:object;f:function;m:member'
let b:javascript_fold=1  "�����۵�
"�Զ��������ŵ�
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i


function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
      return "/<Right>"
  else
      return a:char
  endif
endfunction

"�Զ�����html"
function! InsertHtmlTag()
        let pat = '\c<\w\+\s*\(\s\+\w\+\s*=\s*[''#$;,()."a-z0-9]\+\)*\s*>'
        normal! a>
        let save_cursor = getpos('.')
        let result = matchstr(getline(save_cursor[1]), pat)
        "if (search(pat, 'b', save_cursor[1]) && searchpair('<','','>','bn',0,  getline('.')) > 0)
        if (search(pat, 'b', save_cursor[1]))
           normal! lyiwf>
           normal! a</
           normal! p
           normal! a>
        endif
        :call cursor(save_cursor[1], save_cursor[2], save_cursor[3])
endfunction
inoremap > <ESC>:call InsertHtmlTag()<CR>a

"��͸������"
au GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 234)
"git ����"
set laststatus=2
set statusline=%{GitBranch()}

command Gogm cd E:\apache\htdocs\gm\ 
command Golithe cd E:\apache\htdocs\lithe\ 
command GoTanKe cd E:\apache\htdocs\TanKe\

:map gd :GitDiff
:map gD :GitDiff �Ccached
:map gs :GitStatus
:map gl :GitLog
:map ga :GitAdd
:map gA :GitAdd <cfile>
:map gc :GitCommit

