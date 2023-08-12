
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
    
    
