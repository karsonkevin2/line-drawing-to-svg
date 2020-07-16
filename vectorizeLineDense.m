function [svgData] = vectorizeLineDense(image)
%Converts a bitmap line drawing into a set of coordinates writeable to svg
%Use in conjuction with printSVG.m
%
%   EXAMPLE: 
%       svgData = vectorizeLineDense(image);
%       svgData = vectorizeLineDense('myfile.png');
%
%   INPUT: 
%       image - an image either as logical, colour, or a file extension
%
%   OUTPUT: 
%       svgData - a list of coordinate pairs to draw lines between,
%           formatted to be readable in an svg file
%
%   This function will examine every pixel and their 8-connected region to
%   make connections. Each line will one pixel long, no simplification is 
%   used.

image = im2binary(image);
bitmapPad = padarray(image,[1,1],0);

[ySize, xSize] = size(image);

svgData = zeros(4,1);
dataNum = 1;

for y=1:ySize
    for x=1:xSize
        if image(y,x)==1
            for j=-1:1
                for i=-1:1
                    if bitmapPad(y+j+1,x+i+1) == 1
                        if ~(j== 0 && i== 0)
                            svgData(:,dataNum) = [x;y;x+i;y+j];
                            dataNum = dataNum + 1;
                        end    
                    end
                end
            end
        end
    end
end


end

