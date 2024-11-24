//STUDENT NAME: DANILO PAES DE SOUZA
//STUDENT ID: 200052373

// Hero is at the position of agent P (variable), if agent P's position is identical to Hero's position
at(P) :- pos(P,X,Y) & pos(hero,X,Y).

// Initial goal
!started.
!get_coin.
// !get_vase.
// !get_gem.
// !find_goblin.

/*
* In the event that the agent must achieve "started", under all circumstances, print the message.
*/
+!started 
   :true
   <- .print("I'm not scared of that smelly Goblin!").


+!get_coin
   : coin(hero)
   <- .print("I've found the coin!");
      pick(coin);
      stash(coin);
      !get_vase.
+!get_coin
   : not(coin(hero))
   <- next(slot);
      .wait(700);
      !get_coin.

+!get_vase
   : vase(hero)
   <- .print("I've found the vase!");
      pick(vase);
      stash(vase);
      !get_gem.
+!get_vase
   : not(vase(hero))
   <- next(slot);
      .wait(700);
      !get_vase.

+!get_gem
   : gem(hero)
   <- .print("I've found the gemget_gem!");
      pick(gem);
      stash(gem);
      !find_goblin.
+!get_gem
   : not(gem(hero))
   <- next(slot);
      .wait(700);
      !get_gem.

+!find_goblin
   : pos(hero, X, Y) & pos(goblin, X, Y)
   <- .print("Hello Mr Goblin, here are your items.");
      drop(coin);
      drop(gem);
      drop(vase);
      !go_back_home.
+!find_goblin
   : not(pos(hero, X, Y) & pos(goblin, X, Y))
   <- move_towards(4, 4);
      .wait(700);
      !find_goblin.

+!go_back_home
   : pos(hero, 0, 0)
   <- .print("That was tyring...").
+!go_back_home
   : not(pos(hero, 0, 0) & pos(hero(X, Y)))
   <- move_towards(0, 0);
      .wait(700);
   !go_back_home.