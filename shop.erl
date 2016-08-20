-module(shop).
-export([total/1, cost/1, totall/1]).
-import(lists, [map/2, sum/1]).

cost(oranges)   ->5;
cost(apples)    ->8;
cost(pears)     ->7.

total([{What,N}|T]) -> cost(What) * N + total(T);
total([])           -> 0.

totall(L) -> 
    sum(map(fun({What, N}) -> cost(What) * N end, L)).


