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
                 
    WorkerSupervisor = #{
        id => worker_supervisor,
        start => {worker_supervisor, start_link, []},
        restart => permanent,
        type => supervisor,
        modules => [worker_supervisor]
        },

    ChildSpecs = [WorkerSupervisor],

    {ok, {SupFlags, ChildSpecs}}.
