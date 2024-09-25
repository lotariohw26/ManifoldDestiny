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
badd +10 ~/InitLOT/README.md
badd +1 ~/Research/ManifoldDestiny/_quarto.yml
badd +5 term://~/Research/ManifoldDestiny//236552:bash
badd +1 ~/InitJIH/README.md
badd +78 ~/Research/ManifoldDestiny/_variables.yml
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
argglobal
%argdel
$argadd ~/InitLOT/README.md
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit ~/Research/ManifoldDestiny/_quarto.yml
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
exe '1resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 1resize ' . ((&columns * 93 + 139) / 279)
exe '2resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 2resize ' . ((&columns * 93 + 139) / 279)
exe '3resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 3resize ' . ((&columns * 93 + 139) / 279)
exe '4resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 4resize ' . ((&columns * 93 + 139) / 279)
exe '5resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 5resize ' . ((&columns * 93 + 139) / 279)
exe '6resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 6resize ' . ((&columns * 93 + 139) / 279)
exe '7resize ' . ((&lines * 49 + 34) / 68)
exe 'vert 7resize ' . ((&columns * 91 + 139) / 279)
exe '8resize ' . ((&lines * 15 + 34) / 68)
exe 'vert 8resize ' . ((&columns * 91 + 139) / 279)
argglobal
balt ~/Research/ManifoldDestiny/_apps_rel.yml
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 010|
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/_apps_rel.yml", ":p")) | buffer ~/Research/ManifoldDestiny/_apps_rel.yml | else | edit ~/Research/ManifoldDestiny/_apps_rel.yml | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/_apps_rel.yml
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
let s:l = 1 - ((0 * winheight(0) + 10) / 21)
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
let s:l = 8 - ((4 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 8
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
let s:l = 1 - ((0 * winheight(0) + 10) / 21)
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
let s:l = 1 - ((0 * winheight(0) + 10) / 21)
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
let s:l = 1 - ((0 * winheight(0) + 10) / 21)
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
let s:l = 46 - ((1 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 46
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("term://~/Research/ManifoldDestiny/script/R//236934:R\ ", ":p")) | buffer term://~/Research/ManifoldDestiny/script/R//236934:R\  | else | edit term://~/Research/ManifoldDestiny/script/R//236934:R\  | endif
if &buftype ==# 'terminal'
  silent file term://~/Research/ManifoldDestiny/script/R//236934:R\ 
endif
balt ~/Research/ManifoldDestiny/script/R/testing.R
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 21 - ((14 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 21
normal! 0
wincmd w
exe '1resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 1resize ' . ((&columns * 93 + 139) / 279)
exe '2resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 2resize ' . ((&columns * 93 + 139) / 279)
exe '3resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 3resize ' . ((&columns * 93 + 139) / 279)
exe '4resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 4resize ' . ((&columns * 93 + 139) / 279)
exe '5resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 5resize ' . ((&columns * 93 + 139) / 279)
exe '6resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 6resize ' . ((&columns * 93 + 139) / 279)
exe '7resize ' . ((&lines * 49 + 34) / 68)
exe 'vert 7resize ' . ((&columns * 91 + 139) / 279)
exe '8resize ' . ((&lines * 15 + 34) / 68)
exe 'vert 8resize ' . ((&columns * 91 + 139) / 279)
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
exe 'vert 1resize ' . ((&columns * 140 + 139) / 279)
exe 'vert 2resize ' . ((&columns * 138 + 139) / 279)
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
let s:l = 1 - ((0 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
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
let s:l = 1 - ((0 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 140 + 139) / 279)
exe 'vert 2resize ' . ((&columns * 138 + 139) / 279)
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
let s:l = 1 - ((0 * winheight(0) + 32) / 65)
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
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
