%% @author zhangz
%% @doc @todo Add description to filter.


-module(filter).
-behaviour(application).
-export([start/2, stop/1, filter/2, reverse/1, concatenate/1, flatten/1]).

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

filter([],_) ->
	[];
filter([H|T],N) when H =< N ->
	[H|filter(T,N)];
filter([H|T],N) ->
	filter(T,N).

reverse(T) ->
	reverse(T,[]).

reverse([],L) ->
	L;
reverse([H|T],L) ->
	reverse(T,[H|L]).

concatenate(T) ->
	concatenate(T,[]).

concatenate([],L)->
	L;
concatenate([H|T],L) ->
	concatenate(T,L++H).
%%========?????=================
flatten_acc([], A) ->
    concatenate(A);

flatten_acc([H | T], _) ->
    flatten_acc(H, []) ++ flatten_acc(T, []);

flatten_acc(H, A) ->
    [H | A].

flatten([]) ->
    [];

flatten(List) ->
    flatten_acc(List, []).