syn clear
%!ansifilter
%s/$//e
%s/\s\+$//e
g/has correct/de
%s/.*should \(add\|remove\) these.*\n\ze\n//e
g/full include-list/norm dip
g/^\/usr\//norm dip
g/^gui\/mutt_curses\.h/norm dip
g/\v^Script (started|done)/de
g/ iwyu\.sh /de
g/^compile_commands.json/de
g/^exit/de
g/^error: no input files/de
g/^error: no such file or directory:/de
g/^error: unable to handle compilation,/de
%!cat -s
highlight red ctermfg=red guifg=#ff0000
syn match red "should remove these lines"
highlight green ctermfg=green guifg=#00ff00
syn match green "should add these lines"
syn match cyan "\i*curses\i*"
syn match cyan "\i*ssl\i*"
syn match cyan "\i*termios\i*"
