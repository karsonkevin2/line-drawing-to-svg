function printSVGpoly(svgData,bitmap,fileID)
%Takes data formatted by vectorizeLineSmart and prints it to an SVG using
%polylines
%
%EXAMPLE:
%   printSVGpoly(svgDataIntermediate, exLarge, 'output.svg');
%
%INPUT:
%   svgData - the svgDataIntermediate variable output by vectorizeLineSmart
%   bitmap - the bitmap image, used to extract image size
%   fileID - the id of the file to write to
%
%

%Add file extension if not present
if 4 <= length(fileID)
    if ~isequal(fileID(end-3:end),'.svg')
        fileID = [fileID, '.svg'];
    end
else
    fileID = [fileID, '.svg'];
end

svgData = padarray(svgData,[0,2],0,'post');

%create and overwrite file
fileID = fopen(fileID,'w');

%header
fprintf(fileID, '<svg viewBox="0 0 %u %u" xmlns="http://www.w3.org/2000/svg">\n', size(bitmap,2),size(bitmap,1));

%format svg polylines
for i=1:size(svgData,1)
    counter=1;
    fprintf(fileID, '<polyline points="');
    while svgData(i,counter) ~= 0
        fprintf(fileID,'%u,%u ' ,svgData(i,counter), svgData(i,counter+1));
        counter = counter+2;
    end
    fprintf(fileID, '" fill="none" stroke="black" />\n');
end

%footer
fprintf(fileID, '</svg>');

%save file
fclose(fileID);

end
