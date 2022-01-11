
-module(worker_supervisor).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    {ok, SupervisorAddress} = supervisor:start_link({local, ?SERVER}, ?MODULE, []),
    supervisor:start_child(SupervisorAddress, []),
    supervisor:start_child(SupervisorAddress, []),
    supervisor:start_child(SupervisorAddress, []),
    {ok, SupervisorAddress}.

init([]) ->
    SupFlags = #{strategy => simple_one_for_one,
                 intensity => 0,
                 period => 1},
                 
    TestWorker1 = #{
        id => test_worker,
        start => {test_worker, start_link, []},
        restart => permanent,
        type => worker,
        modules => [test_worker]
        },

    ChildSpecs = [TestWorker1],

    {ok, {SupFlags, ChildSpecs}}.