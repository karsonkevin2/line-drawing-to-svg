function printSVG(varargin)
%Convert a list of lines in the form of x1,y1,x2,y2 into an svg file
%
%   EXAMPLES:
%       printSVG(svgData)
%       printSVG(svgData, bitmap) | printSVG(bitmap, svgData)
%       printSVG(svgData, fileID) | printSVG(fileID, svgData)
%       printSVG(svgData, bitmap, fileID) | ...
%
%   INPUT:
%       svgData - REQUIRED - matrix of data formatted as [x1;y1;x2;y2]
%       bitmap - OPTIONAL - original bitmap, used to get dimensions, if not
%           included svg header will have improper dimensions and may
%           display improperly on some renderers
%       fileID - OPTIONAL - file to write output to, defaults to
%           lineDrawing.svg, can be specified with or without .svg
%           extension

%bad input
if 3 < nargin
    error('Too many arguments, see documentation')
end

%defaults
fileID = 'lineDrawing.svg';
bitmap = [-1];
svgData = [-1];

%parse input
for i=1:nargin
    if ischar(varargin{i})
        fileID = varargin{i};
    
    elseif size(varargin{i}, 1) == 4
        svgData = varargin{i};
    
    else
        bitmap = varargin{i};
    end
        
end

%data not passed
if svgData(1,1) == -1
    error('svg Data not passed as an argument, see documentation')
end

%Add file extension if not present
if ~isequal(fileID(end-3:end),'.svg')
    fileID = [fileID, '.svg'];
end

%
if bitmap(1,1) == -1
    warning('Bitmap not passed, svg size defaulting to 1,1')
end

%create and overwrite file
fileID = fopen(fileID,'w');
fprintf(fileID, '<svg viewBox="0 0 %u %u" xmlns="http://www.w3.org/2000/svg">\n', size(bitmap,2),size(bitmap,1));
fprintf(fileID, '<line x1="%u" y1="%u" x2="%u" y2="%u" stroke="black" />\n', svgData);
fprintf(fileID, '</svg>');
fclose(fileID);

end

