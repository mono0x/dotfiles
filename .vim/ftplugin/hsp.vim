" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" Language: HSP
" Maintainer: Gonbei
" Last Modified: 2007/06/03-15:55.
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" prevent duplicate include
if exists( "b:did_ftplugin" )
  finish
endif
let b:did_ftplugin = 1

" document library
nnoremap <silent><buffer> K :<C-u>call vimproc#system('~/bin/hsp3/hdl.exe ' . expand('<cword>'))<CR>
vnoremap <silent><buffer> K :<C-u>call vimproc#system('~/bin/hsp3/hdl.exe ' . expand('<cword>'))<CR>

set cpo-=C

setlocal cindent

setlocal fo-=t fo+=croql

if exists( "g:HspUseDoubleSlashIndent" )
  setlocal comments=sr:/*,mb:*,ex:*/,:;,://
else
  setlocal comments=sr:/*,mb:*,ex:*/,:;
endif

if exists("&completefunc")
  setlocal completefunc=hspcomplete#Complete
endif

" set include path
set include=^\\s*#\\s*\\(include\\\\|addition\\)

" set filter for file browser dialog
if has( "gui_win32" ) 
  let b:browsefilter = "HSP3 Script File (*.hsp)\t*.hsp\n".
        \ "HSP2 Script file (*.as)\t*.hsp\n".  
        \ "All Files (*.*)\t*.*\n"

" let vim open HSP2 files. But maybe Syntax and Indent CAN'T work exactly
endif
