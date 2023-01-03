"set foldmethod=marker
"set foldcolumn=4
"set foldlevel=0

"set foldtext=MyFoldText()
"function MyFoldText()
    "let line = getline(v:foldstart)
    "let sub = substitute(line, ';\|{{{\d\=', '', 'g')
    "return v:folddashes . sub
"endfunction
