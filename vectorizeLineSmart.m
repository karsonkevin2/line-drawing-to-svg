function [svgIntermediate, svgDataSimple, svgDataDense] = vectorizeLineSmart(image)
%Converts a bitmap line drawing into a set of coordinates writeable to svg
%Use in conjuction with either printSVGpoly.m or printSVG.m
%   
%   EXAMPLE: 
%       svgIntermediate = vectorizeLineSmart('myimage.png');
%       [svgDataIntermediate, svgDataSimple] = vectorizeLineSmart(imageBW);
%       [svgDataIntermediate, svgDataSimple, svgDataDense] = vectorizeLineSmart(imageColor)
%   
%   IN: 
%       image - an image either as logical, colour, or a file extension
%
%   OUT: 
%       svgIntermediate - an array of data to be processed by the
%           printSVGpoly function
%       svgDataSimple - a list of simplified coordinate pairs to draw lines between,
%           formatted to be readable in an svg file
%       svgData - a complete list of coordinate pairs
%
%   This function attempts to reduce the number of nodes necessary in the
%   svg file. Lines drawn in one of the 8 cardinal or intercardinal
%   directions should be calculated as a single line rather than many short
%   lines

image = im2binary(image);
bitmapPadded = padarray(image,[1,1]);

[ySize, xSize] = size(image);

svgDataDense = zeros(4,1);
svgDataSimple = zeros(4,1);
dataNum = 1;
dataNum2 = 1;
entry = 1;
svgIntermediate = zeros(1,1);
connectionArray = zeros(ySize,xSize,3,3);

%search
for y=1:ySize
    for x=1:xSize
        %tally adjancencies
        adj = -1;
        %if not valid, -1
        if image(y,x)==1
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
                                if connectionArray(y2,x2,j+2,i+2) == 1 || connectionArray(y2+j,x2+i,-j+2,-i+2)==1
                                    dupeFlag = true;
                                end

                                if dupeFlag == false
                                    headingNew = [i,j];
                                    
                                    if ~isequal(headingNew, headingOld) && ~firstFlag
                                        svgDataSimple(:,dataNum2) = [xL;yL;x2;y2];
                                        dataNum2 = dataNum2 + 1;
                                        headingOld = headingNew;
                                        svgIntermediate(entry,connection)=xL;
                                        svgIntermediate(entry,connection+1)=yL;
                                        connection = connection+2;
                                        xL = x2;
                                        yL = y2;
                                    end

                                    exFlag = false;

                                    svgDataDense(:,dataNum) = [x2;y2;x2+i;y2+j];
                                    
                                    connectionArray(y2,x2,j+2,i+2) = 1;
                                    connectionArray(y2+j,x2+i,-j+2,-i+2) = 1;
                                    
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
                    svgIntermediate(entry,connection)=xL;
                    svgIntermediate(entry,connection+1)=yL;
                    svgIntermediate(entry,connection+2)=x2;
                    svgIntermediate(entry,connection+3)=y2;
                    dataNum2 = dataNum2 + 1;
                    entry = entry + 1;
                end
            end
        end
    end
end

end
