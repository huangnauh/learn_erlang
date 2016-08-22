-module(test_process).
-compile(export_all).

start() -> 
    Pid = spawn(
        fun() ->
                process_flag(trap_exit, true),
                do_loop()
        end),
    register(test, Pid).

do_loop() ->
    receive
        Msg ->
            io:format("recv ~w~n", [Msg])
    end,
    do_loop().

