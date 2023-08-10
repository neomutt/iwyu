syn clear
%!ansifilter
%s/$//e
g/has correct/de
%s/.*should \(add\|remove\) these.*\n\ze\n
g/full include-list/norm dip
g/^\/usr\//norm dip
%!cat -s
highlight red ctermfg=red guifg=#ff0000
syn match red "should remove these lines"
highlight green ctermfg=green guifg=#00ff00
syn match green "should add these lines"
syn match cyan "\i*curses\i*"
syn match cyan "\i*ssl\i*"
syn match cyan "\i*termios\i*"
