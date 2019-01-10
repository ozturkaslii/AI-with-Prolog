% Written by Asli Öztürk, 2018-04-25

% Convert given number to turkish word.

% Turkish word equivalents of one, two, three and four-digit numbers are
% defined.
zero(0,sifir).

one_digit_num(0,'').
one_digit_num(1,bir).
one_digit_num(2,iki).
one_digit_num(3,üç).
one_digit_num(4,dört).
one_digit_num(5,bes).
one_digit_num(6,alti).
one_digit_num(7,yedi).
one_digit_num(8,sekiz).
one_digit_num(9,dokuz).

two_digit_num(0,'').
two_digit_num(1,on).
two_digit_num(2,yirmi).
two_digit_num(3,otuz).
two_digit_num(4,kirk).
two_digit_num(5,elli).
two_digit_num(6,altmis).
two_digit_num(7,yetmis).
two_digit_num(8,seksen).
two_digit_num(9,doksan).

three_digit_num(1,yüz).
three_digit_num(N,W):-
    N > 1,
    one_digit_num(N,W1),
    atom_concat(W1,yüz,W).

four_digit_num(1000,bin).

word_for_zero(N,W):-
    N is 0,
    zero(N,W).

word_for_hundred(N,W):-
    N is 100,
    three_digit_num(1,W).

word_for_one_digit(N,W):-
    N>0,
    N<10,
    one_digit_num(N,W).

word_for_two_digit(N,W):-
    N>9,
    N<100,
    Digit1 is N mod 10,
    Digit2 is (N-Digit1)/10,
    one_digit_num(Digit1,W1),
    two_digit_num(Digit2,W2),
    atom_concat(W2,W1,W).

% i.e word_for_three_digit(312,W) --> W=üçyüzoniki
word_for_three_digit(N,W):-
    N>99,
    N<1000,
    LastTwoDigit is N mod 100,
    FirstDigit is (N - LastTwoDigit) / 100,
    word_for_two_digit(LastTwoDigit,W1),
    three_digit_num(FirstDigit,W2),
    atom_concat(W2,W1,W).

% i.e word_for_three_digit(302,W) --> W=üçyüziki
word_for_three_digit(N,W):-
    N>99,
    N<1000,
    LastTwoDigit is N mod 100,
    FirstDigit is (N - LastTwoDigit) / 100,
    word_for_one_digit(LastTwoDigit,W1),
    three_digit_num(FirstDigit,W2),
    atom_concat(W2,W1,W).

word_for_four_digit(N,W):-
    N>999,
    four_digit_num(N,W).

% Conditions: N should work with [0,1,...,1000].
number_word_tr(N,_) :-
    N < 0,
    write('Number should be bigger or eqaul to 0').
number_word_tr(N,_) :-
    N > 1000,
    write('Number should be smaller or equal to 1000').

% N:Number, W:Word
% i.e number_word_tr(137,W) --> W=yüzotuzyedi
number_word_tr(N,W):-
    word_for_zero(N,W),!
    ;
    word_for_hundred(N,W),!
    ;
    word_for_one_digit(N,W),!
    ;
    word_for_two_digit(N,W),!
    ;
    word_for_three_digit(N,W),!
    ;
    word_for_four_digit(N,W).
