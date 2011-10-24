-module(monitor_translate).
-export([loop/0]).
loop() ->
    process_flag(trap_exit, true), 
    receive
        new ->
            io:format("Creating and monitoring process.~n"),
            register(translator, spawn_link(fun translate:loop/0)),
            loop();
        {'EXIT', From, Reason} -> 
            case Reason of
              translator ->
                io:format("The translator ~p died with reason ~p.", [From, Reason]),
	        io:format(" Restarting. ~n"),
                self() ! new, 
                loop();
              doctor ->
                io:format("The doctor ~p died with reason ~p.", [From, Reason]),
	        io:format(" Restarting. ~n"),
                exit(whereis(translator), translator),
                Zombie = spawn(fun monitor_translate:loop/0),
                Zombie ! new 
             end   
        end.
