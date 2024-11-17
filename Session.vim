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
badd +29 ~/InitJIH/README.md
badd +1 ~/Teaching/SFB30820Finansteori/_quarto.yml
badd +53 ~/Teaching/SFB30820Finansteori/index.qmd
badd +3 term://~/Teaching/SFB30820Finansteori//1737278:bash
badd +3 term://~/Teaching/SFB30820Finansteori//1770034:bash
badd +13 term://~/Teaching/SFB30820Finansteori//1770703:bash
badd +6 ~/Research/ManifoldDestiny/_quarto.yml
badd +1 ~/Research/ManifoldDestiny/R/wasmconverting.R
badd +28 ~/Research/ManifoldDestiny/script/R/testing.R
badd +76 ~/HomepageJIH/_quarto.yml
badd +20 ~/Research/ManifoldDestiny/data-raw/datatraf.R
badd +17 ~/Research/ManifoldDestiny/data-raw/abc.R
badd +211 ~/Research/ManifoldDestiny/inst/shinyapps/manimp/app.R
badd +0 ~/Research/ManifoldDestiny/prerendr.R
argglobal
%argdel
$argadd ~/InitJIH/README.md
set stal=2
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
1wincmd k
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
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 32 + 34) / 68)
exe 'vert 1resize ' . ((&columns * 92 + 139) / 279)
exe '2resize ' . ((&lines * 32 + 34) / 68)
exe 'vert 2resize ' . ((&columns * 92 + 139) / 279)
exe 'vert 3resize ' . ((&columns * 92 + 139) / 279)
exe '4resize ' . ((&lines * 32 + 34) / 68)
exe 'vert 4resize ' . ((&columns * 93 + 139) / 279)
exe '5resize ' . ((&lines * 16 + 34) / 68)
exe 'vert 5resize ' . ((&columns * 93 + 139) / 279)
exe '6resize ' . ((&lines * 15 + 34) / 68)
exe 'vert 6resize ' . ((&columns * 93 + 139) / 279)
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
let s:l = 5 - ((4 * winheight(0) + 16) / 32)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
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
let s:l = 272 - ((7 * winheight(0) + 16) / 32)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 272
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
let s:l = 30 - ((29 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 30
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
let s:l = 884 - ((9 * winheight(0) + 16) / 32)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 884
normal! 03|
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
let s:l = 28 - ((6 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 28
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("term://~/Research/ManifoldDestiny/script/R//1963168:R\ ", ":p")) | buffer term://~/Research/ManifoldDestiny/script/R//1963168:R\  | else | edit term://~/Research/ManifoldDestiny/script/R//1963168:R\  | endif
if &buftype ==# 'terminal'
  silent file term://~/Research/ManifoldDestiny/script/R//1963168:R\ 
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
let s:l = 193 - ((14 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 193
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 32 + 34) / 68)
exe 'vert 1resize ' . ((&columns * 92 + 139) / 279)
exe '2resize ' . ((&lines * 32 + 34) / 68)
exe 'vert 2resize ' . ((&columns * 92 + 139) / 279)
exe 'vert 3resize ' . ((&columns * 92 + 139) / 279)
exe '4resize ' . ((&lines * 32 + 34) / 68)
exe 'vert 4resize ' . ((&columns * 93 + 139) / 279)
exe '5resize ' . ((&lines * 16 + 34) / 68)
exe 'vert 5resize ' . ((&columns * 93 + 139) / 279)
exe '6resize ' . ((&lines * 15 + 34) / 68)
exe 'vert 6resize ' . ((&columns * 93 + 139) / 279)
tabnext
edit ~/InitJIH/README.md
argglobal
balt ~/HomepageJIH/_quarto.yml
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 31 - ((30 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 31
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
