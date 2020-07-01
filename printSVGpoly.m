function printSVGpoly(svgData,bitmap,fileID)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Add file extension if not present
if ~isequal(fileID(end-3:end),'.svg')
    fileID = [fileID, '.svg'];
end

svgData = padarray(svgData,[0,2],0,'post');

%create and overwrite file
fileID = fopen(fileID,'w');
fprintf(fileID, '<svg viewBox="0 0 %u %u" xmlns="http://www.w3.org/2000/svg">\n', size(bitmap,2),size(bitmap,1));
for i=1:size(svgData,1)
    counter=1;
    fprintf(fileID, '<polyline points="');
    while svgData(i,counter) ~= 0
        fprintf(fileID,'%u,%u ' ,svgData(i,counter), svgData(i,counter+1));
        counter = counter+2;
    end
    fprintf(fileID, '" fill="none" stroke="black" />\n');
end
   % <polyline points="100,100 150,25 150,75 200,0"

fprintf(fileID, '</svg>');
fclose(fileID);

end



