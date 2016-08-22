-module(dialyzier_types1).
-export([myand/2]).

myand(true, true) -> true;
myand(false, _) -> false;
myand(_, false) -> false.

bug(X, Y) ->
    case myand(X, Y) of
        true ->
            X + Y
    end.

