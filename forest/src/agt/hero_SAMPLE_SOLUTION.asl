//STUDENT NAME: DANILO PAES DE SOUZA
//STUDENT ID: 200052373

// Hero is at the position of agent P (variable), if agent P's position is identical to Hero's position
at(P) :- pos(P,X,Y) & pos(hero,X,Y).

// Here we check If we have all the items
at_home :- pos(hero, 0, 0).
cant_find_all_items :- not(have_all_items(N)) & reached_the_end(hero).
have_all_items(N) :- total_coins(1) & total_gems(1) & total_vases(1).
keep_looking :- not(have_all_items(N)) & not(reached_the_end(hero)).
not_at_home :- not(pos(hero, 0, 0) & pos(hero(X, Y))).
reached_the_end(P) :- pos(P, 7, 7).

// to track the last visited slot
last_visited(X, Y).

// to count my items
total_coins(0).
total_gems(0).
total_vases(0).

// Initial goal
!started.
!find_items.

/*
* In the event that the agent must achieve "started", under all circumstances, print the message.
*/
+!started 
   :true
   <- .print("I'm not scared of that smelly Goblin!").

+!find_items
   : coin(hero) | vase(hero) | gem(hero)
   <- 
   if (coin(hero)) { .print("I've found the coin!"); !get_coin };
   if (vase(hero)) { .print("I've found the vase!"); !get_vase };
   if (gem(hero)) { .print("I've found the gem!"); !get_gem }.
+!find_items
   : keep_looking
   <- ?pos(hero, X, Y);
      -+last_visited(X, Y);
      next(slot);
      .wait(200);
      !find_items.
+!find_items
   : cant_find_all_items
   <- .print("Well, I couldn't find all the items...");
      .wait(200);
      !go_back_home.
+!find_items
   : have_all_items(N)
   <- .print("I've found all the items!", N);
      !find_goblin.

+!get_coin
   : coin(hero)
   <- ?total_coins(N);
      if (N < 1) {
         -+total_coins(N + 1);
         pick(coin);
         stash(coin);
      } else { 
         .print("Hmm, I already have this one.");
         next(slot);
      }
      !find_items.

+!get_vase
   : vase(hero)
   <- ?total_vases(N);
      if (N < 1) {
         -+total_vases(N + 1);
         pick(vase);
         stash(vase);
      } else { 
         .print("Hmm, I already have this one.");
         next(slot);
      }
      !find_items.

+!get_gem
   : gem(hero)
   <- ?total_gems(N);
     if (N < 1) {
         -+total_gems(N + 1);
         pick(gem);
         stash(gem);
      } else { 
         .print("Hmm, I already have this one.");
         next(slot);
      }
      !find_items.

+!find_goblin
   : at(goblin)
   <- .print("Hello Mr Goblin, here are your items.");
      .print("Your coin...");
      drop(coin);
      .print("Your gem...");
      drop(gem);
      .print("Your vase...");
      drop(vase);
      .print("See ya!");
      !go_back_home.
+!find_goblin
   : not(at(goblin))
   <- ?pos(goblin, X, Y);
      move_towards(X, Y);
      .wait(700);
      !find_goblin.

+!go_back_home
   : at_home
   <- .print("I am tired...").
+!go_back_home
   : not_at_home
   <- move_towards(0, 0);
      .wait(700);
   !go_back_home.