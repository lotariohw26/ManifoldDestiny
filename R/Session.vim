let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Research/ManifoldDestiny/R
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
badd +32 ~/Research/ManifoldDestiny/_quarto.yml
badd +1 ~/InitJIH/config/hyprland/hyprland.conf
badd +10 ~/InitLOT/README.md
badd +2 ~/InitLOT/config/hyprland/hyprland.conf
badd +3 term://~/Research/ManifoldDestiny//2762442:bash
badd +5 term://~/Research/ManifoldDestiny//236552:bash
badd +78 ~/Research/ManifoldDestiny/_variables.yml
badd +1 ~/Research/ManifoldDestiny/Session.vim
badd +1 ~/Research/ManifoldDestiny/_apps_rel.yml
badd +1 ~/Research/ManifoldDestiny/script/python/polysolver.py
badd +1 ~/Research/ManifoldDestiny/data-raw/record_static.R
badd +308 ~/Research/ManifoldDestiny/R/wasmconverting.R
badd +1 ~/Research/ManifoldDestiny/R/wasmnonverting.R
badd +22 ~/Research/ManifoldDestiny/script/R/testing.R
badd +28 term://~/Research/ManifoldDestiny/script/python//155604:bash
badd +1 ~/Research/ManifoldDestiny/prerendr.R
badd +14 term://~/Research/ManifoldDestiny/script/python//156410:bash
badd +1 ~/Research/ManifoldDestiny/shinyapps/empapp/app.R
badd +8 ~/Research/ManifoldDestiny/randpython.qmd
badd +3 term://~/Research/ManifoldDestiny//2389623:bash
badd +38 ~/Research/ManifoldDestiny/script/R/complexregression.R
badd +1 ~/Research/ManifoldDestiny/R/abc.R
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
badd +19 term://~/Research/ManifoldDestiny/R//2808552:R\ 
badd +81 ~/Research/ManifoldDestiny/presentation.qmd
badd +1 ~/Research/ManifoldDestiny/tabset.qmd
badd +3 ~/Research/ManifoldDestiny/tab.qmd
badd +228 term://~/Research/ManifoldDestiny//722227:bash
badd +1 ~/InitLOT/config/nvim/keymapping.vim
badd +25 term://~/Research/ManifoldDestiny//1298434:bash
badd +24 ~/Research/ManifoldDestiny/_apps_sim.yml
badd +66 term://~/Research/ManifoldDestiny//1335872:R\ 
badd +3 term://~/Research/ManifoldDestiny/data-raw//830421:bash
badd +1192 term://~/Research/ManifoldDestiny//842018:bash
badd +1 term://~/Research/ManifoldDestiny/data-raw//712675:bash
badd +12 ~/Research/ManifoldDestiny/paper.qmd
badd +1 ~/Research/ManifoldDestiny/metaview.qmd
badd +1 ~/Research/ManifoldDestiny/man_bib.qmd
badd +1093 term://~/Research/ManifoldDestiny//870859:bash
badd +136 term://~/Research/ManifoldDestiny//875543:bash
badd +1 term://~/Research/ManifoldDestiny/data-raw//882834:bash
badd +4 term://~/Research/ManifoldDestiny//504189:bash
badd +9 ~/Research/Hyperinflation/_quarto.yml
badd +33 ~/Research/Hyperinflation/prerender.R
badd +0 term://~/Research/ManifoldDestiny//536481:bash
argglobal
%argdel
$argadd ~/InitLOT/README.md
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit ~/Research/ManifoldDestiny/tab.qmd
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
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
exe '1resize ' . ((&lines * 25 + 27) / 54)
exe '2resize ' . ((&lines * 25 + 27) / 54)
argglobal
balt term://~/Research/ManifoldDestiny//536481:bash
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 10 - ((8 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 10
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("term://~/Research/ManifoldDestiny//536481:bash", ":p")) | buffer term://~/Research/ManifoldDestiny//536481:bash | else | edit term://~/Research/ManifoldDestiny//536481:bash | endif
if &buftype ==# 'terminal'
  silent file term://~/Research/ManifoldDestiny//536481:bash
endif
balt ~/Research/ManifoldDestiny/tab.qmd
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 3 - ((2 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3
normal! 040|
wincmd w
exe '1resize ' . ((&lines * 25 + 27) / 54)
exe '2resize ' . ((&lines * 25 + 27) / 54)
tabnext
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
wincmd _ | wincmd |
split
3wincmd k
wincmd w
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
exe '1resize ' . ((&lines * 12 + 27) / 54)
exe 'vert 1resize ' . ((&columns * 70 + 106) / 213)
exe '2resize ' . ((&lines * 12 + 27) / 54)
exe 'vert 2resize ' . ((&columns * 70 + 106) / 213)
exe '3resize ' . ((&lines * 12 + 27) / 54)
exe 'vert 3resize ' . ((&columns * 70 + 106) / 213)
exe '4resize ' . ((&lines * 12 + 27) / 54)
exe 'vert 4resize ' . ((&columns * 70 + 106) / 213)
exe '5resize ' . ((&lines * 16 + 27) / 54)
exe 'vert 5resize ' . ((&columns * 71 + 106) / 213)
exe '6resize ' . ((&lines * 17 + 27) / 54)
exe 'vert 6resize ' . ((&columns * 71 + 106) / 213)
exe '7resize ' . ((&lines * 16 + 27) / 54)
exe 'vert 7resize ' . ((&columns * 71 + 106) / 213)
exe '8resize ' . ((&lines * 35 + 27) / 54)
exe 'vert 8resize ' . ((&columns * 70 + 106) / 213)
exe '9resize ' . ((&lines * 15 + 27) / 54)
exe 'vert 9resize ' . ((&columns * 70 + 106) / 213)
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
let s:l = 62 - ((2 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 62
normal! 0
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
let s:l = 14 - ((3 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 14
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/data-raw/record_static.R", ":p")) | buffer ~/Research/ManifoldDestiny/data-raw/record_static.R | else | edit ~/Research/ManifoldDestiny/data-raw/record_static.R | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/data-raw/record_static.R
endif
balt term://~/Research/ManifoldDestiny/data-raw//882834:bash
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 14 - ((0 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 14
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("term://~/Research/ManifoldDestiny/data-raw//882834:bash", ":p")) | buffer term://~/Research/ManifoldDestiny/data-raw//882834:bash | else | edit term://~/Research/ManifoldDestiny/data-raw//882834:bash | endif
if &buftype ==# 'terminal'
  silent file term://~/Research/ManifoldDestiny/data-raw//882834:bash
endif
balt ~/Research/ManifoldDestiny/data-raw/record_static.R
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 3 - ((0 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/Research/ManifoldDestiny/R/wasmnonverting.R", ":p")) | buffer ~/Research/ManifoldDestiny/R/wasmnonverting.R | else | edit ~/Research/ManifoldDestiny/R/wasmnonverting.R | endif
if &buftype ==# 'terminal'
  silent file ~/Research/ManifoldDestiny/R/wasmnonverting.R
endif
balt ~/Research/ManifoldDestiny/R/wasmconverting.R
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 8) / 16)
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
let s:l = 276 - ((7 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 276
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
let s:l = 309 - ((3 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 309
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
let s:l = 25 - ((19 * winheight(0) + 17) / 35)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 25
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("term://~/Research/ManifoldDestiny/script/R//548324:R\ ", ":p")) | buffer term://~/Research/ManifoldDestiny/script/R//548324:R\  | else | edit term://~/Research/ManifoldDestiny/script/R//548324:R\  | endif
if &buftype ==# 'terminal'
  silent file term://~/Research/ManifoldDestiny/script/R//548324:R\ 
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
let s:l = 133 - ((14 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 133
normal! 0
wincmd w
6wincmd w
exe '1resize ' . ((&lines * 12 + 27) / 54)
exe 'vert 1resize ' . ((&columns * 70 + 106) / 213)
exe '2resize ' . ((&lines * 12 + 27) / 54)
exe 'vert 2resize ' . ((&columns * 70 + 106) / 213)
exe '3resize ' . ((&lines * 12 + 27) / 54)
exe 'vert 3resize ' . ((&columns * 70 + 106) / 213)
exe '4resize ' . ((&lines * 12 + 27) / 54)
exe 'vert 4resize ' . ((&columns * 70 + 106) / 213)
exe '5resize ' . ((&lines * 16 + 27) / 54)
exe 'vert 5resize ' . ((&columns * 71 + 106) / 213)
exe '6resize ' . ((&lines * 17 + 27) / 54)
exe 'vert 6resize ' . ((&columns * 71 + 106) / 213)
exe '7resize ' . ((&lines * 16 + 27) / 54)
exe 'vert 7resize ' . ((&columns * 71 + 106) / 213)
exe '8resize ' . ((&lines * 35 + 27) / 54)
exe 'vert 8resize ' . ((&columns * 70 + 106) / 213)
exe '9resize ' . ((&lines * 15 + 27) / 54)
exe 'vert 9resize ' . ((&columns * 70 + 106) / 213)
tabnext
edit ~/Research/ManifoldDestiny/presentation.qmd
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
let s:l = 19 - ((14 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 19
normal! 0
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
exe 'vert 1resize ' . ((&columns * 106 + 106) / 213)
exe 'vert 2resize ' . ((&columns * 106 + 106) / 213)
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
let s:l = 1 - ((0 * winheight(0) + 25) / 51)
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
let s:l = 1 - ((0 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 106 + 106) / 213)
exe 'vert 2resize ' . ((&columns * 106 + 106) / 213)
tabnext
edit ~/Research/ManifoldDestiny/_quarto.yml
argglobal
balt ~/Research/ManifoldDestiny/R/wasmconverting.R
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
tabnext 2
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
