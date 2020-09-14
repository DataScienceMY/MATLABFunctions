function Fig = heatmapplus(XData, YData, CData, Opts)

% Create customizable heatmaps
% 
% Syntax
% Fig = heatmapplus(XData, YData, CData, Opts)
%   
%   Fig                     : Figure handle of the heatmap
%   XData                   : Vector of the data of X
%   YData                   : Vector of the data of Y
%   CData                   : Matrix of color data; dimension must match X x Y
% 
%   Name-value pairs (optional)
%   CDisp                   : Display different cells value than defined by CData
%   CMap                    : Function to generate colormap, such as jet, parula, bone etc
%   XLabel, YLabel, CLabel  : Labels for X, Y and C data
%   Precision               : Number of decimal points of CData/CDisp to show
%   NaNDisp                 : Text to label NaN values
%
% Made by Adib Yusof (2020) | mkhairuladibmyusof@gmail.com

arguments
    XData
    YData
    CData double
    Opts.CDisp double = CData
    Opts.CMap = hot
    Opts.XLabel char = '$X$'
    Opts.YLabel char = '$Y$'
    Opts.CLabel char = '$C$'
    Opts.Precision (1,1) double = 0
    Opts.NaNDisp char = '-'
end

if ~isvector(XData) || ~isvector(YData)
    error('XData and YData must be a vector.');
end
if all( [length(XData), length(YData)] == size(CData) )
    error('Matrix dimensions must agree.');
end
if size(Opts.CDisp) ~= size(CData)
    error('The CDisp dimension does not match CData.');
end

Fig = figure;
[X, Y] = meshgrid(XData, YData);          
HM = imagesc( X(:), Y(:), CData );
AxHndl = HM.Parent;
HMLbl = sprintfc( ['%.', num2str(Opts.Precision), 'f'], Opts.CDisp );
for i = 1:size(X, 1)
    for j = 1:size(X, 2)
        if HM.CData(i, j) >= 50
            TxtColor = [0 0 0];
        else
            TxtColor = [1 1 1];
        end
        if isnan(HM.CData(i, j))
            TxtStr = Opts.NaNDisp;
        else
            TxtStr = HMLbl(i, j);
        end
        text(X(i, j), Y(i, j), TxtStr, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Color', TxtColor);
    end
end
Fig.Colormap =  Opts.CMap;
AxHndl.YDir = 'normal';
AxHndl.TickLength = [0 0];
AxHndl.XTick = XData; AxHndl.YTick = YData;
AxHndl.XLabel.String = Opts.XLabel;
AxHndl.YLabel.String = Opts.YLabel;
CBHndl = colorbar;
CBHndl.Label.String = Opts.CLabel;
nicefigure;
end