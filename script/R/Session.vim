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
badd +7 ~/Research/ManifoldDestiny/_quarto.yml
badd +3 term://~/Research/ManifoldDestiny//2762442:bash
badd +5 term://~/Research/ManifoldDestiny//236552:bash
badd +1 ~/InitJIH/README.md
badd +78 ~/Research/ManifoldDestiny/_variables.yml
badd +1 ~/Research/ManifoldDestiny/Session.vim
badd +1 ~/Research/ManifoldDestiny/_apps_rel.yml
badd +1 ~/Research/ManifoldDestiny/script/python/polysolver.py
badd +1 ~/Research/ManifoldDestiny/data-raw/record_static.R
badd +1161 ~/Research/ManifoldDestiny/R/wasmconverting.R
badd +1 ~/Research/ManifoldDestiny/R/wasmnonverting.R
badd +36 ~/Research/ManifoldDestiny/script/R/testing.R
badd +28 term://~/Research/ManifoldDestiny/script/python//155604:bash
badd +29 ~/Research/ManifoldDestiny/prerendr.R
badd +14 term://~/Research/ManifoldDestiny/script/python//156410:bash
badd +1 ~/Research/ManifoldDestiny/shinyapps/empapp/app.R
badd +8 ~/Research/ManifoldDestiny/randpython.qmd
badd +3 term://~/Research/ManifoldDestiny//2389623:bash
badd +38 ~/Research/ManifoldDestiny/script/R/complexregression.R
badd +56 ~/Research/ManifoldDestiny/R/abc.R
badd +17 ~/Research/ManifoldDestiny/addendum/Addendum_az.qmd
badd +1 ~/Research/ManifoldDestiny/index.qmd
badd +8 term://~/Research/ManifoldDestiny//2434328:bash
badd +14 term://~/Research/ManifoldDestiny//2435063:bash
badd +37 term://~/Research/ManifoldDestiny//2488155:bash
badd +225 term://~/Research/ManifoldDestiny//2489360:bash
badd +3 term://~/Research/ManifoldDestiny//2499133:bash
badd +81 term://~/Research/ManifoldDestiny//2499904:bash
badd +9 term://~/Research/ManifoldDestiny//2500377:bash
badd +11 term://~/Research/ManifoldDestiny//2500949:bash
badd +14 term://~/Research/ManifoldDestiny//2501569:bash
badd +22 ~/Research/ManifoldDestiny/calculator.qmd
badd +1 ~/Research/ManifoldDestiny/script/python/abc.py
badd +1 ~/HomepageJIH/abc.py
badd +0 term://~/Research/ManifoldDestiny/script/python//252095:python3
badd +2 ~/Research/ManifoldDestiny/inst/shinyapps/r2rsim/app.R
badd +1 ~/Research/ManifoldDestiny/inst/shinyapps/manimp/app.R
badd +1 ~/Research/ManifoldDestiny/inst/shinyapps/empapp/app.R
badd +1 ~/Research/ManifoldDestiny/inst/shinyapps/restor/app.R
badd +17 ~/Research/ManifoldDestiny/.git/config
argglobal
%argdel
$argadd ~/InitLOT/README.md
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
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
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
wincmd w
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
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
exe '1resize ' . ((&lines * 40 + 62) / 124)
exe 'vert 1resize ' . ((&columns * 52 + 77) / 155)
exe '2resize ' . ((&lines * 39 + 62) / 124)
exe 'vert 2resize ' . ((&columns * 52 + 77) / 155)
exe '3resize ' . ((&lines * 40 + 62) / 124)
exe 'vert 3resize ' . ((&columns * 52 + 77) / 155)
exe '4resize ' . ((&lines * 38 + 62) / 124)
exe 'vert 4resize ' . ((&columns * 50 + 77) / 155)
exe '5resize ' . ((&lines * 43 + 62) / 124)
exe 'vert 5resize ' . ((&columns * 50 + 77) / 155)
exe '6resize ' . ((&lines * 38 + 62) / 124)
exe 'vert 6resize ' . ((&columns * 50 + 77) / 155)
exe '7resize ' . ((&lines * 60 + 62) / 124)
exe 'vert 7resize ' . ((&columns * 51 + 77) / 155)
exe '8resize ' . ((&lines * 60 + 62) / 124)
exe 'vert 8resize ' . ((&columns * 51 + 77) / 155)
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
let s:l = 2 - ((1 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
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
let s:l = 1 - ((0 * winheight(0) + 19) / 39)
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
let s:l = 3 - ((0 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/R/abc.R", ":p")) | buffer ~/Research/ManifoldDestiny/R/abc.R | else | edit ~/Research/ManifoldDestiny/R/abc.R | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/R/abc.R
endif
balt ~/Research/ManifoldDestiny/R/wasmnonverting.R
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 19) / 38)
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
let s:l = 1 - ((0 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/R/wasmconverting.R", ":p")) | buffer ~/Research/ManifoldDestiny/R/wasmconverting.R | else | edit ~/Research/ManifoldDestiny/R/wasmconverting.R | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/R/wasmconverting.R
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
let s:l = 1106 - ((15 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1106
normal! 05|
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/R/wasmconverting.R", ":p")) | buffer ~/Research/ManifoldDestiny/R/wasmconverting.R | else | edit ~/Research/ManifoldDestiny/R/wasmconverting.R | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/R/wasmconverting.R
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
let s:l = 260 - ((23 * winheight(0) + 30) / 60)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 260
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
let s:l = 31 - ((12 * winheight(0) + 30) / 60)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 31
normal! 0
wincmd w
8wincmd w
exe '1resize ' . ((&lines * 40 + 62) / 124)
exe 'vert 1resize ' . ((&columns * 52 + 77) / 155)
exe '2resize ' . ((&lines * 39 + 62) / 124)
exe 'vert 2resize ' . ((&columns * 52 + 77) / 155)
exe '3resize ' . ((&lines * 40 + 62) / 124)
exe 'vert 3resize ' . ((&columns * 52 + 77) / 155)
exe '4resize ' . ((&lines * 38 + 62) / 124)
exe 'vert 4resize ' . ((&columns * 50 + 77) / 155)
exe '5resize ' . ((&lines * 43 + 62) / 124)
exe 'vert 5resize ' . ((&columns * 50 + 77) / 155)
exe '6resize ' . ((&lines * 38 + 62) / 124)
exe 'vert 6resize ' . ((&columns * 50 + 77) / 155)
exe '7resize ' . ((&lines * 60 + 62) / 124)
exe 'vert 7resize ' . ((&columns * 51 + 77) / 155)
exe '8resize ' . ((&lines * 60 + 62) / 124)
exe 'vert 8resize ' . ((&columns * 51 + 77) / 155)
tabnext
edit ~/Research/ManifoldDestiny/script/python/polysolver.py
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
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
exe 'vert 1resize ' . ((&columns * 77 + 77) / 155)
exe '2resize ' . ((&lines * 105 + 62) / 124)
exe 'vert 2resize ' . ((&columns * 77 + 77) / 155)
exe '3resize ' . ((&lines * 15 + 62) / 124)
exe 'vert 3resize ' . ((&columns * 77 + 77) / 155)
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
let s:l = 2 - ((1 * winheight(0) + 60) / 121)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/script/python/abc.py", ":p")) | buffer ~/Research/ManifoldDestiny/script/python/abc.py | else | edit ~/Research/ManifoldDestiny/script/python/abc.py | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/script/python/abc.py
endif
balt ~/Research/ManifoldDestiny/script/python/polysolver.py
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 72 - ((43 * winheight(0) + 52) / 105)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 72
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("term://~/Research/ManifoldDestiny/script/python//252095:python3", ":p")) | buffer term://~/Research/ManifoldDestiny/script/python//252095:python3 | else | edit term://~/Research/ManifoldDestiny/script/python//252095:python3 | endif
if &buftype ==# 'terminal'
  silent file term://~/Research/ManifoldDestiny/script/python//252095:python3
endif
balt ~/Research/ManifoldDestiny/script/python/abc.py
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 182 - ((14 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 182
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 77 + 77) / 155)
exe '2resize ' . ((&lines * 105 + 62) / 124)
exe 'vert 2resize ' . ((&columns * 77 + 77) / 155)
exe '3resize ' . ((&lines * 15 + 62) / 124)
exe 'vert 3resize ' . ((&columns * 77 + 77) / 155)
tabnext
edit ~/Research/ManifoldDestiny/_apps_rel.yml
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
let s:l = 1 - ((0 * winheight(0) + 60) / 121)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit ~/Research/ManifoldDestiny/inst/shinyapps/r2rsim/app.R
argglobal
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 60) / 121)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext 1
set stal=1
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
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
