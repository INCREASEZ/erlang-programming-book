%% @author zhangz
%% @doc @todo Add description to boolean.


-module(boolean).
-behaviour(application).
-export([start/2, stop/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).
-export([b_not/1,b_and/2,b_or/2,b_nand/2]).


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


%%
b_not(X) ->
	case X of
		true -> false;
		false -> true
	end.
b_and(X,Y)->
	case X of
		false -> false;
		true ->
			case Y of
				false -> false;
				true -> true
			end
	end.
b_or(X,Y)->
	case X of
		true -> true;
		false ->
			case Y of
				false -> false;
				true -> true
			end
	end.
b_nand(X,Y)->
	b_not(b_and(X,Y)).
	


%% ====================================================================
%% Internal functions
%% ====================================================================


