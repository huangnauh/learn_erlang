-module(area).
-export([start/0, area/2, loop/0]).

start() -> spawn(area, loop, []).

area(Pid, What) ->
    rpc(Pid, What).

rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
        {Pid, Response} ->
            Response
    end.

loop() ->
    receive
        {From, {rectangle, Width, Ht}} ->
            From ! {self(), Width *Ht},
            io:format("area of rectangle is ~p~n", [Width * Ht]),
            loop();
        {From, {square, Side}} ->
            From ! {self(), Side * Side},
            io:format("area of square is ~p~n", [Side * Side]),
            loop();
        {From, Other} ->
            From ! {self(), {error, Other}},
            loop()
    end.
