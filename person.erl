-module(persion).
-export([start/0]).

start() ->
    Joe = spawn(persion, init, ["Joe"]),
    Su  = spawn(persion, init, ["Su"]),


