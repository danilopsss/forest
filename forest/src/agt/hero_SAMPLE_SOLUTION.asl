//STUDENT NAME: DANILO PAES DE SOUZA
//STUDENT ID: 200052373

// Hero is at the position of agent P (variable), if agent P's position is identical to Hero's position
at(P) :- pos(P,X,Y) & pos(hero,X,Y).

// Initial goal
!started.
!get_coin.
!next_item.
!get_vase.
!get_gem.
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
      .wait(2000);
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
      .wait(2000);
      !get_vase.

+!get_gem
   : gem(hero)
   <- .print("I've found the gemget_gem!");
      pick(gem);
      stash(gem).
+!get_gem
   : not(gem(hero))
   <- next(slot);
      .wait(2000);
      !get_gem.
