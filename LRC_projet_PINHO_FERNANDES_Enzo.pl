/* 
 *  LRC - PROJET 2024-25 : Subsomptions en Prolog
 *
 *  Nom : PINHO FERNANDES
 *  Prénom : Enzo
 */





% ==================================================================================

/* 
 *  Contenu du fichier LRC_donneesProjet.pl
 */

/* T-BOX */
subs(chat,felin).                                    /* à commenter */
subs(felin,mammifere).
subs(mammifere,animal).
subs(canide,mammifere).
subs(chien,canide).
subs(canide,chien).
subs(canari,animal).
subs(animal,etreVivant).
subs(lion,felin).
subs(lion,carnivoreExc).
subs(carnivoreExc,predateur).
subs(chihuahua,and(chien,pet)).                      /* à commenter */
subs(souris,mammifere).
subs(and(animal,some(aMaitre)),pet).                 /* à commenter */
subs(pet,some(aMaitre)).
subs(animal,some(mange)).
subs(some(aMaitre),all(aMaitre,personne)).           /* à commenter */
subs(and(animal,plante),nothing).
subs(and(all(mange,nothing),some(mange)),nothing).   /* à commenter */
equiv(carnivoreExc,all(mange,animal)).               /* à commenter */
equiv(herbivoreExc,all(mange,plante)).





% ==================================================================================

/* 
 *  Règles de l'exercice 2 : Concepts atomiques
 */


subsS1(C, C).
subsS1(C, D) :- subs(C, D), C \== D.
subsS1(C, D) :- subs(C, E), subsS1(E, D). 


subsS(C, D) :- subsS(C, D, [C]).
subsS(C, C, _).
subsS(C, D, _) :- subs(C, D), C \== D.
subsS(C, D, L) :- subs(C, E), not(member(E, L)), subsS(E, D, [E | L]), E \== D.