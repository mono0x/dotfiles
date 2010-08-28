
if has("win32")
  setlocal makeprg=jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ %HOME%\jsl.conf\ -process\ %
else
  setlocal makeprg=jsl\ --nologo\ --nofilelisting\ --nosummary\ --conf=/home/mono/.jsl.conf\ %
endif
setlocal errorformat=%f(%l):\ %m

if !exists("g:javascript_flyfixquickmake")
  let g:javascript_flyfixquickmake = 1
  au BufWritePost <buffer> silent make! | redraw!
endif

