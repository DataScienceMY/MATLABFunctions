function nicefigure(f)

% Made by Adib Yusof (2020) | The only place ugly MATLAB figures belong to is Recycle Bin :p
% 
% Syntax
%   nicefigure          :  Transform all current figures at once
%   nicefigure(f)       :  Transform only one figure which specified by its handle f
%   
%   *If you are using math equations in any parts of your figure, make sure they are enclosed within $...$ and follow LaTeX syntax, e.g., $E = mc^{2}$ 

arguments
   f = findall(0, 'Type', 'figure')
end

AllText = findall(f, 'Type', 'text');
set(AllText, 'Interpreter', 'latex', 'FontSize', 16);

AllAxes = findall(f, 'Type', 'axes');
for i = 1:numel(AllAxes)
    set(AllAxes(i), 'ticklabelinterpreter', 'latex', 'FontSize', 15, 'box', 'on')
    set(AllAxes(i).XLabel, 'FontSize', 16);
    set(AllAxes(i).YLabel, 'FontSize', 16)
    AllAxes(i).Title.FontSize = 16;
end

AllLegend = findall(f, 'Type', 'legend');
set(AllLegend, 'Interpreter', 'latex', 'FontSize', 14);
for j = 1:numel(AllLegend)
    set(AllLegend(j).Title, 'Interpreter', 'latex', 'FontSize', 15);
end

AllLines = findall(f, 'Type', 'line');
set(AllLines, 'LineWidth', 1.1, 'MarkerSize', 7.5);

AllConsLines = findall(f, 'Type', 'constantline');
set(AllConsLines, 'LineWidth', 1.4, 'Interpreter', 'latex', 'FontSize', 15);

AllTextBox = findall(f, 'Type', 'textbox');
set(AllTextBox, 'Interpreter', 'latex', 'FontSize', 15, 'LineStyle', 'none');

AllHeatmap = findall(f, 'Type', 'heatmap');
set(AllHeatmap, 'FontName', 'Century', 'FontSize', 15, 'GridVisible', 'off');

AllColorbar = findall(f, 'Type', 'colorbar');
set(AllColorbar, 'FontSize', 15);
if ~ isempty(AllColorbar)
    for i = 1:numel(AllColorbar)
        AllColorbar(i).Label.Interpreter = 'latex';
        AllColorbar(i).TickLabelInterpreter = 'latex';
    end
end
end

