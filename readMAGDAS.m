function GM = readMAGDAS(StartDate, EndDate, StnCode, SamplingPeriod, FileNameFormat, Opts)

% Reads MAGDAS geomagnetic field data. Read more about the data: http://magdas2.serc.kyushu-u.ac.jp/
%
% Output argument
%   GM (1x5 table)                              : {Extracted geomagnetic field data}                              
%
% Required input arguments (with examples)
%   StartDate (1x3 double)                      : [2012, 01, 20]
%   EndDate (1x3 double)                        : [2012, 01, 27]
%   StnCode (1x3 char)                          : 'CEB'
%   SamplingPeriod (in seconds | 1x1 double)    : 1
%   FileNameFormat (char vector)                : 'psec.sec'
%
% Optional input arguments of name-value pairs
% Pass arguments like this: readMAGDAS(..., 'Name', Value, ...)
%   FolderPath (1xn char)                       : 'D:\OneDrive\Data' (default: current MATLAB directory) 
%   DataFormat (1xn char)                       : '%4d-%02d-%02d %02d:%02d:%02d.000 %3d %9.2f %9.2f %9.2f %9.2f' (default)
%   HeaderLine (1x1 double)                     : 13 (default) | skip until after this line number when scanning for the data
%   RemOutlier (1x1 logical)                    : false (default) | removes outliers
%   Preview (1x1 logical)                       : false (default) | preview the data
%
% Written by Adib Yusof (2020) | mkhairuladibmyusof@gmail.com

arguments
    StartDate (1,3) double
    EndDate (1,3) double
    StnCode (1,3) char
    SamplingPeriod (1,1) double
    FileNameFormat (1,:) char
    Opts.FolderPath (1,:) char = pwd
    Opts.DataFormat (1,:) char = '%4d-%02d-%02d %02d:%02d:%02d.000 %3d %9.2f %9.2f %9.2f %9.2f'
    Opts.HeaderLine (1,1) double = 13
    Opts.RemOutlier (1,1) logical = false
    Opts.Preview (1,1) logical = false
end

home; tic; 
StnCode = char(StnCode); FileNameFormat = char(FileNameFormat); Opts.FolderPath = char(Opts.FolderPath); Opts.DataFormat = char(Opts.DataFormat);
UTC(:, 1) = datetime(StartDate) : seconds(SamplingPeriod) : datetime(EndDate) + days(1) - seconds(1);
[H, D, Z, F] = deal( NaN(numel(UTC), 1) );
DataIdx = 1;
IndxIncrement = (86400 / SamplingPeriod) - 1;
FileNameFormat = ['%3s%04d%02d%02d', FileNameFormat];
if ~ exist(Opts.FolderPath, 'dir') error('Folder path does not exist.'); end
TotalFileExist = 0;

if Opts.FolderPath(end) == '\' Opts.FolderPath(end) = []; end
PathList = regexp(path, pathsep, 'Split');
IsMATLABPath = ismember(Opts.FolderPath, PathList);
warning('off'); addpath(Opts.FolderPath); warning('on');
Opts.FolderPath = [Opts.FolderPath, '\']; %#ok<*SEPEX>

TotalDays = datenum(EndDate) - datenum(StartDate) + 1;
Progress = 0; DayCount = 1;
fprintf('Extracting data of MAGDAS %s station from %s until %s...\n', StnCode, datetime(StartDate), datetime(EndDate));

% Extraction
for i = datetime(StartDate) : datetime(EndDate)
    ProgressPercent = round(100*(DayCount / TotalDays), -1);
    if ~ rem(ProgressPercent, 10) && ProgressPercent > Progress
        home;
        fprintf('Extracting data of MAGDAS %s station from %s until %s...\n', StnCode, datetime(StartDate), datetime(EndDate));
        fprintf('Progress: %s %d%%\n', repelem('-', ProgressPercent / 10), ProgressPercent);
        Progress = ProgressPercent;
    end
    DayCount = DayCount + 1;
    
    DateAsVector = datevec(i);
    FileName = sprintf(FileNameFormat, StnCode, DateAsVector);
    FullFilePath = [Opts.FolderPath, FileName];
    FileID = fopen(FullFilePath);
    if FileID < 0
        DataIdx = DataIdx + IndxIncrement + 1;
        continue;
    end

    ExtractedData = textscan(FileID, Opts.DataFormat, 'HeaderLines', Opts.HeaderLine);
    [H(DataIdx:DataIdx+IndxIncrement), D(DataIdx:DataIdx+IndxIncrement), Z(DataIdx:DataIdx+IndxIncrement), F(DataIdx:DataIdx+IndxIncrement)] = ExtractedData{end-3:end};
    
    DataIdx = DataIdx + IndxIncrement + 1;
    TotalFileExist = TotalFileExist + 1;
    fclose(FileID);
end

GM = table(UTC, H, D, Z, F);
GM.Properties.Description = [StnCode, ' station data obtained from MAGDAS.'];
Components = GM.Properties.VariableNames(2:end);
if ~ IsMATLABPath rmpath(Opts.FolderPath(1:end-1));  end
if all(isnan(GM.H)) warning('No file was extracted. Please check that all parameters have been entered correctly.'); end
fprintf('Extraction finished after %.2f seconds.\n%d out of %d files were found and extracted (%.2f%%).\n', toc, TotalFileExist, TotalDays, 100*TotalFileExist/TotalDays);

% Additional functionalities
if Opts.RemOutlier && exist('GM', 'var')
    for i = 1:numel(Components)
        OutlierThres = nanmean(GM.(Components{i})) + 10*nanstd(GM.(Components{i}));
        GM.(Components{i})( GM.(Components{i}) > OutlierThres ) = NaN;
    end
end

if Opts.Preview && exist('GM', 'var')
    FigHandle = figure; %#ok<*NASGU>
    Axes = cell(size(Components));
    for i = 1:numel(Components)
        Axes{i} = subplot(numel(Components),1,i); 
        plot(GM.UTC, GM.(Components{i}));
        ylabel([Components{i}, ' (nT)']);
        if i < numel(Components) xticklabels([]); end
        linkaxes([Axes{:}], 'x');
    end
    try nicefigure('PanelLabel', false); catch end
end

end