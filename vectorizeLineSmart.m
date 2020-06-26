%IN-PROGRESS
%TODO:


function [svgData] = vectorizeLineSmart(bitmap)
%Converts a bitmap line drawing into a set of coordinates writeable to svg
%   
%   EXAMPLE: 
%       svgData = vectorizeLineDense(bitmap);
%
%   IN: 
%       bitmap - a 2D logical matrix, i.e. a background of value=0 and
%           lines of value=1.
%
%   OUT: 
%       svgData - a list of coordinate pairs to draw lines between,
%           formatted to be readable in an svg file
%
%   This function attempts to reduce the number of nodes necessary in the
%   svg file. Lines drawn in one of the 8 cardinal or intercardinal
%   directions should be calculated as a single line rather than many short
%   lines


bitmap = im2binary(bitmap);

[ySize, xSize] = size(bitmap);

svgData = zeros(4,1);
dataNum = 1;


for y=2:ySize-1
    for x=2:xSize-1

        %tally adjancencies
        adj = -1;
        if bitmap(y,x)==1
            for j=-1:1
                for i=-1:1
                    if bitmap(y+j,x+i) == 1
                        adj = adj + 1;
                    end
                end
            end
        end

        %end points
        if adj==1
            y2=y;
            x2=x;
            exFlag = false;
            while ~exFlag
                exFlag = true;
                for j=-1:1
                    if(exFlag == false)
                        break
                    end
                    for i=-1:1
                        dupeFlag = false;
                        if bitmap(y2+j,x2+i) == 1 && ~isequal([j,i],[0,0])
                            for gg=1:size(svgData,1)
                                if isequal(svgData(gg,:),[y2,x2,y2+j,x2+i]) || isequal(svgData(gg,:),[y2+j,x2+i,y2,x2])
                                    dupeFlag = true;
                                    break
                                end
                            end

                            if dupeFlag == false
                                headingNew = [i,j]
                                doneFlag = false;
                                exFlag = false;

                                if headingNew ~= headingOld
                                svgData(:,dataNum) = [x2;y2;x2+j;y2+i];

                                dataNum = dataNum + 1;
                                %MAKE CONNECTION
                                if(y2<size(bitmap,1)-1 && 1<y2 && 1<x2 && x2<size(bitmap,2)-1)
                                    y2 = y2 + j;
                                    x2 = x2 + i;
                                end
                                break
                            end
                        end
                    end
                end
            end

        end
    end
end
     
end

