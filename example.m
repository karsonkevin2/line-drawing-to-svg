%Example usage of functions

%METHOD 1
%will run quickly but not have 100% of lines reduced

    %Read in a line-drawing image
    exLarge = imread('exLarge.png');

    %Call vectorizeLineDense to create a connection list
    svgData = vectorizeLineDense(exLarge);

    %Call reduceSVG to merge redundant connections
    svgData = reduceSVG(svgData);

    %Call printSVG to convert the data into the SVG format
    printSVG(svgData, 'exLargeDense.svg', exLarge);
    
%METHOD 2
%will run a bit slower but will have a simpler svg format
    %Read in a line-drawing image
    exLarge = imread('exLarge.png');

    %Call vectorizeLineDense to create a connection list
    svgDataIntermediate = vectorizeLineSmart(exLarge);

    %Call printSVG to convert the data into the SVG format
    printSVGpoly(svgDataIntermediate, exLarge, 'exLargeSmart.svg');


