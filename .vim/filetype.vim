
au BufNewFile,BufRead *.mayu setf nodoka
au BufNewFile,BufRead *.nodoka setf nodoka
if has("win32") 
  function! FileTypeHSP()
    compiler hsp
    set filetype=hsp
  endfunction
  au BufNewFile,BufRead *.hsp call FileTypeHSP()
  au BufNewFile,BufRead *.as call FileTypeHSP()
endif



