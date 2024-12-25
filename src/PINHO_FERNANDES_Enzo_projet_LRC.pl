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
subs(chat,felin).                                    
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
subs(chihuahua,and(chien,pet)).                      
subs(souris,mammifere).
subs(and(animal,some(aMaitre)),pet).                 
subs(pet,some(aMaitre)).
subs(animal,some(mange)).
subs(some(aMaitre),all(aMaitre,personne)).           
subs(and(animal,plante),nothing).
subs(and(all(mange,nothing),some(mange)),nothing). 


/* Rajout pour la question 4.2 : 2e règle */
subs(canariPet, canari).
subs(canariPet, some(aMaitre)).

/* Rajout pour la question 4.2 : 7e règle */
subs(and(parent, homme), pere).

/* Rajout pour la question 2.6 : on a (C ≡ D) => (C ⊑ D) ^ (D ⊑ C). */
subs(C, D) :- equiv(C, D).
subs(C, D) :- equiv(D, C).

equiv(carnivoreExc,all(mange,animal)).               
equiv(herbivoreExc,all(mange,plante)).





% ==================================================================================

/* 
 *  Règles de l'exercice 2 : Concepts atomiques
 */

% ==================================================================================


% ========== SubsS1 ==========

subsS1(C, C).
subsS1(C, D) :- subs(C, D), C \== D.
subsS1(C, D) :- subs(C, E), subsS1(E, D). 



% ========== SubsS ==========

subsS(C, D) :- subsS(C, D, [C]).
subsS(C, C, _).
subsS(C, D, _) :- subs(C, D), C \== D.
subsS(C, D, L) :- subs(C, E), not(member(E, L)), subsS(E, D, [E | L]), E \== D.





% ==================================================================================

/* 
 *  Règles de l'exercice 3 : Gestion des conjonctions
 */

% ==================================================================================

/* 
 *  Contenu du fichier LRC_regleConjonction.pl
 */

subsS(C, and(D1,D2), L) :- D1 \= D2, subsS(C,D1,L), subsS(C,D2,L).
subsS(C, D, L) :- subs(and(D1, D2), D), E = and(D1, D2), not(member(E, L)), subsS(C, E, [E|L]), E \== C.
subsS(and(C, C), D, L) :- nonvar(C), subsS(C, D, [C|L]).
subsS(and(C1, C2), D, L) :- C1 \= C2, subsS(C1, D, [C1|L]).
subsS(and(C1, C2), D, L) :- C1 \= C2, subsS(C2, D, [C2|L]).
subsS(and(C1, C2), D, L) :- subs(C1, E1), E = and(E1, C2), not(member(E, L)), subsS(E, D, [E|L]), E \== D.
subsS(and(C1, C2), D, L) :- Cinv = and(C2, C1), not(member(Cinv, L)), subsS(Cinv, D, [Cinv|L]).





% ==================================================================================

/* 
 *  Règles de l'exercice 4 : Gestion des rôles
 */

% ==================================================================================

/* Réponse pour la question 4.1 : on a (C ⊑_s D) => (∀ R.C ⊑_s ∀ R.D). */
subsS(all(R, C), all(R, D), L) :- subsS(C, D, L).

/*
 * Rajout pour la question 4.3 :
 *  - Actuellement, on ne gère pas les contradictions/incohérences logiques (nothing), on doit rajouter ces règles pour que les deux requêtes marchent.
 */
subsS(and(carnivoreExc, herbivoreExc), all(mange, nothing), L) :- not(member(nothing, L)).
subsS(and(and(carnivoreExc, herbivoreExc), animal), nothing, L) :- not(member(nothing, L)).