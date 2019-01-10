% Written by Asli Öztürk, 2018-04-25

% We need to get the turkish word and specify which kind of vowel is
% presented. Plural suffix will change according to vowel type.
is_vowel(X):-
    member(X,[a,e,i,i,o,ö,u,ü]).

back_vowel(X):-
    member(X,[a,i,o,u]),!.

front_vowel(X):-
    member(X,[e,i,ö,ü]),!.

del(X,[X|T],T).
del(X,[Y|T],[Y|T1]):-
       del(X,T,T1).

last_member(L,X):-
    reverse(L,[X|_]).


% The method to convert word to list.
% i.e convert_string_to_list(kitap,L) --> L=[k,i,t,a,p]
% W: Word, L:List
convert_string_to_list(W,L) :-
    name(W,List),
    maplist(number_to_char,List,L).

% N:Number, C:Character
number_to_char(N,C) :-
    name(C,[N]).

% Recursive call will be performed until the vowel in the word is found.
% L:List
get_last_vowel(L,X):-
     last_member(L,X),
     is_vowel(X),!.

get_last_vowel(L,Y):-
    last_member(L,X),
    del(X,L,NL),
    get_last_vowel(NL,Y).


last_vowel(W,X):-
    convert_string_to_list(W,L),
    get_last_vowel(L,X).

% Some turkish words don't follow the specified rules, so we need to
% define them.
exceptional_words(saat,saatler).

% Make turkish word plural method.
% i.e plural_turkish(kitap,Plural) --> Plural=kitaplar
% W:Word
plural_turkish(W,Plural):-
    exceptional_words(W,Plural),!
    ;
    last_vowel(W,X),
    front_vowel(X),
    atom_concat(W,ler,Plural),!.

plural_turkish(W,Plural):-
    last_vowel(W,X),
    back_vowel(X),
    atom_concat(W,lar,Plural),!.
