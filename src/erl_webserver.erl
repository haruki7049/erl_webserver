-module(erl_webserver).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
	elli:start_link([{callback, elli_example_callback}, {port, 3000}]).

stop(_State) ->
	ok.
