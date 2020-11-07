function runtimeProgress(Type, Opts)

arguments
    Type (1,:) char {mustBeMember(Type, {'Percentage', 'Timer'})} = 'Percentage'
    Opts.Current (1,1) double = NaN
    Opts.Last (1,1) double = NaN
    Opts.TaskName (1,:) char = 'Task'
end

if strcmp(Type, 'Percentage') && ( any(isnan([Opts.Current, Opts.Last])) )
    error("'Current' and 'Last' arguments need to be specified for 'Percentage'");
end

switch Type
    case 'Percentage'
        Intervals = [1, floor(Opts.Last/10) : floor(Opts.Last/10) : Opts.Last];
        if Opts.Current == any(Intervals)
            fprintf('%s: %.2f%% completes at %s.\n', Opts.Task, ...
                (find(Opts.Current == Intervals)-1)*10, datetime);
        elseif Opts.Current == Opts.Last
            fprintf('%s: %.2f%% completes at %s.\n', Opts.Task, ...
                100, datetime);
        end
    case 'Timer'
        Sec = toc;
        if Sec < 60
            Time = Sec;
            Unit = 'seconds';
        elseif Sec >= 60 && Sec < 3600
            Time = Sec / 60;
            Unit = 'minutes';
        else
            Time = Sec / 3600;
            Unit = 'hours';
        end
        fprintf('%s: Completes after %.2f %s at %s.\n', Opts.Task, ...
            Time, Unit, datetime);
end


end

