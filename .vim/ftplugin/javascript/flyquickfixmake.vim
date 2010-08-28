
setlocal makeprg=jsl\ --nologo\ --nofilelisting\ --nosummary\ --conf=/home/mono/.jsl.conf\ %
setlocal errorformat=%f(%l):\ %m

if !exists("g:javascript_flyfixquickmake")
  let g:javascript_flyfixquickmake = 1
  au BufWritePost <buffer> silent make! | redraw!
endif

