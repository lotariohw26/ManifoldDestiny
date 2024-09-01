let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Research/ManifoldDestiny/script/R
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +10 ~/InitLOT/README.md
badd +1 ~/InitLOT/Session.vim
badd +24 ~/Research/ManifoldDestiny/_quarto.yml
badd +1 ~/Research/ManifoldDestiny/Session.vim
badd +1 ~/Research/ManifoldDestiny/_apps_rel.yml
badd +1 ~/Research/ManifoldDestiny/script/python/polysolver.py
badd +1 ~/Research/ManifoldDestiny/data-raw/record_static.R
badd +1 ~/Research/ManifoldDestiny/R/wasmconverting.R
badd +1 ~/Research/ManifoldDestiny/R/wasmnonverting.R
badd +1 ~/Research/ManifoldDestiny/script/R/testing.R
badd +28 term://~/Research/ManifoldDestiny/script/python//155604:bash
badd +29 ~/Research/ManifoldDestiny/prerendr.R
badd +14 term://~/Research/ManifoldDestiny/script/python//156410:bash
argglobal
%argdel
$argadd ~/InitLOT/README.md
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit ~/Research/ManifoldDestiny/_apps_rel.yml
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
wincmd _ | wincmd |
split
1wincmd k
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
exe '1resize ' . ((&lines * 25 + 27) / 54)
exe 'vert 1resize ' . ((&columns * 71 + 106) / 213)
exe '2resize ' . ((&lines * 25 + 27) / 54)
exe 'vert 2resize ' . ((&columns * 71 + 106) / 213)
exe '3resize ' . ((&lines * 25 + 27) / 54)
exe 'vert 3resize ' . ((&columns * 70 + 106) / 213)
exe '4resize ' . ((&lines * 25 + 27) / 54)
exe 'vert 4resize ' . ((&columns * 70 + 106) / 213)
exe 'vert 5resize ' . ((&columns * 70 + 106) / 213)
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
let s:l = 1 - ((0 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/data-raw/record_static.R", ":p")) | buffer ~/Research/ManifoldDestiny/data-raw/record_static.R | else | edit ~/Research/ManifoldDestiny/data-raw/record_static.R | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/data-raw/record_static.R
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
let s:l = 1 - ((0 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/R/wasmnonverting.R", ":p")) | buffer ~/Research/ManifoldDestiny/R/wasmnonverting.R | else | edit ~/Research/ManifoldDestiny/R/wasmnonverting.R | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/R/wasmnonverting.R
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
let s:l = 1 - ((0 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/R/wasmnonverting.R", ":p")) | buffer ~/Research/ManifoldDestiny/R/wasmnonverting.R | else | edit ~/Research/ManifoldDestiny/R/wasmnonverting.R | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/R/wasmnonverting.R
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
let s:l = 1 - ((0 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/script/R/testing.R", ":p")) | buffer ~/Research/ManifoldDestiny/script/R/testing.R | else | edit ~/Research/ManifoldDestiny/script/R/testing.R | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/script/R/testing.R
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
let s:l = 45 - ((0 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 45
normal! 0
wincmd w
5wincmd w
exe '1resize ' . ((&lines * 25 + 27) / 54)
exe 'vert 1resize ' . ((&columns * 71 + 106) / 213)
exe '2resize ' . ((&lines * 25 + 27) / 54)
exe 'vert 2resize ' . ((&columns * 71 + 106) / 213)
exe '3resize ' . ((&lines * 25 + 27) / 54)
exe 'vert 3resize ' . ((&columns * 70 + 106) / 213)
exe '4resize ' . ((&lines * 25 + 27) / 54)
exe 'vert 4resize ' . ((&columns * 70 + 106) / 213)
exe 'vert 5resize ' . ((&columns * 70 + 106) / 213)
tabnext
edit ~/Research/ManifoldDestiny/script/python/polysolver.py
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
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
exe 'vert 1resize ' . ((&columns * 107 + 106) / 213)
exe 'vert 2resize ' . ((&columns * 105 + 106) / 213)
argglobal
balt term://~/Research/ManifoldDestiny/script/python//156410:bash
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 2 - ((1 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/script/python/polysolver.py", ":p")) | buffer ~/Research/ManifoldDestiny/script/python/polysolver.py | else | edit ~/Research/ManifoldDestiny/script/python/polysolver.py | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/script/python/polysolver.py
endif
balt term://~/Research/ManifoldDestiny/script/python//156410:bash
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 15 - ((14 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 107 + 106) / 213)
exe 'vert 2resize ' . ((&columns * 105 + 106) / 213)
tabnext 1
set stal=1
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
