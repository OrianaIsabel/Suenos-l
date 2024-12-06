% Aquí va el código.
cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, reyesMagos).
cree(macarena, magoCapria).
cree(macarena, campanita).

quiere(gabriel, ganarLoteria([5,9])).
quiere(gabriel, futbolista(arsenal)).
quiere(juan, cantante(100000)).
quiere(macarena, cantante(10000)).

% Punto 2

esChico(arsenal).
esChico(aldosivi).

queTanDificil(cantante(Vendidos), 6):-
    Vendidos > 500000.

queTanDificil(cantante(Vendidos), 4):-
    not(queTanDificil(cantante(Vendidos), 6)).

queTanDificil(ganarLoteria(Numeros), Dificultad):-
    length(Numeros, Cantidad),
    Dificultad is Cantidad * 10.

queTanDificil(futbolista(Equipo), 3):-
    esChico(Equipo).

queTanDificil(futbolista(Equipo), 16):-
    not(queTanDificil(futbolista(Equipo), 3)).

dificultad(Sueno, Dificultad):-
    quiere(_, Sueno),
    queTanDificil(Sueno, Dificultad).

dificultadTotal(Persona, DificultadTotal):-
    findall(Dificultad, (quiere(Persona, Sueno), dificultad(Sueno, Dificultad)), ListaDificultad),
    sumlist(ListaDificultad, DificultadTotal).

esAmbisioso(Persona):-
    quiere(Persona,_),
    dificultadTotal(Persona, DificultadTotal),
    DificultadTotal > 20.

% Punto 3

esPuro(futbolista(_)).

esPuro(cantante(Vendidos)):-
    Vendidos < 200000.

tienenQuimica(campanita, Persona):-
    cree(Persona, campanita),
    quiere(Persona, Sueno),
    dificultad(Sueno, Dificultad),
    Dificultad < 5.

tienenQuimica(Personaje, Persona):-
    Personaje \= campanita,
    cree(Persona, Personaje),
    forall(quiere(Persona, Sueno), esPuro(Sueno)),
    not(esAmbisioso(Persona)).

% Punto 4

amigo(campanita, reyesMagos).
amigo(campanita, conejoDePascua).
amigo(conejoDePascua, cavenaghi).

enfermo(campanita).
enfermo(conejoDePascua).
enfermo(reyesMagos).

backup(Personaje, Backup):-
    amigo(Personaje, Backup).

backup(Personaje, Backup):-
    amigo(Otro, Backup),
    backup(Personaje, Otro).

tieneBackupSano(Personaje):-
    backup(Personaje, Backup),
    not(enfermo(Backup)).

estaDispuesto(Personaje):-
    not(enfermo(Personaje)).

estaDispuesto(Personaje):-
    tieneBackupSano(Personaje).

podriaAlegrarlo(Personaje, Persona):-
    tienenQuimica(Personaje, Persona),
    estaDispuesto(Personaje).

loAlegra(Personaje, Persona):-
    cree(_, Personaje),
    quiere(Persona,_),
    podriaAlegrarlo(Personaje, Persona).
