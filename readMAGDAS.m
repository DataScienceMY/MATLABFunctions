function GM = readMAGDAS(StartDate, EndDate, StnCode, SamplingPeriod, FileNameFormat, FolderPath, DataFormat, HeaderLine)

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
% Optional input arguments (with default values)
%   FolderPath (1xn char)                       : 'D:\OneDrive\Data' (default: current MATLAB directory) 
%   DataFormat (1xn char)                       : '%4d-%02d-%02d %02d:%02d:%02d.000 %3d %9.2f %9.2f %9.2f %9.2f' (default)
%   HeaderLine (1x1 double)                     : 13 (default)
%
% Written by Adib Yusof (2020) | mkhairuladibmyusof@gmail.com

arguments
    StartDate (1,3) double
    EndDate (1,3) double
    StnCode (1,3) char
    SamplingPeriod (1,1) double
    FileNameFormat (1,:) char
    FolderPath (1,:) char = pwd
    DataFormat (1,:) char = '%4d-%02d-%02d %02d:%02d:%02d.000 %3d %9.2f %9.2f %9.2f %9.2f'
    HeaderLine (1,1) double = 13
end

clc; tic; 
StnCode = char(StnCode); FileNameFormat = char(FileNameFormat); FolderPath = char(FolderPath); DataFormat = char(DataFormat);
UTC(:, 1) = datetime(StartDate) : seconds(SamplingPeriod) : datetime(EndDate) + days(1) - seconds(1);
[H, D, Z, F] = deal( NaN(numel(UTC), 1) );
DataIdx = 1;
IndxIncrement = (86400 / SamplingPeriod) - 1;
FileNameFormat = ['%3s%04d%02d%02d', FileNameFormat];
if FolderPath(end) ~= '\'     FolderPath = [FolderPath, '\'];     end %#ok<*SEPEX>
if ~ exist(FolderPath, 'dir')     error('Folder path does not exist.');    end
warning('off'); addpath(FolderPath); warning('on');
TotalDays = datenum(EndDate) - datenum(StartDate) + 1;
fprintf('Extracting data of MAGDAS %s station from %s until %s...\n', StnCode, datetime(StartDate), datetime(EndDate));
Progress = 0; DayCount = 1;

for i = datetime(StartDate) : datetime(EndDate)
    DateAsVector = datevec(i);
    FileName = sprintf(FileNameFormat, StnCode, DateAsVector);
    FullFilePath = [FolderPath, FileName];
    FileID = fopen(FullFilePath);
    if FileID < 0
        continue;
    end

    ExtractedData = textscan(FileID, DataFormat, 'HeaderLines', HeaderLine);
    [H(DataIdx:DataIdx+IndxIncrement), D(DataIdx:DataIdx+IndxIncrement), Z(DataIdx:DataIdx+IndxIncrement), F(DataIdx:DataIdx+IndxIncrement)] = ExtractedData{end-3:end};
    
    DataIdx = DataIdx + IndxIncrement + 1;
    fclose(FileID);
    
    ProgressPercent = round(100*(DayCount / TotalDays), -1);
    if ~ rem(ProgressPercent, 10) && ProgressPercent > Progress
        clc;
        fprintf('Extracting data of MAGDAS %s station from %s until %s...\n', StnCode, datetime(StartDate), datetime(EndDate));
        fprintf('Progress: %s %d%%\n', repelem('-', ProgressPercent / 10), ProgressPercent);
        Progress = ProgressPercent;
    end
    DayCount = DayCount + 1;
end
GM = table(UTC, H, D, Z, F);
GM.Properties.Description = [StnCode, ' station data obtained from MAGDAS.'];
fprintf('Extraction finished after %.2f seconds.\n', toc);
end