function repheatmaptext(FigHandle, Opts)
% (WORK IN PROGRESS) Replacing uncustomizable text of heatmap to custom (latex) texts 

arguments
    FigHandle (1,1) = gcf
    Opts.Precision (1,1) double = 4
end

HMHandle = findall(FigHandle, 'Type', 'heatmap');
if isempty(HMHandle)
   error('Figure doesn''t contain any HeatmapChart object'); 
end

delete(findall(FigHandle, 'Tag', 'CustomText'));
for i = 1:numel(HMHandle) 
    HMHandle(i).FontColor = 'none';
    HMHandle(i).CellLabelColor = 'none';
    
    CData = round(HMHandle(i).ColorData, Opts.Precision);
    CData = ["$" + string(CData) + "$"];
    
    XData = HMHandle(i).XData;
    YData = HMHandle(i).YData;
    
    Pos = HMHandle(i).Position; % [left, bottom, width, height]
    CellSize = [Pos(3)/numel(XData), Pos(4)/numel(YData)];
    
    XPos = Pos(1) + (0:numel(XData)-1)*Pos(3)/numel(XData);
    for j = 1:numel(XData)
       annotation(FigHandle, 'textbox', 'String', XData{j}, 'Position', [XPos(j), 0.95*Pos(2), CellSize], 'VerticalAlignment', 'baseline',...
            'HorizontalAlignment', 'center', 'Tag', 'CustomText', 'LineStyle', 'none');
    
    end
   
    YPos = Pos(2) + (0:numel(YData)-1)*Pos(4)/numel(YData);
    for j = 1:numel(YData)
        annotation(FigHandle, 'textbox', 'String', YData{end+1-j}, 'Position', [0.88*Pos(1), YPos(j), CellSize], 'VerticalAlignment', 'middle',...
            'HorizontalAlignment', 'left', 'Tag', 'CustomText', 'LineStyle', 'none');
    end
    
    for j = 1:size(CData, 1)
        for k = 1:size(CData, 2)
            annotation(FigHandle, 'textbox', 'String', CData(end+1-j, k), 'Position', [XPos(k), YPos(j), CellSize], 'VerticalAlignment', 'middle',...
            'HorizontalAlignment', 'center', 'Tag', 'CustomText', 'LineStyle', 'none');
        end
    end
    nicefigure

end


end