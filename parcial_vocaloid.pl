vocaloid(megurineLuka,nightFever,4).
vocaloid(megurineLuka,foreverYoung,5).
vocaloid(hatsuneMiku,tellYourWorld,4).
vocaloid(gumi,foreverYoung,4).
vocaloid(gumi,tellYourWorld,5).
vocaloid(seeU,novemberRain,6).
vocaloid(seeU,nightFever,5).


% PUNTO 2

esNovedoso(Vocaloid):-
    vocaloid(Vocaloid,_,_),
    tiempoTotalDeCanciones(Vocaloid,TotalMinutos),
    cantidadDeCanciones(Vocaloid,Cantidad),
    Cantidad > 1,
    TotalMinutos < 15.

tiempoTotalDeCanciones(Vocaloid,TotalMinutos):-
    findall(Duracion,vocaloid(Vocaloid,_,Duracion),DuracionDeCanciones),
    sum_list(DuracionDeCanciones, TotalMinutos).

cantidadDeCanciones(Vocaloid,Cantidad):-
    findall(Cancion,vocaloid(Vocaloid,Cancion,_),Canciones),
    length(Canciones,Cantidad).

% PUNTO 2

esAcelerado(Vocaloid):-
    vocaloid(Vocaloid,_,_),
    cantidadCancionesLargas(Vocaloid,Cantidad),
    Cantidad < 1.

cantidadCancionesLargas(Vocaloid,Cantidad):-
    vocaloid(Vocaloid,_,_),
    findall(Duracion,
            (vocaloid(Vocaloid,_,Duracion), cancionLarga(Duracion)),
            CancionesLargas),
    length(CancionesLargas,Cantidad).

cancionLarga(Duracion):-
    Duracion > 4.

% PARTE B

% PUNTO 1

% concierto(nombre,pais,cantFama,tipo()).
% gigante(cantCanciones,durMinima).
% mediano(durMaxima).
% pequenio(durMinima).

concierto(mikuExpo,estadosUnidos,2000,gigante(2,6)).
concierto(magicalMirai,japon,3000,gigante(3,10)).
concierto(vocalektVision,estadosUnidos,1000,mediano(9)).
concierto(mikuFest,argentina,100,pequenio(4)).

% PUNTO 2

puedeParticipar(Vocaloid,Concierto):-
    vocaloid(Vocaloid,_,_),
    concierto(Concierto,_,_,Tipo),
    requisitosDeConcierto(Vocaloid,Tipo),
    Vocaloid \= hatsuneMiku.

puedeParticipar(hatsuneMiku,Concierto):-
    concierto(Concierto,_,_,_).

requisitosDeConcierto(Vocaloid,gigante(CantCanciones,DuracionMinima)):-
    cantidadDeCanciones(Vocaloid,Cantidad),
    tiempoTotalDeCanciones(Vocaloid,Duracion),
    Cantidad > CantCanciones - 1,
    Duracion > DuracionMinima.

requisitosDeConcierto(Vocaloid,mediano(DuracionMaxima)):-
    tiempoTotalDeCanciones(Vocaloid,Duracion),
    Duracion < DuracionMaxima.

requisitosDeConcierto(Vocaloid,pequenio(DuracionMinima)):-
    vocaloid(Vocaloid,_,Duracion),
    Duracion > DuracionMinima.

% PUNTO 3

masFamoso(Vocaloid,NivelFama):-
    cantidadDeCanciones(Vocaloid,Cantidad),
    findall(Fama,
            (puedeParticipar(Vocaloid,Concierto),
            concierto(Concierto,_,Fama,_)),
            ListaDeFama),
    sum_list(ListaDeFama,TotalFama),
    NivelFama is TotalFama * Cantidad.

% PUNTO 4

conoceA(megurineLuka,hatsuneMiku).
conoceA(megurineLuka,gumi).
conoceA(gumi,seeU).
conoceA(seeU,kaito).


unicoEnConcierto(Vocaloid,Concierto):-
    puedeParticipar(Vocaloid,Concierto),
    forall(conoce(Vocaloid,Conocido),not(puedeParticipar(Conocido,Concierto))).

conoce(Vocaloid,Conocido):-
    conoceA(Vocaloid,Conocido).

conoce(Vocaloid,Conocido):-
    conoceA(Vocaloid,UnCantante),
    conoceA(UnCantante,Conocido).

% PUNTO 5

/*En la solución planteada habría que agregar una claúsula en el predicado cumpleRequisitos/2 
que tenga en cuenta el nuevo functor con sus respectivos requisitos.

El concepto que facilita los cambios para el nuevo requerimiento es el polimorfismo, 
que nos permite dar un tratamiento en particular a cada uno de los conciertos en la cabeza de la cláusula.*/