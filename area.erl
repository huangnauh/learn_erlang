-module(area).
-export([loop/0]).

loop() ->
    receive
        {rectangle, Width, Ht} ->
            io:format("area of rectangle is ~p~n", [Width * Ht]),
            loop();
        {square, Side} ->
            io:format("area of square is ~p~n", [Side * Side]),
            loop()
    end.
