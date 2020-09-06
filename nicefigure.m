function nicefigure

% Made by Adib Yusof (2020) | The only place ugly MATLAB figures belong to is Recycle Bin :3
% Call this function from command window or in your script to turn all current existing figures into nicer ones; 'nicer' according to me at least
% If you are using math equations in any parts of your figure, make sure they are enclosed within $...$ and follow LaTeX syntax, e.g., $E = mc^{2}$ 

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
set(AllLines, 'LineWidth', 1.1, 'MarkerSize', 7.5);

AllConsLines = findall(0, 'Type', 'constantline');
set(AllConsLines, 'LineWidth', 1.2);

AllTextBox = findall(0, 'Type', 'textbox');
set(AllTextBox, 'Interpreter', 'latex', 'FontSize', 15, 'LineStyle', 'none');

end

