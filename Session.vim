let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/research/ManifoldDestiny
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +93 ~/research/ManifoldDestiny/_quarto.yml
badd +1 ~/research/ManifoldDestiny/R/wasmconverting.R
badd +1 ~/research/ManifoldDestiny/R/wasmnonverting.R
badd +1 ~/research/ManifoldDestiny/script/R/applications.R
badd +1 ~/research/ManifoldDestiny/script/python/polysolver.py
badd +1 ~/research/ManifoldDestiny/script/python/pysympy.py
badd +1 ~/research/ManifoldDestiny/shinyapps/manimp/app.R
badd +1 ~/research/ManifoldDestiny/shinyapps/empapp/app.R
argglobal
%argdel
edit ~/research/ManifoldDestiny/_quarto.yml
argglobal
balt ~/research/ManifoldDestiny/shinyapps/empapp/app.R
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
let s:l = 93 - ((91 * winheight(0) + 46) / 92)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 93
normal! 013|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
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
