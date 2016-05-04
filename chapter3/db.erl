%% @author zhangz
%% @doc @todo Add description to db.


-module(db).
-behaviour(application).
-export([start/2, stop/1, new/0]).

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

new() ->
	[].

destory(_) ->
	[].

write(K,V,DB) ->
	[{K,V}|DB].

read(_,[])->
	{error,instance};
read(K,[{K,V}|_]) ->
	{ok,V};
read(K,[_|T]) ->
	read(K,T).

match(_,[])->
	[];
match(V,[{K,V}|T]) ->
	[K|match(V,T)];
match(V,[_|T]) ->
	match(V,T).
	
delete(_,[]) ->
	[];
delete(K,[{K,V}|T]) ->
	delete(K,T);
delete(K,[H|T]) ->
	[H | delete(K,T)].
