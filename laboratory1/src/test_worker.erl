-module(test_worker).

-behaviour(gen_server).

-export([start_link/0, init/1, handle_cast/2, handle_call/3 ]).

start_link() ->
    gen_server:start_link(?MODULE, [], []).

init([]) ->
    {ok, {}}.

handle_cast({send_message, EventMessageBinary}, State) ->
    
    io:format("The value is: ~p.", [EventMessageBinary]),
    {noreply, State};

handle_cast({_, EventMessageBinary}, _) ->
    
    io:format("The value is: ~p.", [EventMessageBinary]),
    {noreply, []};

handle_cast(String, {}) -> 
    io:format("dasd ~p", [String]),
    {noreply, []}.
    
handle_call({_, _}, State, _)->
    {noreply, State}.