" arrow.vim - my arrow setting
" Maintainer:   Dejian Xu <https://github.com/hsujian>
" Version:      0.1

if exists('g:loaded_arrow_vim') || &compatible
  finish
else
  let g:loaded_arrow_vim = 1
endif

" Vim. Live it. ------------------------------------------------------- {{{
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" }}}

function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

" Arrow key remapping: Up/Dn = move line up/dn; Left/Right = indent/unindent
" `Ctrl-Up` and `Ctrl-Down`, instead, deletes or inserts a blank line below the current line
function! SetArrowKeysAsTextShifters()
  " exchange lines
  nnoremap  <s-up> :call <SID>swap_up()<CR>
  nnoremap  <s-down> :call <SID>swap_down()<CR>
  inoremap  <s-up> <esc>:call <SID>swap_up()<CR>a
  inoremap  <s-down> <esc>:call <SID>swap_down()<CR>a
endfunction
"call SetArrowKeysAsTextShifters()

if has("gui_running")
  if has("gui_macvim")
    no <D-M-Left> gT
    no <D-M-Right> gt
    imap <D-M-Left> <C-o><D-M-Left>
    imap <D-M-Right> <C-o><D-M-Right>
  endif

  if exists("macvim_skip_cmd_opt_movement")
    noremap <expr> <D-Left> (col('.') == 1 ? 'gT' : (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^'))
    noremap <expr> <D-Right> ((col('$') - col('.')) < 2 ? 'gt' : (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_'))
  endif
endif

noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
noremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_')
vnoremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')
imap <Home> <C-o><Home>
imap <End> <C-o><End>

" vim:set ft=vim et sw=2:
