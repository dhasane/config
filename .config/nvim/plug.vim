

"if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
"	echo "Downloading junegunn/vim-plug to manage plugins..."
"	silent !mkdir -p ~/.config/nvim/autoload/
"	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
"endif

" instalar manejador de plugins en caso de no estar presente
"if empty(glob('~/.vim/autoload/plug.vim'))
"  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

" ######################
" pluggins
" ######################

call plug#begin('~/.vim/plugged')

 " utilidades
 Plug 'mhinz/vim-startify' 							" bonita pantalla de inicio
 " Plug 'morhetz/gruvbox'								" colores cheveres :D
 Plug 'lifepillar/vim-gruvbox8'
 " Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}

 Plug 'liuchengxu/vista.vim'						" informacion sobre partes importantes del archivo
 Plug 'itchyny/lightline.vim'  						" mejor barra de informacion
 Plug 'mbbill/undotree'                             " historial de cambios
 Plug 'christoomey/vim-tmux-navigator'  			" simplificar movimiento entre vim y tmux
 Plug 'scrooloose/nerdcommenter'  					" bonito comentador

 Plug 'puremourning/vimspector'                     " debbuger

 Plug 'liuchengxu/vim-clap', { 'do': function('clap#helper#build_all') }
 " Plug 'tpope/vim-dispatch'

 " git gud
 Plug 'airblade/vim-gitgutter'
 Plug 'tpope/vim-fugitive'

 " soporte de lenguajes
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'sheerun/vim-polyglot'
 Plug 'PotatoesMaster/i3-vim-syntax'
" linting
 " Plug 'neomake/neomake'
 Plug 'dense-analysis/ale'

 " en duda
 Plug 'tpope/vim-surround'
 Plug 'qpkorr/vim-bufkill'
 Plug 'voldikss/vim-floaterm'

call plug#end()


