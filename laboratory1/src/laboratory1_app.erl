%%%-------------------------------------------------------------------
%% @doc laboratory1 public API
%% @end
%%%-------------------------------------------------------------------

-module(laboratory1_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    laboratory1_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
