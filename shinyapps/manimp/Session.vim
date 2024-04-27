let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/research/ManifoldDestiny/shinyapps/manimp
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +84 ~/research/ManifoldDestiny/_quarto.yml
badd +1 ~/research/ManifoldDestiny/R/wasmconverting.R
badd +8 ~/research/ManifoldDestiny/Session.vim
badd +18 ~/research/ManifoldDestiny/R/wasmnonverting.R
badd +206 ~/research/ManifoldDestiny/shinyapps/manimp/app.R
badd +17 ~/research/ManifoldDestiny/shinyapps/manimp/Session.vim
argglobal
%argdel
edit ~/research/ManifoldDestiny/R/wasmconverting.R
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 30 + 47) / 94)
exe '2resize ' . ((&lines * 30 + 47) / 94)
exe '3resize ' . ((&lines * 30 + 47) / 94)
argglobal
balt ~/research/ManifoldDestiny/_quarto.yml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/research/ManifoldDestiny/R/wasmnonverting.R", ":p")) | buffer ~/research/ManifoldDestiny/R/wasmnonverting.R | else | edit ~/research/ManifoldDestiny/R/wasmnonverting.R | endif
if &buftype ==# 'terminal'
  silent file ~/research/ManifoldDestiny/R/wasmnonverting.R
endif
balt ~/research/ManifoldDestiny/_quarto.yml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/research/ManifoldDestiny/shinyapps/manimp/app.R", ":p")) | buffer ~/research/ManifoldDestiny/shinyapps/manimp/app.R | else | edit ~/research/ManifoldDestiny/shinyapps/manimp/app.R | endif
if &buftype ==# 'terminal'
  silent file ~/research/ManifoldDestiny/shinyapps/manimp/app.R
endif
balt ~/research/ManifoldDestiny/shinyapps/manimp/Session.vim
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 206 - ((29 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 206
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 30 + 47) / 94)
exe '2resize ' . ((&lines * 30 + 47) / 94)
exe '3resize ' . ((&lines * 30 + 47) / 94)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
