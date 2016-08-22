-module(test_sup).
-behaviour(supervisor).
-export([start_link/1, init/1]).

start_link(_) ->
    io:format("test sup start link~n"),
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    {ok, 
        {
            {one_for_one, 1, 60},         % Strategy={How, Max, Within}
            [
                {test_handle_worker,
                 {test_server, start, []}, % StartFun = {M,F,A}
                 permanent,                % Restart
                 2000,                     % Shutdown
                 worker,                   % Type
                 [test_server]             % Modules
                }
            ]
        }
      }.

