function [svgDataSimple, svgData, svg] = vectorizeLineSmart(bitmap)
%Converts a bitmap line drawing into a set of coordinates writeable to svg
%   
%   EXAMPLE: 
%       svgDataSimple = vectorizeLineSmart(bitmap);
%       [svgDataSimple, svgData] = vectorizeLineSmart(bitmap);
%   IN: 
%       bitmap - a 2D logical matrix, i.e. a background of value=0 and
%           lines of value=1.
%
%   OUT: 
%       svgDataSimple - a list of simplified coordinate pairs to draw lines between,
%           formatted to be readable in an svg file
%       svgData - OPTIONAL - a complete list of coordinate pairs
%
%   This function attempts to reduce the number of nodes necessary in the
%   svg file. Lines drawn in one of the 8 cardinal or intercardinal
%   directions should be calculated as a single line rather than many short
%   lines


bitmap = im2binary(bitmap);
bitmapPadded = padarray(bitmap,[1,1]);

[ySize, xSize] = size(bitmap);

svgData = zeros(4,1);
svgDataSimple = zeros(4,1);
dataNum = 1;
dataNum2 = 1;
entry = 1;
svg = zeros(1,1);

%search
for y=1:ySize
    for x=1:xSize
        %tally adjancencies
        adj = -1;
        if bitmap(y,x)==1
            for j=-1:1
                for i=-1:1
                    if bitmapPadded(y+j+1,x+i+1) == 1
                        adj = adj + 1;
                    end
                end
            end
        end
        
        %end points
        if adj==1 || 3<=adj
            for asdf=1:adj
                y2=y;
                x2=x;
                xL=x;
                yL=y;
                firstFlag=true;
                headingOld = [2,2]; %impossible
                exFlag = false;
                connection=1;
                while ~exFlag
                    exFlag = true;
                    for j=-1:1
                        if(exFlag == false)
                            break
                        end
                        for i=-1:1
                            dupeFlag = false;
                            if bitmapPadded(y2+j+1,x2+i+1) == 1 && ~isequal([j,i],[0,0])
                                for n=1:size(svgData,2)
                                    if isequal(svgData(:,n),[x2;y2;x2+i;y2+j]) || isequal(svgData(:,n),[x2+i;y2+j;x2;y2])
                                        dupeFlag = true;
                                        break
                                    end
                                end

                                if dupeFlag == false
                                    headingNew = [i,j];
                                    
                                    if ~isequal(headingNew, headingOld) && ~firstFlag
                                        svgDataSimple(:,dataNum2) = [xL;yL;x2;y2];
                                        dataNum2 = dataNum2 + 1;
                                        headingOld = headingNew;
                                        svg(entry,connection)=xL;
                                        svg(entry,connection+1)=yL;
                                        connection = connection+2;
                                        xL = x2;
                                        yL = y2;
                                    end

                                    exFlag = false;

                                    svgData(:,dataNum) = [x2;y2;x2+i;y2+j];

                                    firstFlag = false;

                                    dataNum = dataNum + 1;

                                    y2 = y2 + j;
                                    x2 = x2 + i;
                                    break
                                end
                            end
                        end
                    end
                end                   
                if ~firstFlag
                    svgDataSimple(:,dataNum2) = [xL;yL;x2;y2];
                    svg(entry,connection)=xL;
                    svg(entry,connection+1)=yL;
                    svg(entry,connection+2)=x2;
                    svg(entry,connection+3)=y2;
                    dataNum2 = dataNum2 + 1;
                    entry = entry + 1;
                end
            end
        end
    end
end

end