" startify
    function! s:center(lines) abort
      let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
      let centered_lines = map(copy(a:lines),
            \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
      return centered_lines
    endfunction

	let g:ascii = [
\'                   _		',
\'                  / /\					',
\'                 / /  \					',
\'                / / /\ \					',
\'               / / /\ \ \					',
\'              / / /  \ \ \				',
\'             / / /    \ \ \				',
\'            / / /      \ \ \				',
\'           / / /        \ \ \				',
\'          / / /          \ \ \			',
\'         / / /   _   _    \ \ \			',
\'        / / /\  /\ \/ /\  /\ \ \			',
\'      .`.`.`\ \ \ \/ / / / /`.`.`.',
\'    .`.`.` \ \ \ \/ / / / / / `.`.`.',
\'  .`.`.`    \ \ \/ / /\/ / /    `.`.`.',
\'.`.`.`       \ \ \/ /\/ / /       `.`.`.',
\'`.`.`.        \_\  /\  /_/        .`.`.`',
\'  `.`.`.      / /  \/  \ \      .`.`.`',
\'    `.`.`.   / / /\ \/\ \ \   .`.`.`',
\'      `.`.`./ / /\ \ \/\ \ \.`.`.`',
\'        \ \ \/ / /\ \ \ \ \/ / /',
\'         \ \ \/ /_/\ \ \ \/ / /',
\'          \ \ \ \_\/\_\/ / / /',
\'           \ \ \        / / /',
\'            \ \ \      / / /',
\'             \ \ \    / / /',
\'              \ \ \  / / /',
\'               \ \ \/ / /',
\'                \ \ \/ /',
\'                 \ \  /',
\'                  \_\/']

    let g:startify_custom_header = s:center(g:ascii)

    let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Recent']            },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]

    " archivos importantes
    let g:startify_bookmarks = [
		\{'v': '~/.config/nvim/init.vim'},
		\{'vp': '~/.config/nvim/plug.vim'},
        \{'i3': '~/.config/i3/config'},
		\{'z': '~/.config/zsh/zshrc'},
		\{'a': '~/.config/aliasrc'},
		\{'t': '~/.config/tmux/tmux.conf'}
		\]


" colorscheme

    " let g:gruvbox8
    " if []

	" let g:gruvbox_bold = 1
	" let g:gruvbox_underline = 1
	" let g:gruvbox_undercurl = 1
	" let g:gruvbox_termcolors = 256
	" let g:gruvbox_improved_strings = 1
	" let g:gruvbox_improved_warnings = 1
    "
    " " soft, medium, hard
	" let g:gruvbox_contrast_dark = "soft"
    "
	" let g:gruvbox_italicize_comments=1
    set background=dark
    " set background=light
    colorscheme gruvbox8_soft


" coc

    let g:coc_global_extensions = [
                \ 'coc-yank',
                \ 'coc-vimlsp',
                \ 'coc-prettier',
                \ 'coc-pairs',
                \ 'coc-explorer',
                \ 'coc-rust-analyzer',
                \ 'coc-python',
                \ 'coc-json',
                \ 'coc-java'
                \]

                " \ 'coc-git',

    " CocCommand snippets.editSnippets

    " if hidden is not set, TextEdit might fail.
    set hidden

    " Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup

    " Better display for messages
    set cmdheight=2

    " You will have bad experience for diagnostic messages when it's default 4000.
    set updatetime=300

    " don't give |ins-completion-menu| messages.
    set shortmess+=c

    " always show signcolumns
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'
    let g:coc_snippet_prev = '<S-tab>'

    " Use <c-tab> to trigger completion.
    inoremap <silent><expr> <c-tab> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    nmap <silent> <C-d> <Plug>(coc-range-select)
    xmap <silent> <C-d> <Plug>(coc-range-select)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    " coc-yank
        nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

    " coc-explorer
        " noremap <Leader>t :NERDTreeToggle<cr>
        noremap <Leader>t :CocCommand explorer<CR>

" para unir esto a tmux
" let g:tmux_navigator_no_mappings = 1

    noremap <c-h> <esc>
    noremap <c-j> <esc>
    noremap <c-k> <esc>
    noremap <c-l> <esc>

    noremap <silent> <c-h> <esc>:TmuxNavigateLeft<cr>
    noremap <silent> <c-j> <esc>:TmuxNavigateDown<cr>
    noremap <silent> <c-k> <esc>:TmuxNavigateUp<cr>
    noremap <silent> <c-l> <esc>:TmuxNavigateRight<cr>
    noremap <silent> <c-/> <esc>:TmuxNavigatePrevious<cr>

" Write all buffers before navigating from Vim to tmux pane
    let g:tmux_navigator_save_on_switch = 2

" nerdcommenter
	nnoremap <C-_> :call NERDComment('Toggle', 'Toggle')<CR>
	inoremap <C-_> <esc>:call NERDComment('Toggle', 'Toggle')<CR>
	vnoremap <C-_> :call NERDComment('Toggle', 'Toggle')<CR>gv
	" Add spaces after comment delimiters by default
	let g:NERDSpaceDelims = 1

	" Use compact syntax for prettified multi-line comments
	let g:NERDCompactSexyComs = 1

	" Align line-wise comment delimiters flush left instead of following code indentation
	let g:NERDDefaultAlign = 'left'

	" Allow commenting and inverting empty lines (useful when commenting a region)
	let g:NERDCommentEmptyLines = 1

	" Enable trimming of trailing whitespace when uncommenting
	let g:NERDTrimTrailingWhitespace = 1

	" Enable NERDCommenterToggle to check all selected lines is commented or not
	let g:NERDToggleCheckAllLines = 1


" vimspector
" let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
let g:vimspector_enable_mappings = 'HUMAN'

" neomake

    " When writing a buffer (no delay).
    " call neomake#configure#automake('w')
    " When writing a buffer (no delay), and on normal mode changes (after 750ms).
    " call neomake#configure#automake('nw', 750)
    " When reading a buffer (after 1s), and when writing (no delay).
    " call neomake#configure#automake('rw', 1000)
    " Full config: when writing or reading a buffer, and on changes in insert and
    " normal mode (after 500ms; no delay when writing).


    " call neomake#configure#automake('nrwi', 500)
    " tambien se pueden llamar otros procesos

" gitgutter
	let g:gitgutter_max_signs = 200
	" nmap ]h <Plug>(GitGutterNextHunk)
	" nmap [h <Plug>(GitGutterPrevHunk)

" undotree

    noremap <Leader>u :UndotreeToggle<cr>

    if !exists('g:undotree_WindowLayout')
        let g:undotree_WindowLayout = 2
    endif
    " if set, let undotree window get focus after being opened, otherwise
    " focus will stay in current window.
    if !exists('g:undotree_SetFocusWhenToggle')
        let g:undotree_SetFocusWhenToggle = 1
    endif
    " tree node shape.
    " if !exists('g:undotree_TreeNodeShape')
    "     let g:undotree_TreeNodeShape = '+'
    " endif


" float term
    """ Example configuration
    " let g:floaterm_keymap_new    = '<F7>'
    " let g:floaterm_keymap_prev   = '<F8>'
    " let g:floaterm_keymap_next   = '<F9>'
    " let g:floaterm_keymap_toggle = '<F10>'

    let g:floaterm_type = "floating"
    let g:floaterm_position = "center"
    autocmd User Startified setlocal buflisted
    noremap <Leader>. <esc> :FloatermToggle <cr>

" Clap

	noremap <Leader>ñ :Clap files <cr>
	noremap <Leader>s :Clap blines <cr>
	noremap <Leader>p :Clap <cr>

" status bar

    " source ~/.config/nvim/theme/gruvbox.vim
    " source ~/.config/nvim/theme/gruvbox_material.vim
    source ~/.config/nvim/theme/gruvbox_material_dark.vim
    " source ~/.config/nvim/theme/gruvbox_material_light.vim
        " \ 'colorscheme': 'gruvbox',
    let g:lightline = {
        \ 'colorscheme': 'gruvbox_material',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'readonly','gitbranch' , 'filename', 'modified'] ],
        \   'right': [ [ 'lineinfo' ],
        \              [ 'percent', 'gitblame' ],
        \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'inactive': {
        \       'left': [ [ 'filename' ] ],
        \       'right': [ [ 'lineinfo' ] ]
        \ },
        \ 'tabline': {
        \       'left': [ [ 'tabs' ] ],
        \       'right': [ ]
        \ },
        \ 'separator' : { 'left': '', 'right': '' },
        \ 'subseparator' : { 'left': '|', 'right': '|' },
        \ 'tabline_separator': { 'left': '', 'right': '' },
        \ 'tabline_subseparator': { 'left': '', 'right': '' },
        \ 'component_function': {
        \       'filename': 'FilenameForLightline',
        \       'gitbranch': 'GitBranchLL',
        \       'gitblame': 'LightlineGitBlame'
        \ },
        \ }

        function! GitBranchLL()
            let br = fugitive#head()
            if br != ""
                return br." "
            endif
            return ""
        endfunction

        " Show path of filename
        function! FilenameForLightline()
            return expand('%')
        endfunction

        function! LightlineGitBlame()
          let blame = get(b:, 'coc_git_blame', '')
          return blame
          " return winwidth(0) > 120 ? blame : ''
        endfunction





