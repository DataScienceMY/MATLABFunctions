function NewFig = subplot2tiled(Rows, Cols, OldFig, Opts)

% Convert subplot to tiledlayout
% 
% Syntax
% NewFig = subplot2tiled(Rows, Cols, OldFig, Opts)
%   
%   NewFig          : Handle of the newly generated figure
%   Rows            : The number of rows in the subplot/tiledlayout
%   Cols            : The number of columns in the subplot/tiledlayout
%   OldFig          : (Optional) The figure handle which contains the subplot
%
%   Name-Value pairs (optional)
%   TileSpacing     : 'none', 'compact'
%   Padding         : 'none', 'compact'
%
% Written by Adib Yusof (2020) | mkhairuladibmyusof@gmail.com

arguments
   Rows (1,1) double
   Cols (1,1) double
   OldFig = gcf
   Opts.TileSpacing char = 'none'
   Opts.Padding char = 'compact'
end

Ax = findall(OldFig, 'Type', 'axes');
if numel(Ax) ~= Rows*Cols
   error('Rows x Cols doesn''t match the number of axes in the original figure.')
end
if numel(Ax) <= 1
   error('No subplots are found.');
end

NewFig = figure;
TL = tiledlayout(NewFig, Rows, Cols, 'TileSpacing', Opts.TileSpacing, 'Padding', Opts.Padding);
for i = numel(Ax) : -1 : 1
    Tile = nexttile;
    
    copyobj(Ax(i).Children, Tile)
    
    title(Ax(i).Title.String);
    xlabel(Ax(i).XLabel.String);
    ylabel(Ax(i).YLabel.String)

    if ~isempty(Ax(i).Legend)
        Lgd = legend;
        Lgd.String = Ax(i).Legend.String;
        Lgd.Title.String = Ax(i).Legend.Title.String;
    end
    if ~isempty(Ax(i).Colorbar)
        Colbar = colorbar;
        Colbar.Colormap = Ax(i).Colormap;
    end
end
end