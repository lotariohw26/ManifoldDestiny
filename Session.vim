let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Research/ManifoldDestiny
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 ~/InitJIH/README.md
badd +2 ~/Research/ManifoldDestiny/_quarto.yml
badd +14 ~/Research/ManifoldDestiny/_apps_rel_2024.yml
badd +30 ~/Research/ManifoldDestiny/prerendr.R
badd +1 ~/Research/ManifoldDestiny/_apps_his.yml
badd +12 ~/Research/ManifoldDestiny/R/wasmnonverting.R
badd +14 ~/Research/ManifoldDestiny/R/wasmconverting.R
badd +11 ~/Research/ManifoldDestiny/_apps_rel_2020.yml
badd +46 term://~/Research/ManifoldDestiny//928712:bash
badd +1 ~/Research/ManifoldDestiny/script/R/complexregression.R
badd +26 ~/Research/ManifoldDestiny/script/R/testing.R
badd +19 term://~/Research/ManifoldDestiny//943580:bash
badd +7 ~/Research/ManifoldDestiny/script/R/testing2024.R
argglobal
%argdel
$argadd ~/InitJIH/README.md
edit ~/Research/ManifoldDestiny/R/wasmnonverting.R
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
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
exe '1resize ' . ((&lines * 26 + 27) / 54)
exe 'vert 1resize ' . ((&columns * 71 + 106) / 213)
exe '2resize ' . ((&lines * 25 + 27) / 54)
exe 'vert 2resize ' . ((&columns * 71 + 106) / 213)
exe 'vert 3resize ' . ((&columns * 70 + 106) / 213)
exe 'vert 4resize ' . ((&columns * 70 + 106) / 213)
argglobal
balt ~/Research/ManifoldDestiny/_quarto.yml
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 12 - ((11 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 12
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/prerendr.R", ":p")) | buffer ~/Research/ManifoldDestiny/prerendr.R | else | edit ~/Research/ManifoldDestiny/prerendr.R | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/prerendr.R
endif
balt ~/Research/ManifoldDestiny/_quarto.yml
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 30 - ((10 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 30
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/script/R/testing.R", ":p")) | buffer ~/Research/ManifoldDestiny/script/R/testing.R | else | edit ~/Research/ManifoldDestiny/script/R/testing.R | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/script/R/testing.R
endif
balt ~/Research/ManifoldDestiny/script/R/testing2024.R
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 26 - ((25 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 26
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/_apps_rel_2024.yml", ":p")) | buffer ~/Research/ManifoldDestiny/_apps_rel_2024.yml | else | edit ~/Research/ManifoldDestiny/_apps_rel_2024.yml | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/_apps_rel_2024.yml
endif
balt ~/Research/ManifoldDestiny/_quarto.yml
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
4wincmd w
exe '1resize ' . ((&lines * 26 + 27) / 54)
exe 'vert 1resize ' . ((&columns * 71 + 106) / 213)
exe '2resize ' . ((&lines * 25 + 27) / 54)
exe 'vert 2resize ' . ((&columns * 71 + 106) / 213)
exe 'vert 3resize ' . ((&columns * 70 + 106) / 213)
exe 'vert 4resize ' . ((&columns * 70 + 106) / 213)
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
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
