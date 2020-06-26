function [bitmap] = im2binary(bitmap)
%Helper function to convert images to black/white
%   EXAMPLE:
%       bitmap = vectorizeLineDense(bitmap);
%       bitmap = vectorizeLineDense('myfile.png');
%
%   INPUT:
%       bitmap - a 2D logical matrix, i.e. a background of value=0 and
%           lines of value=1. Also accepts colour and greyscale images and
%           attempts to convert them to binary. Also accepts file names
%
%   OUTPUT
%       bitmap - the bitmap converted to logical (0,1) values


%read file if user enters extension
if ischar(bitmap)
    if bitmap(end-3) == '.'
        bitmap = imread(bitmap);
    end
end

%convert from color to grayscale
if 2 < size(size(bitmap),2)
    warning('input had color, attempting to automatically convert to grayscale')
        
    bitmap = mean(bitmap,3);
    bitmap = rescale(bitmap);
end

%convert from grayscale to logical
if ~isa(bitmap, 'logical')
    warning('data type is not logical, attempting to automatically threshold using Otsus method') 
        
    bitmap = imbinarize(bitmap);
end

end

