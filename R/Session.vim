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
badd +10 ~/InitLOT/README.md
badd +193 ~/InitLOT/config/hyprland/hyprland.conf
badd +1 ~/Research/ManifoldDestiny/_quarto.yml
badd +1 ~/InitJIH/README.md
badd +78 ~/Research/ManifoldDestiny/_variables.yml
badd +1 ~/Research/ManifoldDestiny/Session.vim
badd +1 ~/Research/ManifoldDestiny/_apps_rel.yml
badd +1 ~/Research/ManifoldDestiny/script/python/polysolver.py
badd +1 ~/Research/ManifoldDestiny/data-raw/record_static.R
badd +1 ~/Research/ManifoldDestiny/R/wasmconverting.R
badd +2 ~/Research/ManifoldDestiny/R/wasmnonverting.R
badd +1 ~/Research/ManifoldDestiny/script/R/testing.R
badd +28 term://~/Research/ManifoldDestiny/script/python//155604:bash
badd +29 ~/Research/ManifoldDestiny/prerendr.R
badd +14 term://~/Research/ManifoldDestiny/script/python//156410:bash
badd +1 ~/Research/ManifoldDestiny/shinyapps/empapp/app.R
badd +0 ~/Research/ManifoldDestiny/R/abc.R
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
exe '1resize ' . ((&lines * 18 + 28) / 57)
exe 'vert 1resize ' . ((&columns * 69 + 104) / 208)
exe '2resize ' . ((&lines * 16 + 28) / 57)
exe 'vert 2resize ' . ((&columns * 69 + 104) / 208)
exe '3resize ' . ((&lines * 18 + 28) / 57)
exe 'vert 3resize ' . ((&columns * 69 + 104) / 208)
exe '4resize ' . ((&lines * 18 + 28) / 57)
exe 'vert 4resize ' . ((&columns * 69 + 104) / 208)
exe '5resize ' . ((&lines * 17 + 28) / 57)
exe 'vert 5resize ' . ((&columns * 69 + 104) / 208)
exe '6resize ' . ((&lines * 17 + 28) / 57)
exe 'vert 6resize ' . ((&columns * 69 + 104) / 208)
exe '7resize ' . ((&lines * 38 + 28) / 57)
exe 'vert 7resize ' . ((&columns * 68 + 104) / 208)
exe '8resize ' . ((&lines * 15 + 28) / 57)
exe 'vert 8resize ' . ((&columns * 68 + 104) / 208)
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
let s:l = 7 - ((5 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 7
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
let s:l = 1 - ((0 * winheight(0) + 8) / 16)
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
let s:l = 8 - ((0 * winheight(0) + 9) / 18)
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
let s:l = 1 - ((0 * winheight(0) + 9) / 18)
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
let s:l = 2 - ((0 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
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
let s:l = 1183 - ((13 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1183
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
let s:l = 31 - ((21 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 31
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("term://~/Research/ManifoldDestiny/script/R//628693:R\ ", ":p")) | buffer term://~/Research/ManifoldDestiny/script/R//628693:R\  | else | edit term://~/Research/ManifoldDestiny/script/R//628693:R\  | endif
if &buftype ==# 'terminal'
  silent file term://~/Research/ManifoldDestiny/script/R//628693:R\ 
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
let s:l = 137 - ((14 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 137
normal! 0
wincmd w
4wincmd w
exe '1resize ' . ((&lines * 18 + 28) / 57)
exe 'vert 1resize ' . ((&columns * 69 + 104) / 208)
exe '2resize ' . ((&lines * 16 + 28) / 57)
exe 'vert 2resize ' . ((&columns * 69 + 104) / 208)
exe '3resize ' . ((&lines * 18 + 28) / 57)
exe 'vert 3resize ' . ((&columns * 69 + 104) / 208)
exe '4resize ' . ((&lines * 18 + 28) / 57)
exe 'vert 4resize ' . ((&columns * 69 + 104) / 208)
exe '5resize ' . ((&lines * 17 + 28) / 57)
exe 'vert 5resize ' . ((&columns * 69 + 104) / 208)
exe '6resize ' . ((&lines * 17 + 28) / 57)
exe 'vert 6resize ' . ((&columns * 69 + 104) / 208)
exe '7resize ' . ((&lines * 38 + 28) / 57)
exe 'vert 7resize ' . ((&columns * 68 + 104) / 208)
exe '8resize ' . ((&lines * 15 + 28) / 57)
exe 'vert 8resize ' . ((&columns * 68 + 104) / 208)
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
exe 'vert 1resize ' . ((&columns * 104 + 104) / 208)
exe 'vert 2resize ' . ((&columns * 103 + 104) / 208)
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
let s:l = 1 - ((0 * winheight(0) + 27) / 54)
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
let s:l = 1 - ((0 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 104 + 104) / 208)
exe 'vert 2resize ' . ((&columns * 103 + 104) / 208)
tabnext
edit ~/Research/ManifoldDestiny/shinyapps/empapp/app.R
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
let s:l = 1 - ((0 * winheight(0) + 27) / 54)
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
