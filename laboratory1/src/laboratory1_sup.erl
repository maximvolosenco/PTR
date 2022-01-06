%%%-------------------------------------------------------------------
%% @doc laboratory1 top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(laboratory1_sup).

-behaviour(gen_server).

-export([start_link/0, init/1, handle_cast/2, handle_test/1 ]).

start_link() ->
    gen_server:start_link(?MODULE, [], []).

init([]) ->
    {ok, {}}.

handle_cast({send_message, EventMessageBinary}, State) ->
    
    io:format("The value is: ~p.", [EventMessageBinary]);

handle_cast({_, EventMessageBinary}, _) ->
    
    io:format("The value is: ~p.", [EventMessageBinary]).

handle_test(Input) -> 
    io:format("The value is: ~p .", [Input]).
% handle_call() ->

% -behaviour(supervisor).

% -export([start_link/0]).

% -export([init/1]).

% -define(SERVER, ?MODULE).

% start_link() ->
%     supervisor:start_link({local, ?SERVER}, ?MODULE, []).

% %% sup_flags() = #{strategy => strategy(),         % optional
% %%                 intensity => non_neg_integer(), % optional
% %%                 period => pos_integer()}        % optional
% %% child_spec() = #{id => child_id(),       % mandatory
% %%                  start => mfargs(),      % mandatory
% %%                  restart => restart(),   % optional
% %%                  shutdown => shutdown(), % optional
% %%                  type => worker(),       % optional
% %%                  modules => modules()}   % optional
% init([]) ->
%     SupFlags = #{strategy => one_for_all,
%                  intensity => 0,
%                  period => 1},
%     ChildSpecs = [],
%     {ok, {SupFlags, ChildSpecs}}.

% %% internal functions
