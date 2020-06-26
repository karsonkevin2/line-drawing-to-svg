%Example usage of functions


%METHOD 1
%Read in a line-drawing image
exLarge = imread('exSmall.png');

%Call vectorizeLineDense to create a connection list
svgData = vectorizeLineDense(exLarge);

%Call reduceSVG to merge redundant connections
svgData = reduceSVG(svgData);

%Call printSVG to convert the data into the SVG format
printSVG(svgData, 'exSmallSVG.svg', exLarge);



%METHOD 2
%Read in a line-drawing image
exLarge = imread('exLarge.png');

%Call vectorizeLineDense to create a connection list
svgData = vectorizeLineSmart(exLarge);

%Call printSVG to convert the data into the SVG format
printSVG(svgData, 'exLargeSVG.svg', exLarge);


