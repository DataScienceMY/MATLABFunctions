function yNew = despline(y, Interval)   % Interval, or knot points
yTemp = y(~isnan(y));
xTemp = (1:numel(yTemp))';
xInterval = 1:Interval:xTemp(end);
yInterval = spline(xTemp, yTemp, xInterval);
ySpline = interp1(xInterval, yInterval, xTemp, 'spline');
yDesplined = yTemp - ySpline;
yNew = NaN(size(y));
yNew(~isnan(y)) = yDesplined;
end

