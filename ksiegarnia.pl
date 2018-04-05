:- dynamic lubi/1.
:- dynamic nielubi/1.
:- dynamic punkty/2.
:- dynamic koniec/1.
:- dynamic wybrana/2.
:-(clause(cechy(_,_),_); consult('baza.pl')).  

start:-
	write('Witaj w aplikacji rekomenduj�cej ksi��ki, opowiedz mi co� o swoich preferencjach.'), nl,
	write('Je�eli lubisz dan� cech� ksi��ki napisz "t", je�eli nie lubisz napisz "n",'), nl,
	write('je�eli jest ci to oboj�tne napisz "o", a je�eli znudzi ci si� odpowiadanie na'), nl,
	write('pytania wybierz k. W momencie zakoczenia odpowiadania na pytania wy�wietlona zostanie'),nl,
	write('ksi��ka kt�ra z pewno�ci� spe�ni twoje oczekiwania.'),nl,
	write('----------------------------------------------------------------------------'),nl,
	jaka_ksiazka.
start:-
	wypisz_co_lubi.
start:-
	nl, wypisz_co_nie_lubi.
start:-
	funkcja_init.
start:-
	funkcja_licznik1.
start:-
	funkcja_licznik2.
start:-
	nl,funkcja_wypisz_pkt.
start:-
	funkcja_init_2.
start:-
	nl,wybierz_najlepsza.
start:-
	nl,wypisz_najlepsza.


	
jaka_ksiazka:-					
	cechy(X,Y),					%sprawdza cechy 
	not(koniec(tak)),			%jezeli koniec to nie pojdzie dalej
	write('Czy lubisz '), write(Y), write('?'), nl,
	read(Odp),
	decyzja(Odp, X),
	nl, fail.

decyzja('t', X):-
	assertz(lubi(X)).
	
decyzja('n', X):-
	assertz(nielubi(X)).
	
decyzja('k', _):-
	assertz(koniec(tak)).
	
wypisz_co_lubi:-
	write('A wi�c lubisz:'),nl,
	lubi(X),
	write(X),
	nl,
	fail.
	
wypisz_co_nie_lubi:-
	write('Oraz nie lubisz:'),nl,
	nielubi(X),
	write(X),
	nl,
	fail.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	

funkcja_init:-
	cecha(Tytul, X),
	not(punkty(Tytul, _)),
	assertz(punkty(Tytul, 4)),
	fail.
	
funkcja_licznik1:-
	cecha(Tytul, X),
	lubi(X),
	punkty(Tytul, Pkt),
	Pkt_nowe is Pkt + 1,
	retract(punkty(Tytul, Pkt)),
	assertz(punkty(Tytul, Pkt_nowe)),
	fail.
	
funkcja_licznik2:-
	cecha(Tytul, X),
	nielubi(X),
	punkty(Tytul, Pkt),
	Pkt_nowe is Pkt - 1,
	retract(punkty(Tytul, Pkt)),
	assertz(punkty(Tytul, Pkt_nowe)),
	fail.
	
funkcja_wypisz_pkt:-
	punkty(Tytul, Pkt),
	write(Tytul), write(' '), write(Pkt), nl,
	fail.
	
funkcja_init_2:-
	punkty(wiedzmin, Pkt),
	assertz(wybrana(wiedzmin, Pkt)),
	fail.

wybierz_najlepsza:-
	punkty(Tytul, Pkt),
	wybrana(X, P),
	Pkt > P,
	retract(wybrana(X, P)),
	assertz(wybrana(Tytul, Pkt)),
	fail.
	
	
wypisz_najlepsza:-
	wybrana(X, Pkt),
	ksiazka(X, Nazwa),
	write('Powiniene� przeczyta� '),
	write(Nazwa), write(', ksi��ka/seria ta zdoby�a '), write(Pkt),
	Procent is (Pkt*100)/14,
	write(' punkt�w. Na '), write(Procent), write('% Ci si� spodoba!'),
	nl,nl, halt.
	
	
	% swipl --goal=start --stand_alone=true -o ksiegarnia.exe -c ksiegarnia.pl
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	