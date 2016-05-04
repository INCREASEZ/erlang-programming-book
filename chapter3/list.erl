%% @author zhangz
%% @doc @todo Add description to list.


-module(list).
-behaviour(application).
-export([start/2, stop/1, list/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([reverse_list/1]).



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

list(N)  -> 
	list_acc(N,[]).
list_acc(N,T) when N > 0 ->
	list_acc(N-1,[N|T]); 
list_acc(N,T) ->
	T.


reverse_list(N) ->
	reverse_list(N,1,[]).
reverse_list(N,I,T) when N>0 ->
	reverse_list(N-1,I+1,[I|T]); %%[NULL|T] error! [T|NUILL] correct!
reverse_list(N,I,T) ->
	T.
