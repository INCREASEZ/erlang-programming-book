-module(echo).
-export([go/0,loop/0,go2/0,loop2/0]).

go()->
	Pid=spawn(echo,loop,[]),
	Pid ! {self(),hello},
	receive
		{Pid,Msg} ->
			io:format("~w~n",[Msg])
	end,
	Pid !stop.

loop()->
	receive
		{From,Msg}->
			From!{self(),Msg},
			loop();
		stop ->
			true
	end.
	
	
go2()->
	register(echo,spawn(echo,loop,[])),
	echo ! {self(),hello},
	receive
		{_Pid,Msg} ->
			io:format("~w~n",[Msg])
	end.

loop2()->
	receive
		{From,Msg}->
			From!{self(),Msg},
			loop();
		stop ->
			true
	end.