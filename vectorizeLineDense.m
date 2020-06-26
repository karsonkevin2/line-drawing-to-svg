function [svgData] = vectorizeLineDense(bitmap)
%Converts a bitmap line drawing into a set of coordinates writeable to svg
%   
%   EXAMPLE: 
%       svgData = vectorizeLineDense(bitmap);
%       svgData = vectorizeLineDense('myfile.png');
%
%   INPUT: 
%       bitmap - a 2D logical matrix, i.e. a background of value=0 and
%           lines of value=1. Also accepts colour and greyscale images and
%           attempts to convert them to binary. Also accepts file names
%
%   OUTPUT: 
%       svgData - a list of coordinate pairs to draw lines between,
%           formatted to be readable in an svg file
%
%   This works best if the line drawing is exactly 1 pixel thick, if it is 
%   thicker then rendering will take a very long time. This function will 
%   examine every pixel and their 8-connected region to
%   make lines. Each line will one pixel long, no simplification is used.

bitmap = im2binary(bitmap);

[ySize, xSize] = size(bitmap);

svgData = zeros(4,1);
dataNum = 1;

%take care of most cases
for y=1:ySize
    for x=1:xSize-1
        if bitmap(y,x)==1
            if bitmap(y,x+1)==1
                svgData(:,dataNum) = [x;y;x+1;y];
                dataNum = dataNum + 1;
            end
        end
    end
end

for y=1:ySize-1
    for x=1:xSize
        if bitmap(y,x)==1
            if bitmap(y+1,x)==1
                svgData(:,dataNum) = [x;y;x;y+1];
                dataNum = dataNum + 1;
            end
        end
    end
end

for y=1:ySize-1
    for x=1:xSize-1
        if bitmap(y,x)==1
            if bitmap(y+1,x+1)==1
                svgData(:,dataNum) = [x;y;x+1;y+1];
                dataNum = dataNum + 1;
            end
        end
    end
end

for y=1:ySize-1
    for x=2:xSize
        if bitmap(y,x)==1
            if bitmap(y+1,x-1)==1
                svgData(:,dataNum) = [x;y;x-1;y+1];
                dataNum = dataNum + 1;
            end
        end
    end
end


end

