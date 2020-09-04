function nicefigure

% Say no to ugly MATLAB figures :3

AllFigure = findall(0, 'Type', 'figure');

AllText = findall(0, 'Type', 'text');
set(AllText, 'Interpreter', 'latex', 'FontSize', 15);

AllAxes = findall(0, 'Type', 'axes');
for i = 1:numel(AllAxes)
    set(AllAxes(i), 'ticklabelinterpreter', 'latex', 'FontSize', 15, 'box', 'on')
    set(AllAxes(i).XLabel, 'FontSize', 16);
    set(AllAxes(i).YLabel, 'FontSize', 16)
    AllAxes(i).Title.FontSize = 16;
end

AllLegend = findall(0, 'Type', 'legend');
set(AllLegend, 'Interpreter', 'latex', 'FontSize', 14);
for j = 1:numel(AllLegend)
    set(AllLegend(j).Title, 'Interpreter', 'latex', 'FontSize', 15);
end

AllLines = findall(0, 'Type', 'line');
set(AllLines, 'LineWidth', 1.0, 'MarkerSize', 7.5);

AllConsLines = findall(0, 'Type', 'constantline');
set(AllConsLines, 'LineWidth', 1.0);

AllTextBox = findall(0, 'Type', 'textbox');
set(AllTextBox, 'Interpreter', 'latex', 'FontSize', 15, 'LineStyle', 'none');

end

