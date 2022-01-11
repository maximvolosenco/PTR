-module(router).

-behaviour(gen_server).

-export([start_link/0, init/1]).

start_link() ->
    gen_server:start_link(?MODULE, [], []).

init([]) ->
    {ok, {}}.

