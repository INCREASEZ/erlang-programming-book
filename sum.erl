%% @author zhangz
%% @doc @todo Add description to sum.


-module(sum).
-behaviour(application).
-export([start/2, stop/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).
-export([sum/1,sum/2]).


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
sum_acc(Index,N,Sum) when Index =< N ->
	sum_acc(Index+1,N,Index+Sum);
sum_acc(_I,_B,Sum) ->
	Sum.

sum(N) ->
	sum_acc(1,N,0).

sum(N,M) ->
	try (N<M) of 
		Val -> sum_acc(N,M,0)
	 catch 
   		 error:Error -> {error,Error}
	end.



	
