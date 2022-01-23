%%%-------------------------------------------------------------------
%% @doc laboratory1 top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(laboratory1_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    SupFlags = #{strategy => one_for_all,
                 intensity => 0,
                 period => 1},

    Stream1 = "/tweets/1",  
         
    WorkerSupervisor = #{
        id => worker_supervisor,
        start => {worker_supervisor, start_link, []},
        restart => permanent,
        type => supervisor,
        modules => [worker_supervisor]
        },
    Router = #{
        id => router,
        start => {router, start_link, []},
        restart => permanent,
        type => worker,
        modules => [router]
        },
    Reader = #{
        id => reader,
        start => {reader, start, [Stream1]},
        restart => permanent,
        type => worker,
        modules => [reader]
        },
    Batcher = #{
        id => batcher,
        start => {batcher, start_link, []},
        restart => permanent,
        type => worker,
        modules => [batcher]
        },
    Database =#{
        id => database,
        start => {database, start_link, []},
        restart => permanent,
        type => worker,
        modules => [database]
        },

    ChildSpecs = [Database, Batcher, WorkerSupervisor, Router],

    {ok, {SupFlags, ChildSpecs}}.
