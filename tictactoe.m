function tictactoe

% A simple tic-tac-toe game I made just for fun
% 
% Made by Adib Yusof (2020) | mkhairuladibmyusof@gmail.com

clc; clear;
Board = {' ', ' ', ' '; ' ', ' ', ' '; ' ', ' ', ' '};
Step = 1;
WinningState = 0;
while(Step < 10)
    
    disp(Board)
    
    % Receive player inputs
    if mod(Step,2)
        Position = input('Player #1 - Put an X ','s');
    else
        Position = input('Player #2 - Put an O ','s');
    end
    
    if length(Position) ~= 2
        disp('Invalid position. Try again.')
        continue;
    end
    
    PositionRow = str2num(Position(1)); PositionCol = str2num(Position(2));
    
    % Input validationn
    if PositionRow > 3 || PositionCol > 3 || PositionRow < 1 || PositionCol < 1
        disp('Invalid position. Try again.')
        continue;
    end
    if strcmp(Board(PositionRow, PositionCol),'X') ||   strcmp(Board(PositionRow, PositionCol),'O')
        disp('Invalid position. Try again.')
        continue;
    end
    
    % Inputting positions
    if mod(Step,2)
        Board{PositionRow, PositionCol} = 'X';
    else
        Board{PositionRow, PositionCol} = 'O';
    end
    
    % Check all rows/columns for winning player
    BoardFlip = Board;
    for j = 1:2
        for i = 1:3
            if any(strcmp(BoardFlip(i, :), {' '}))
                continue;
            end
            if (BoardFlip{i, 1} == BoardFlip{i, 2}) && (BoardFlip{i, 2} == BoardFlip{i, 3})
                disp(Board)
                if mod(Step,2)
                    disp('Player #1 (X) wins. Game over.')
                else
                    disp('Player #2 (O) wins. Game over.')
                end
                WinningState = 1;
                break;
            end
        end
        BoardFlip = Board';
        if(WinningState) break; end
    end
    
    % Check both diagonals for winning player
    BoardFlip = Board;
    for j = 1:2
        if j == 1
            k = [1 3];
        else
            k = [3 1];
        end
        if strcmp(BoardFlip(1,k(1)), {' '}) || strcmp(BoardFlip(2,2), {' '}) || strcmp(BoardFlip(3,k(2)), {' '})
            continue;
        end
        if (BoardFlip{1,k(1)} == BoardFlip{2,2}) && (BoardFlip{2,2} == BoardFlip{3,k(2)})
            disp(Board)
            if mod(Step,2)
                disp('Player #1 (X) wins. Game over.')
            else
                disp('Player #2 (O) wins. Game over.')
            end
            WinningState = 1;
            break;
        end
        if(WinningState) break; end
    end
   
    % Endgame
    if(WinningState) break; end
    Step = Step + 1;
    if Step > 9 
        disp(Board);
        disp('Ties. No winner.'); 
    end
end

end







