line(0):- nl.
line(X):-
    X>0,
    write('*'),
    NL is X-1,
    line(NL).


line2(0):-nl.
line2(X):-X>0,
    write('*'),
    A is 0,
    line2(A),
    NL is X-1,
    line2(NL).


triangle(0):-nl.
triangle(T):-
    T>0,
    NT is T-1,
    triangle(NT),
    line(T).

reversetriangle(0).
reversetriangle(T):-
    T>0,
    line(T),
    NT is T-1,
    reversetriangle(NT).



