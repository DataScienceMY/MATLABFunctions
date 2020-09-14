function PatchHndl = plotpatch(X, Color, Alpha, AxesHndl)

% Shade the background of a plot with a desired color 
% 
%   PatchHndl = plotpatch(X, Color, Alpha, AxesHndl)
%
%   PatchHndl (patch object)                             : Handle of the patch object
%   X (integer or daily datetime 1xn vector)             : X points to be shaded
%   Color (char or 1x3 numeric vector, optional)         : Shading color       
%   Alpha (numeric 0 - 1, optional)                      : Transparency of shading
%   AxesHndl (axes handle, optional)                     : Axis to be shaded
%
% Made by Adib Yusof (2020) | mkhairuladibmyusof@gmail.com


arguments
    X (1, :)   
    Color = 'r'
    Alpha (1, 1) double = 0.1
    AxesHndl matlab.graphics.axis.Axes = gca 
end

if isdatetime(X)
   LineObj = findobj(AxesHndl, 'Type', 'line');
   XPts = LineObj(1).XData;
   X = find(ismember(XPts, X));
end

PrevYLim = AxesHndl.YLim;

XMat(1, :) = X-1;
XMat(2, :) = X;
XMat(3, :) = X;
XMat(4, :) = X-1;

YMat = NaN(size(XMat));
YMat(1, :) = deal(-1e5);
YMat(2, :) = deal(-1e5);
YMat(3, :) = deal(+1e5);
YMat(4, :) = deal(+1e5);

PatchHndl = patch(XMat, YMat, Color, 'HandleVisibility', 'off', 'FaceAlpha', Alpha, 'LineStyle', 'none');
try
    uistack(PatchHndl, 'bottom');
catch ME
    disp('Patch object couldn''t be arranged to the bottom.');
end

ylim(PrevYLim);

end