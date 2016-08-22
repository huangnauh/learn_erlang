-module(try_test).
-export([sum/1, demo2/0, demo1/0, demo/0, catcher/1, generate_exception/1]).
-compile(export_all).
-vsn(1).

generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {'EXIT', a};
generate_exception(5) -> error(a).

sum(L) -> sum(L, 0).

sum([],N)  -> N;
sum([H|T], N) -> sum(T, H+N).

demo() ->
    [catcher(I) || I <- [1,2,3,4,5]].

demo1() ->
    [{I, (catch generate_exception(I))} || I <- [1,2,3,4,5]].

demo2() ->
    try generate_exception(5)
    catch
        error:X ->
            {X, erlang:get_stacktrace()}
    end.

catcher(N) ->
  try generate_exception(N) of
    Val -> {N, normal, Val}
  catch
    throw:X -> {N, caught, thrown, X};
    exit:X  -> {N, caught, exited, X};
    error:X -> {N, caught, error, X}
  end.

