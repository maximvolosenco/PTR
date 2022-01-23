-module(batcher).

-behaviour(gen_server).

-export([start_link/0, init/1, send_tweet_length/1, handle_cast/2, handle_info/2]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    erlang:start_timer(500, batcher, secondsexpired),
    {ok, {[], 0}}.

send_tweet_length(TweetLength) ->
    gen_server:cast(?MODULE, {TweetLength}).

handle_cast({TweetLength}, {TweetLengths, Count}) -> 
    NewCount = Count + 1,
    NewTweetLengths = [TweetLength | TweetLengths],
    if NewCount > 100 ->
        Index = generate_random_number(),
        database:store_to_db({Index, NewTweetLengths}),
        NewState = {[], 0};
        true -> NewState = {NewTweetLengths, NewCount}
    end, 

    {noreply, NewState}.

handle_info({_, _, secondsexpired}, NewTweetLengths) ->
    database:store_to_db(NewTweetLengths),
    erlang:start_timer(500, self(), secondsexpired),
    {noreply, {[], 0}}.

generate_random_number() -> 
    round(rand:uniform() * 1000000).