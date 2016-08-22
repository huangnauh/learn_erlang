-module(test_app).
-behaviour(application).
-export([start/2, stop/1]).

start(_Type, StartArgs) ->
    io:format("test app start~n"),
    case test_sup:start_link(StartArgs) of
        {ok, Pid} ->
            {ok, Pid};
        Error ->
            Error
    end.

stop(_State)->
    ok.
