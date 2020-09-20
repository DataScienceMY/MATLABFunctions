function nicefigure(Opts)

% Improve the quality of figures, e.g., bigger texts, thicker lines, using latex interpreter etc
% 
% Syntax
%   nicefigure              :  Transform all current figures at once
%
%   Name-value pairs (granular customization)
%       -- Selection fo figures
%       FigHandle           : scalar figure handle (default: all active figures)
%       -- Font size for individual item 
%       TextSize            : scalar double 
%       TickSize            : scalar double 
%       LabelSize           : scalar double 
%       TitleSize           : scalar double
%       TextLegendSize      : scalar double 
%       TitleLegendSize     : scalar double 
%       ConsLineSize        : scalar double 
%       TextboxSize         : scalar double 
%       HeatmapSize         : scalar double 
%       ColorbarSize        : scalar double
%   
%   >> If you are using math equations in any parts of your figure, make sure they are enclosed within $...$ and follow LaTeX syntax, e.g., $E = mc^{2}$ 
%
% Written by Adib Yusof (2020) | mkhairuladibmyusof@gmail.com

arguments
    Opts.FigHandle = findall(0, 'Type', 'figure')
    Opts.TextSize (1,1) double = 18
    Opts.TickSize (1,1) double = 17
    Opts.LabelSize (1,1) double = 18
    Opts.TitleSize (1,1) double = 20
    Opts.TextLegendSize (1,1) double = 15
    Opts.TitleLegendSize (1,1) double = 16
    Opts.ConsLineSize (1,1) double = 18
    Opts.TextboxSize (1,1) double = 18
    Opts.HeatmapSize (1,1) double = 17
    Opts.ColorbarSize (1,1) double = 17
end

AllText = findall(Opts.FigHandle, 'Type', 'text');
set(AllText, 'Interpreter', 'latex', 'FontSize', Opts.TextSize);

AllAxes = findall(Opts.FigHandle, 'Type', 'axes');
for i = 1:numel(AllAxes)
    set(AllAxes(i), 'TickLabelInterpreter', 'latex', 'FontSize', Opts.TickSize, 'box', 'on')
    set(AllAxes(i).XLabel, 'FontSize', Opts.LabelSize);
    set(AllAxes(i).YLabel, 'FontSize', Opts.LabelSize)
    AllAxes(i).Title.FontSize = Opts.TitleSize;
end

AllLegend = findall(Opts.FigHandle, 'Type', 'legend');
set(AllLegend, 'Interpreter', 'latex', 'FontSize', Opts.TextLegendSize);
for j = 1:numel(AllLegend)
    set(AllLegend(j).Title, 'Interpreter', 'latex', 'FontSize', Opts.TitleLegendSize);
end

AllLines = findall(Opts.FigHandle, 'Type', 'line');
set(AllLines, 'LineWidth', 1.1, 'MarkerSize', 7.5);

AllConsLines = findall(Opts.FigHandle, 'Type', 'constantline');
set(AllConsLines, 'LineWidth', 1.4, 'Interpreter', 'latex', 'FontSize', Opts.ConsLineSize);

AllTextBox = findall(Opts.FigHandle, 'Type', 'textbox');
set(AllTextBox, 'Interpreter', 'latex', 'FontSize', Opts.TextboxSize, 'LineStyle', 'none');

AllHeatmap = findall(Opts.FigHandle, 'Type', 'heatmap');
set(AllHeatmap, 'FontName', 'Century', 'FontSize', Opts.HeatmapSize, 'GridVisible', 'off');

AllColorbar = findall(Opts.FigHandle, 'Type', 'colorbar');
set(AllColorbar, 'FontSize', Opts.ColorbarSize);
if ~ isempty(AllColorbar)
    for i = 1:numel(AllColorbar)
        AllColorbar(i).Label.Interpreter = 'latex';
        AllColorbar(i).TickLabelInterpreter = 'latex';
    end
end
end

