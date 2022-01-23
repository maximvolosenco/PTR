-module(database).

-behaviour(gen_server).

-export([start_link/0, init/1, store_to_db/1, handle_cast/2]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    ets:new(tweet, [set, named_table]),
    {ok, []}.

store_to_db(TweetLengths) ->
    gen_server:cast(?MODULE, TweetLengths). 

handle_cast(TweetLengths, State) -> 

    io:format("[DB Store] DB: ~p~n", [TweetLengths]),
    ets:insert(tweet, TweetLengths),
    Infomration = ets:info(tweet),
    Size = lists:keyfind(size, 1, Infomration),
    io:format("~p~p ~n", ["Database Tweets =", Size]),
    {noreply, State}.