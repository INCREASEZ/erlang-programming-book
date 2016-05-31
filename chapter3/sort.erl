%% @author zhangz
%% @doc @todo Add description to sort.


-module(sort).
-behaviour(application).
-export([start/2, stop/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).



%% ====================================================================
%% Behavioural functions
%% ====================================================================

%% start/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/apps/kernel/application.html#Module:start-2">application:start/2</a>
-spec start(Type :: normal | {takeover, Node} | {failover, Node}, Args :: term()) ->
	{ok, Pid :: pid()}
	| {ok, Pid :: pid(), State :: term()}
	| {error, Reason :: term()}.
%% ====================================================================
start(Type, StartArgs) ->
    case 'TopSupervisor':start_link(StartArgs) of
		{ok, Pid} ->
			{ok, Pid};
		Error ->
			Error
    end.

%% stop/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/apps/kernel/application.html#Module:stop-1">application:stop/1</a>
-spec stop(State :: term()) ->  Any :: term().
%% ====================================================================
stop(State) ->
    ok.

%% ====================================================================
%% Internal functions
%% ====================================================================
-module(sort).
-compile(export_all).

quick([]) -> [];

quick([H|T]) -> 
  [Max, Min] = quick_x(H, T, [], []),
  flatten([quick(Max) | [H | quick(Min)]]).

quick_x(_, [], Min, Max) ->
  [Max, Min];

quick_x(Cur, [H|T], Min, Max) when Cur < H ->
  quick_x(Cur, T, Min, [H|Max]);

quick_x(Cur, [H|T], Min, Max) when Cur >= H ->
  quick_x(Cur, T, [H|Min], Max).

flatten([]) -> 
flatten([H|T]) ->
  [H|flatten(T)].

