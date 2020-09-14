function NewFig = subplot2tiled(Rows, Cols, OldFig, Opts)
% Convert subplot to tiledlayout
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
    end
    if ~isempty(Ax(i).Colorbar)
        Colbar = colorbar;
        Colbar.Colormap = Ax(i).Colormap;
    end
    
    
     
 
    
    
  
end



nicefigure
end