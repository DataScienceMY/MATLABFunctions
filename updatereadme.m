function updatereadme
fclose all;
RMID = fopen('README.md', 'r');
Content = textscan(RMID, '%s', 'Delimiter', '\n');
Content = Content{:};
for i = 1:100
    if strcmp(strtrim(Content{i}), '### Functions')
        break;
    end
end
if i == 100
    error('Header couldn''t be determined');
end
HeaderLine = i;
Content = Content(1:HeaderLine);
fclose all;
RMID = fopen('README.md', 'w');
fprintf(RMID, '%s\n', Content{:});
fclose all;
RMID = fopen('README.md', 'at+');

Functions = what;
Functions = Functions.m;
for i = 1:numel(Functions)
    if strcmp(Functions{i}, 'updatereadme.m')
       continue; 
    end
    FileID = fopen(Functions{i}, 'r');
    FunContent = textscan(FileID, '%s', 'Delimiter', '\n');
    FunContent = FunContent{:};
    for j = 1:100
        if ~isempty(FunContent{j}) && strcmp(FunContent{j}(1), '%')
            FunDscrptn = strtrim( FunContent{j}(2:end) );
            break;
        end
    end
    if j < 100
        Whitespaces = repelem(' ', 30-numel(Functions{i}));
        Details = sprintf('- %s%s: %s\n', Functions{i}, Whitespaces, FunDscrptn);
        fprintf(RMID, '%s', Details );
        fclose(FileID);
    else
        warning(sprintf('Description in %s couldn''t be detected', Functions{i}));
    end
end
fclose all;
!git add README.md
!git commit -m "Auto-update"
!git push origin
end