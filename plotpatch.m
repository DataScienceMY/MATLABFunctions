function PatchHndl = plotpatch(X, Color, AxesHndl)
%
% Made by Adib Yusof (2020)
% Shade the background of a plot with a desired color 
% 
% Input arguments:
% X (integer or datetime 1xn vector)                  : X points to be shaded
% Color (char or 1x3 numeric vector, optional)        : Shading color       
% AxesHndl (axes handle, optional)                    : Axis to be shaded
%
arguments
    X (1, :)   
    Color = 'r'
    AxesHndl matlab.graphics.axis.Axes = gca 
end

if isdatetime(X)
   LineObj = findobj(AxesHndl, 'Type', 'line');
   XPts = LineObj(1).XData;
   X = find(ismember(XPts, X));
end

PrevYLim = AxesHndl.YLim;

XMat(1, :) = X-1-0.5;
XMat(2, :) = X-1+0.5;
XMat(3, :) = X-1+0.5;
XMat(4, :) = X-1-0.5;

YMat = NaN(size(XMat));
YMat(1, :) = deal(-1e5);
YMat(2, :) = deal(-1e5);
YMat(3, :) = deal(+1e5);
YMat(4, :) = deal(+1e5);

PatchHndl = patch(XMat, YMat, Color, 'HandleVisibility', 'off', 'FaceAlpha', 0.3, 'LineStyle', 'none');
uistack(PatchHndl, 'bottom');

ylim(PrevYLim);

end