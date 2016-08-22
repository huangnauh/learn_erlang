-module(lib_misc).
-export([consult/1, keep_alive/2, on_exit/2, sleep/1, flush_buffer/0, priority_receive/0, count_chars/1, odds_and_evens2/1, odds_and_evens1/1,filter/2, for/3, qsort/1, pythag/1, perms/1]).
for(Max, Max, F) -> [F(Max)];
for(I, Max, F)   -> [F(I)|for(I+1, Max, F)].

consult(File) ->
    case file:open(File, read) of
        {ok, S} ->
            Val = consultl(S),
            file:close(S),
            {ok, Val};
        {error, Why} ->
            {error, Why}
    end.

consultl(S) ->
    case io:read(S, '') of
        {ok, Term}  -> [Term | consultl(S)];
        eof         -> [];
        Error       -> Error
    end.

keep_alive(Name, Fun) ->
    register(Name, Pid = spawn(Fun)),
    on_exit(Pid, fun(_Why) -> keep_alive(Name, Fun) end).

on_exit(Pid, Fun) ->
    spawn(fun() ->
                Ref = monitor(process, Pid),
                receive {"DOWN", Ref, process, Pid, Why} ->
                        Fun(Why)
                end
        end). 

sleep(T) ->
    receive
    after T ->
            true
    end.

flush_buffer() ->
    receive
        _Any ->
            flush_buffer()
    after 0 ->
            true
    end.

priority_receive() ->
    receive
        {alarm, X} ->
            {alarm, X}
    after 0 ->
            receive
                Any ->
                    Any
            end
    end.

count_chars(Str)  ->
    count_char(Str, #{}).

count_char([H|T], X) ->
    case maps:is_key(H, X) of
        false -> count_char(T, maps:put(H,1,X));
        true  -> Count = maps:get(H, X),
            count_char(T, maps:update(H, Count+1,X))
    end;
count_char([], X) ->
    X.

odds_and_evens1(L) ->
    Odds  = [X || X <-L, (X rem 2) =:= 1],
    Evens = [X || X <-L, (X rem 2) =:= 0],
    {Odds, Evens}.

odds_and_evens2(L) ->
    odds_and_evens_acc(L, [],[]).

odds_and_evens_acc([H|T], Odds, Evens) ->
    case (H rem 2) of
        1 -> odds_and_evens_acc(T, [H|Odds], Evens);
        0 -> odds_and_evens_acc(T, Odds, [H|Evens])
    end;

odds_and_evens_acc([], Odds,Evens) -> 
    {lists:reverse(Odds), lists:reverse(Evens)}.

filter(P, [H|T]) ->
    case P(H) of
        true  -> [H|filter(P,T)];
        false -> filter(P, T)
    end;
filter(P, []) -> [].

qsort([]) -> [];
qsort([Pivot|T]) ->
    qsort([X || X <- T, X < Pivot])
    ++ [Pivot] ++
    qsort([X || X <- T , X >= Pivot]).

pythag(N) ->
    [ {A, B, C} ||
        A <- lists:seq(1, N),
        B <- lists:seq(1, N),
        C <- lists:seq(1, N),
        A + B + C =< N,
        A*A + B*B =:= C*C
    ].

perms([]) -> [[]];
perms(L)  -> [[H|T] || H <-L, T <- perms(L--[H])].
