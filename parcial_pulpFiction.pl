
personaje(pumkin, ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent, mafioso(maton)).
personaje(jules, mafioso(maton)).
personaje(marsellus, mafioso(capo)).
personaje(winston, mafioso(resuelveProblemas)).
personaje(mia, actriz([foxForceFive])).
personaje(butch, boxeador).

pareja(marsellus, mia).
pareja(pumkin, honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

% PUNTO 1

esPeligroso(Personaje):-
    personaje(Personaje,Actividad),
    actividadPeligrosa(Actividad).
esPeligroso(Personaje):-
    trabajaPara(Personaje,Empleado),
    esPeligroso(Empleado).

actividadPeligrosa(mafioso(maton)).

actividadPeligrosa(ladron(Robos)):-
    member(licorerias,Robos).

% PUNTO 2

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

duoTemible(Personaje1,Personaje2):-
    esPeligroso(Personaje1),
    esPeligroso(Personaje2),
    sonParejaOAmigos(Personaje1,Personaje2).

sonParejaOAmigos(Personaje1,Personaje2):-
    pareja(Personaje1,Personaje2).
sonParejaOAmigos(Personaje1,Personaje2):-
    pareja(Personaje2,Personaje1).
sonParejaOAmigos(Personaje1,Personaje2):-
    amigo(Personaje1,Personaje2).
sonParejaOAmigos(Personaje1,Personaje2):-
    amigo(Personaje2,Personaje1).

% PUNTO 3

%encargo(Solicitante, Encargado, Tarea).
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent, cuidar(mia)).
encargo(vincent, elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnProblemas(Personaje):-
    personaje(Personaje,_),
    trabajaPara(Jefe,Personaje),
    esPeligroso(Jefe),
    pareja(Jefe,Pareja),
    encargo(Jefe,Personaje,cuidar(Pareja)).

estaEnProblemas(Personaje):-
    encargo(_,Personaje,buscar(Boxeador,_)),
    personaje(Boxeador,boxeador).
 
% PUNTO 5

masAtareado(Personaje):-
    cantidadDeEncargos(Personaje,Cantidad),
    forall((cantidadDeEncargos(OtroPersonaje,CantidadMenor), Personaje \= OtroPersonaje), Cantidad > CantidadMenor).

cantidadDeEncargos(Personaje,Cantidad):-
    personaje(Personaje,_),
    findall(Encargo,encargo(_,Personaje,Encargo),Encargos),
    length(Encargos, Cantidad).
    
% PUNTO 6

personajesRespetables(Personajes):-
    findall(Personaje,
            (nivelDeRespeto(Personaje,Nivel), Nivel > 9),
            Personajes).

nivelDeRespeto(Personaje,Nivel):-
    personaje(Personaje,mafioso(resuelveProblemas)),
    Nivel is 10.
nivelDeRespeto(Personaje,Nivel):-
    personaje(Personaje,mafioso(maton)),
    Nivel is 1.
nivelDeRespeto(Personaje,Nivel):-
    personaje(Personaje,mafioso(capo)),
    Nivel is 20.
nivelDeRespeto(Personaje,Nivel):-
    personaje(Personaje,actriz(Peliculas)),
    length(Peliculas,Cantidad),
    Nivel is 1/10 * Cantidad.

% PUNTO 7



