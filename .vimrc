syntax enable            " enable syntax processing
set tabstop=2            " number of visual spaces per TAB
set softtabstop=2        " number of spaces in tab when editing
set expandtab            " tabs are spaces
set number               " show line numbers
:se mouse+=a             " But doesn't select it with mouse
set cursorline           " highlight current line
set incsearch            " search as characters are entered
set hlsearch             " highlight matches
set linebreak            " don't break words in middle
set enc=utf-8            " utf-8 encoding
set autoindent
set smartindent " turn on Vim's magic indenting
" ...but don't move # lines to the beginning.  See :help smartindent
inoremap # #

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR> 
set foldenable           " enable folding
set foldlevelstart=10    " open most folds by default
set foldnestmax=10       " 10 nested fold max

" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

autocmd FileType make set noexpandtab " Use tabs instead of spaces, otherwise `make` will hate you


set foldmethod=indent " Indent based on how many tabstops there are

" [vim: enable folds but don't automatically close them](http://superuser.com/questions/169973/vim-enable-folds-but-dont-automatically-close-themhttp://superuser.com/questions/169973/vim-enable-folds-but-dont-automatically-close-them)
set foldlevelstart=99

" Various UI
" ----------

set wildmenu " Gives feedback when completing on the vim command line
set wildignore+=*.o,*.obj,*~,.lo,*.swp,*.pyc,*.class " File extensions to ignore in the wildmenu

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup
au BufWrite /private/tmp/crontab.* set nowritebackup " don't write backup file when called by "crontab -e"; it breaks
au BufWrite /private/etc/pw.* set nowritebackup " same for "chpass"; breaks if backups written

" Switch keybindings between moving by display and moving by physical lines - that is, 'k' moves up by a display line, 'gk' by a physical line.
" (This might be confusing if you're not used to it, but it's how most GUI apps behave.)
noremap k gk
noremap j gj
noremap gk k
noremap gj j

" Shift-tab to insert a hard tab
imap <silent> <S-tab> <C-v><tab>

" Insert my name
nmap ,a AAuthor: David Bensoussan <david.bensoussan.job@gmail.com><esc>

set ignorecase " Case-insensitive searches
set smartcase  " This will have searches ignore case unless I use a capital letter
set incsearch  " Start searching right away


" Language-specific
" -----------------
" C
augroup lang_c
    au!
    " C compile
    autocmd BufEnter *.c map <F4> :w<CR>:!gcc -Wall -g -c % -o %< ; true<CR>
    " C compile and run (w/o, w/ parameters)
    autocmd BufEnter *.c map <F5> :w<CR>:!gcc -Wall -g % -o %< && ./%<<CR>
    autocmd BufEnter *.c map <F6> :w<CR>:!gcc -Wall -g % -o %< && ./%<<SPACE>
    " C debug (w/o, w/ parameters)
    autocmd BufEnter *.c map <F7> :w<CR>:!gcc -Wall -g % -o %< && cgdb %<<CR>
    autocmd BufEnter *.c map <F8> :w<CR>:!gcc -Wall -g % -o %< && cgdb %<<SPACE>
    " Memory leaks (w/o, w/ parameters)
    autocmd BufEnter *.c map <ESC><F5> :w<CR>:!gcc -Wall -g % -o %< && valgrind ./%<<CR>
    autocmd BufEnter *.c map <ESC><F6> :w<CR>:!gcc -Wall -g % -o %< && valgrind ./%<<SPACE>
    
    " C no spelling
    " autocmd BufRead *.c setlocal nospell

    " Automatic ctags
augroup END

" Resize splits when window size changes
au VimResized * exe "normal! \<c-w>="
