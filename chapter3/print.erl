%% @author zhangz
%% @doc @todo Add description to print.


-module(print).
-behaviour(application).
-export([start/2, stop/1, print/1, print_times/1, print_even/1]).

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
print(N) when N>0 ->
	print(1,N,[]).
print(M,N,T) when M =< N ->
	print(M,N-1,[N|T]);
print(M,N,T) ->
	T.


print_even(N) when N>0 ->
	print_even(1,N).

print_even(N,M) when (N rem 2 == 0),(N=<M) ->
						io:format("Number: ~p~n", [N]),
						print_even(N+1,M);
print_even(N,M) when N =< M-> 
		print_even(N+1,M);
print_even(N,M) when N>M ->
	ok.
%%==============
print_times(N) when N > 0 ->
    print_times(1, N).


print_times(N, M) ->
    io:format("Number: ~p~n", [N]),
    if
        N < M -> print_times(N + 1, M);
        true  -> ok %% avoid the "exception error: no true branch found when evaluating an if expression"
    end.

