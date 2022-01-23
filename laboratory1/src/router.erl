-module(router).

-behaviour(gen_server).

-export([start_link/0, init/1, handle_cast/2]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    {ok, 1}.

handle_cast(Request, State) -> 
    ChildrenList = supervisor:which_children(worker_supervisor),
    { _, Child, _, _ } = lists:nth((State rem length(ChildrenList)) + 1, ChildrenList), 
    gen_server:cast(Child, Request),
    NewState = State + 1,
    {noreply, NewState}.

