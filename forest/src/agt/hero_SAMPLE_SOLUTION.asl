//STUDENT NAME: DANILO PAES DE SOUZA
//STUDENT ID: 200052373

// Hero is at the position of agent P (variable), if agent P's position is identical to Hero's position
at(P) :- pos(P,X,Y) & pos(hero,X,Y).

// Initial goal
!started.
!pick(coin).
!pick(gem).
!pick(vase).
!find_goblin.

/*
* In the event that the agent must achieve "started", under all circumstances, print the message.
*/
+!started 
   :true
   <- .print("I'm not scared of that smelly Goblin!").

+!pick(coin)
   :coin(hero)
   <- stash(coin);
      .print("I've found the coin!").
+!pick(coin)
   :not pos(hero, 7, 7)
   <- next(slot);
      !pick(coin).

+!pick(gem)
   :gem(hero)
   <- stash(gem);
      .print("I've found the gem!").
+!pick(gem)
   :not pos(hero, 7, 7)
   <- next(slot);
      !pick(gem).

+!pick(vase)
   :vase(hero)
   <- stash(vase);
      .print("I've found the vase!").
+!pick(vase)
   :not pos(hero, 7, 7)
   <- next(slot);
      !pick(vase).

+!find_goblin
   : pos(hero, X, Y) & pos(goblin, X, Y)
   <- .print("I've found the goblin").
+!find_goblin
   :pos(hero, X1, Y1) & pos(goblin, X2, Y2) & (X1 == X2 & Y1 == Y2)
   <- next(slot);
      !find_goblin.
