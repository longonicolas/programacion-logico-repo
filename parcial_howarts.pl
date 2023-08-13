
caracteristica(harry,coraje).
caracteristica(harry,amistad).
caracteristica(harry,orgullo).
caracteristica(harry,inteligencia).


caracteristica(draco,inteligencia).
caracteristica(draco,orgullo).

caracteristica(hermione,inteligencia).
caracteristica(hermione,orgullo).
caracteristica(hermione,responsabilidad).
caracteristica(hermione,amistad).


sangre(harry,mestiza).
sangre(draco,pura).
sangre(hermione,impura).

casa(slytherin,orgullo).
casa(slytherin,inteligencia).
casa(hufflepuff,amistad).
casa(gryffindor,coraje).
casa(ravenclaw,inteligencia).
casa(ravenclaw,responsabilidad).

odia(harry,slytherin).
odia(draco,hufflepuff).

% PUNTO 1

permiteEntrarALaCasa(UnMago,Casa):-
    sangre(UnMago,_),
    casa(Casa,_),
    Casa \= slytherin.

permiteEntrarALaCasa(UnMago,slytherin):-
    sangre(UnMago,Sangre),
    Sangre \= impura.

% PUNTO 2

esAptoCasa(UnMago,Casa):-
    casa(Casa,_),
    sangre(UnMago,_),
    forall(casa(Casa,Caracteristica),caracteristica(UnMago,Caracteristica)).

% PUNTO 3

asignarCasa(UnMago,Casa):-
    permiteEntrarALaCasa(UnMago,Casa),
    esAptoCasa(UnMago,Casa),
    not(odia(UnMago,Casa)).

asignarCasa(hermione,gryffindor).

% PUNTO 4

esAmistoso(UnMago):-
    caracteristica(UnMago,amistad).

magosAmistosos(Magos):-
    findall(UnMago,esAmistoso(UnMago),Magos).

/* Otra forma para magosAmistosos
magosAmistosos(Magos):-
    forall(member(UnMago,Magos),esAmistoso(UnMago)).*/

cadenaDeAmistades(Magos):-
    magosAmistosos(Magos),
    cadenaDeCasas(Magos).

cadenaDeCasas(Magos):-
    forall(elementosConsecutivos(Mago1,Mago2,Magos),
            (asignarCasa(Mago1,Casa),
             asignarCasa(Mago2,Casa))).

elementosConsecutivos(Anterior,Siguiente,Lista):-
    nth1(IndiceAnterior, Lista, Anterior),
    IndiceSiguiente is IndiceAnterior + 1,
    nth1(IndiceSiguiente,Lista,Siguiente).
    
    
% PARTE B

% PUNTO 1

accion(irA(bosque),-50).
accion(irA(seccionBiblioteca),-10).
accion(irA(tercerPiso),-75).
accion(andarFueraDeLaCama,-50).
accion(irA(mazmorra),0).

accion(ganarAjedrez,50).
accion(usarIntelecto,50).
accion(vencerAVoldemort,60).

irA(bosque).
irA(tercerPiso).
irA(seccionBiblioteca).
irA(mazmorra).

lugaresProhibidos([bosque,tercerPiso,seccionBiblioteca]).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

hizo(harry,andarFueraDeLaCama).
hizo(harry,irA(bosque)).
hizo(harry,irA(tercerPiso)).
hizo(harry,vencerAVoldemort).
hizo(hermione,irA(tercerPiso)).
hizo(hermione,irA(seccionBiblioteca)).
hizo(hermione,usarIntelecto).
hizo(draco,irA(mazmorra)).
hizo(draco,ganarAjedrez).
hizo(ron,ganarAjedrez).

esAccionProhibida(Accion):-
    accion(Accion,Puntaje),
    Puntaje < 0.

accionProhibida(Lugar):-
    irA(Lugar),
    forall(lugaresProhibidos(Lugares),not(member(Lugar,Lugares))).

esBuenAlumno(UnMago):-
    esDe(UnMago,_),
    hizo(UnMago,_),
    forall(hizo(UnMago,Accion),not(esAccionProhibida(Accion))).

accionRecurrente(Accion):-
    hizo(_,Accion),
    findall(UnMago,hizo(UnMago,Accion),Acciones),
    length(Acciones, Cantidad),
    Cantidad > 1.

% PUNTO 2

% Ejemplo de funcion para sumar el total de una lista.

puntajeTotal(Casa,PuntajeTotal):-
    esDe(_,Casa),
    findall(Puntos,
        (esDe(UnMago,Casa),hizo(UnMago,Accion),accion(Accion,Puntos)),
        PuntosDeCasa),
    sum_list(PuntosDeCasa,PuntajeTotal).

casaGanadora(Casa):-
    puntajeTotal(Casa,PuntajeGanador),
    forall((puntajeTotal(OtraCasa,OtroPuntaje), Casa \= OtraCasa),
            PuntajeGanador > OtroPuntaje).


            /*casaGanadora(Casa):-
                puntajeTotal(Casa,PuntajeGanador),
                forall(
                (puntajeTotal(OtraCasa,OtroPuntaje), 
                Casa \= OtraCasa),
                PuntajeGanador > OtroPuntaje).*/
            