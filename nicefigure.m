function nicefigure(Opts)

% Improve the quality of figures, e.g., bigger texts, thicker lines, using latex interpreter etc
% 
% Syntax
%   nicefigure              :  Transform all current figures at once
%
%   Name-value pairs (for granular customization)
%       -- Selection for figures
%       FigHandle           : scalar figure handle (default: all active figures)
%       -- Font size (refer the arguments block in the code to see default values)
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
%       >> If you are using math equations in any parts of your figure, make sure they are enclosed within $...$ and follow LaTeX syntax, e.g., $E = mc^{2}$ 
%       -- Show alphabetical panel labels
%       PanelLabel          : scalar logical (default: true)
%   
% Written by Adib Yusof (2020) | mkhairuladibmyusof@gmail.com

arguments
    Opts.FigHandle = findall(0, 'Type', 'figure')
    Opts.TextSize (1,1) double = 17
    Opts.TickSize (1,1) double = 17
    Opts.LabelSize (1,1) double = 17
    Opts.TitleSize (1,1) double = 18
    Opts.TextLegendSize (1,1) double = 16
    Opts.TitleLegendSize (1,1) double = 17
    Opts.ConsLineSize (1,1) double = 17
    Opts.TextboxSize (1,1) double = 17
    Opts.HeatmapSize (1,1) double = 17
    Opts.ColorbarSize (1,1) double = 17
    Opts.PanelLabel (1,1) logical = true
end

AllText = findall(Opts.FigHandle, 'Type', 'text');
set(AllText, 'Interpreter', 'latex', 'FontSize', Opts.TextSize);

if Opts.PanelLabel
    for i = 1:numel(Opts.FigHandle)
        clearvars PanelLabelHndl
        CurrentFig = Opts.FigHandle(i);
        ExistingLabel = findall(CurrentFig, 'Tag', 'PanelLabel');
        delete(ExistingLabel);
        AxInFig = vertcat( findall(CurrentFig, 'Type', 'axes'), findall(CurrentFig, 'Type', 'heatmap') ) ;
        LetterCode = 97;        % Code 97 corresponds to letter 'a' in ASCII
        
        Positions = arrayfun(@(X) X.Position, AxInFig, 'UniformOutput', false);     % If the axes are arranged vertically, label them from bottom to top
        Lefts = cellfun(@(X) X(1), Positions);
        Bottoms = cellfun(@(X) X(2), Positions);
        IsVertStacked = all(round(Lefts(1), 2) == round(Lefts, 2));
        if IsVertStacked
            AxesOrder = numel(AxInFig):-1:1;
        else
            AxesOrder = 1:numel(AxInFig);
        end
        
        for j = AxesOrder
            AxOuter = AxInFig(j).InnerPosition;
            LblPosition = [AxOuter(1)-0.010, AxOuter(2)+0.88*AxOuter(4), 0.04, 0.04 ];     % [left, bottom, width, height]
            LblText = ['(', LetterCode, ')'];
            PanelLabelHndl{j} = annotation(CurrentFig, 'textbox', 'String', LblText, 'FontSize', Opts.TextboxSize, 'Position', LblPosition, 'Units', 'normalized', 'LineStyle', 'none', 'Interpreter', 'latex',...
                'FitBoxToText', 'on', 'VerticalAlignment', 'middle', 'HorizontalAlignment', 'center', 'Tag', 'PanelLabel'); %#ok<AGROW>
            LetterCode = LetterCode + 1;
        end
        
     
    end
end

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

