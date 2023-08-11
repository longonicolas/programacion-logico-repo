esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).
esPersonaje(bumi).
esPersonaje(suki).

esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(katara,agua).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).
controla(bumi,tierra).

visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo,
sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo,
sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo,
sectorMedio])).
visito(bumi,reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo,sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios,
enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(suki,nacionDelFuego(prision,200)).
visito(katara, tribuAgua(sur)).
visito(tayLee, tribuAgua(sur)).

visito(katara, tribuAgua(norte)).
visito(tayLee, tribuAgua(norte)).
visito(aang, tribuAgua(norte)).
visito(appa,tribuAgua(norte)).
visito(zuko,tribuAgua(norte)).

visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).
visito(aang, temploAire(norte)).

% PUNTO 1

esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento),controla(Personaje,Elemento)).

% PUNTO 2

noEsMaestro(Personaje):-
    esPersonaje(Personaje),
    not(controla(Personaje,_)).

esMaestroPrincipiante(Personaje):-
    controla(Personaje,_),
    forall(controla(Personaje,Elemento),esElementoBasico(Elemento)).

esMaestroAvanzado(Personaje):-
    controla(Personaje,Elemento),
    elementoAvanzadoDe(_,Elemento).
esMaestroAvanzado(Personaje):-
    esElAvatar(Personaje).

% PUNTO 3
sigueA(Seguidor,Seguido):-
    visito(Seguido,_),
    visito(Seguidor,_),
    Seguido \= Seguidor,
    forall(visito(Seguido,Lugar),visito(Seguidor,Lugar)).

sigueA(zuko,aang).

% PUNTO 4

lugar(reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo,sectorMedio])).
lugar(reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
lugar(nacionDelFuego(palacioReal, 1000)).
lugar(tribuAgua(norte)).
lugar(tribuAgua(sur)).
lugar(tribuAgua(este)).
lugar(tribuAgua(oeste)).
lugar(temploAire(norte)).
lugar(temploAire(sur)).
lugar(temploAire(este)).
lugar(temploAire(oeste)).

/*
esDignoDeConocer(temploAire(_)).
esDignoDeConocer(tribuAgua(norte)).
esDignoDeConocer(reinoTierra(_,Estructura)):-
    not(member(muro,Estructura)).
*/

esDignoDeConocer(UnLugar):-
    lugar(UnLugar),
    esLugarDigno(UnLugar).

esLugarDigno(temploAire(_)).
esLugarDigno(tribuAgua(norte)).
esLugarDigno(reinoTierra(_,Estructura)):-
    not(member(muro,Estructura)).


% PUNTO 5

esPopular(Lugar):-
    personasQueVisitaron(Lugar,Personajes),
    length(Personajes, Tamanio),
    Tamanio > 4.

    
personasQueVisitaron(Lugar,Personajes):-
    lugar(Lugar),
    findall(Personaje,visito(Personaje,Lugar),Personajes).

