set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Require Vundle to manage itself
Bundle 'gmarik/vundle'

" Load Bundles
" Bundle 'yonchu/accelerated-smooth-scroll'
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdtree'
Bundle 'moll/vim-node'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
" Bundle 'marijnh/tern_for_vim'
Bundle 'tmhedberg/matchit'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-fugitive'
Bundle 'pangloss/vim-javascript'
Bundle 'elzr/vim-json'
Bundle 'tpope/vim-surround'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'lukaszb/vim-web-indent'
Bundle 'Valloric/MatchTagAlways'
Bundle 'tmhedberg/matchit'
Bundle 'ryyppy/nerdcommenter'
Bundle 'groenewege/vim-less'
Bundle 'duff/vim-bufonly'
Bundle 'mxw/vim-jsx' 
Bundle 'bling/vim-airline'
Bundle 'kchmck/vim-coffee-script'
Bundle 'lambdatoast/elm.vim'
Bundle 'facebook/vim-flow'
Bundle 'mephux/bro.vim'

" YouCompleteMe 
if has('python')
    if v:version >= '704' 
        Bundle 'Valloric/YouCompleteMe'
        "Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
    endif
endif

set encoding=utf-8
set noet ai cin bs=2 cb=unnamed
set number ruler nowrap autoread showcmd showmode fdm=marker

" Disable the creation of backup files (those with ~)
set nobackup nowritebackup

" Fix the tabbing system
set tabstop=2 shiftwidth=2 expandtab
set autoindent smartindent nocindent indentexpr=
set hlsearch
set splitright

" Tabbing for specific filetypes
au FileType coffee setl sw=2 sts=2 et
au FileType elm setl sw=2 sts=2 et


" Specific tabbing for languages
autocmd Filetype javascript set tabstop=2 shiftwidth=2 expandtab

"Enable the neat filetype and syntax sugar
filetype on
filetype plugin on
filetype plugin indent on
syntax on

" Enable javascript highlighting for flowtype
au BufNewFile,BufRead *.flow set filetype=javascript

" Powerline
set laststatus=2
set noshowmode

"Set color scheme
set background=dark
"let g:solarized_termcolors=256
"colorscheme solarized
colorscheme grb256
set t_Co=256

" Keymappings
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Opening and closing braces
imap <C-F> {<CR>}<C-O>O

" Puts a literal ^I (literal tab character)
:inoremap <S-Tab> <C-V><Tab>

" Git-Commit formatting
autocmd Filetype gitcommit setlocal wrap spell textwidth=72

" MD formatting
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd Filetype markdown setlocal wrap textwidth=80 

" Ultisnip 
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Tagbar 
let g:tagbar_type_javascript = { 'ctagsbin' : 'jsctags' } 

" vim-json 
let g:vim_json_syntax_conceal=0

" NERDtree 
let g:NERDTreeDirArrows=0 " fixes weird characters as list arrows

" Mustache-Handlebar
let g:mustache_abbreviations = 1

" Syntastic Configuration
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0 " don't check on :wq and :x
let g:syntastic_enable_signs=1 " errors on left side
let syntastic_mode_map = { 'passive_filetypes': ['html'] }
let g:syntastic_less_use_less_lint = 0   

" You Complete Me Configuration
let g:ycm_autoclose_preview_window_after_completion=1

"if executable('jshint')
    "let g:syntastic_javascript_checkers=['jshint']
"endif
"
if executable('eslint')
    let g:syntastic_javascript_checkers=['eslint']
endif

""""""""""""""""""""
" Flowtype config
""""""""""""""""""""
let g:flow#autoclose = 1

"Use locally installed flow
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif

if executable(local_flow)
  let g:flow#flowpath = local_flow
endif
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## de0e3f914ca654372bea46d03b12acaf ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/Users/ryyppy/.opam/4.04.2/share/vim/syntax/ocp-indent.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
