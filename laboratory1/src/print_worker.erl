-module(print_worker).

-behaviour(gen_server).

-export([start_link/0, init/1, handle_cast/2, handle_call/3 ]).

start_link() ->
    gen_server:start_link(?MODULE, [], []).

init([]) ->
    {ok, {}}.

handle_cast(String, _) -> 
    TweetLength = string:length(String),
    batcher:send_tweet_length(TweetLength),
    % io:format("Len: ~p~n", [TweetLength]),
    {noreply, {}}.
    
handle_call({_, _}, State, _)->
    {noreply, State}.