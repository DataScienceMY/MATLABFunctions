function runtimeProgress(Type, Opts)

% A simple program to display the progress of runtime
%
% Written by Adib Yusof (2020) | mkhairuladibmyusof@gmail.com

arguments
    Type (1,:) char {mustBeMember(Type, {'Percentage', 'Timer', 'Index'})} = 'Percentage'
    Opts.Current (1,1) double = NaN
    Opts.Last (1,1) double = NaN
    Opts.Task (1,:) char = 'Task'
end

if any(strcmp(Type, {'Percentage', 'Index'})) && ( any(isnan([Opts.Current, Opts.Last])) )
    error("'Current' and 'Last' arguments need to be specified for 'Percentage' or 'Index' types.");
end

switch Type
    case 'Percentage'
        Intervals = [1, floor(Opts.Last/10) : floor(Opts.Last/10) : Opts.Last];
        if any(Opts.Current == Intervals)
            fprintf('%s: %.0f%% completed at %s.\n', Opts.Task, ...
                (find(Opts.Current == Intervals)-1)*10, datetime);
        elseif Opts.Current == Opts.Last
            fprintf('%s: %.0f%% completed at %s.\n', Opts.Task, ...
                100, datetime);
        end
        
    case 'Index'
        fprintf('%s: (%03d/%03d) completed at %s.\n', Opts.Task, Opts.Current, Opts.Last, datetime);
        
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
        fprintf('%s: Completed after %.1f %s at %s.\n', Opts.Task, ...
            Time, Unit, datetime); 
end

end

