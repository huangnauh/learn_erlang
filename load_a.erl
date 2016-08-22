-module(load_a).
-compile(export_all).

start(Tag) ->
    spawn(fun() -> loop(Tag) end).

loop(Tag) ->
    sleep(),
    Val = load_b:x(),
    io:format("vsn1 (~p) b:x() = ~p~n", [Tag, Val]),
    loop(Tag).

sleep() ->
    receive
        after 3000 -> true
    end.
