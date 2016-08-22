-module(lib_chan_cs).
-export([port_name/1]).

port_name(Port) when is_integer(Port) ->
    list_to_atom("portServer" ++ integer_to_list(Port)).
