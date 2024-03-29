if !exists("*SplitHeader")
    function! SplitHeader(header_ext, source_ext)
        " check which filetype and then open header/source in vsplit
        if (expand("%:e") == a:source_ext)
            execute "vsplit %:r.".a:header_ext
        elseif (expand("%:e") == a:header_ext)
            execute "vsplit %:r.".a:source_ext
            :exe "normal \<c-w>r"
        endif
    endfunction
endif

" navigation with % using matchit plugin
" pea pei per  missing because they push two bytes
let b:match_words = '\<ph[abdpkxy]\>:\<pl[abdpxy]\>,'
            \ . '\.\<if\>:\.\<elseif\>:\.\<else\>:\.\<endif\>,'
            \ . '\.\<proc\>:\.\<endproc\>,'
            \ . '\.\<mac(ro)?\>:\.\<endmac(ro)?\>,'
            \ . '\.\<scope\>:\.\<endscope\>,'
            \ . '\.\<enum\>:\.\<endenum\>,'
            \ . '\.\<struct\>:\.\<endstruct\>,'
            \ . '\.\<rep(eat)?\>:\.\<endrep(eat)?\>,'
            \ . '\.\<union\>:\.\<endunion\>'

setlocal commentstring=;%s
