%Example usage of functions

%METHOD 1
%Will produce an SVG with separate polylines between each joint

    %Read in a line-drawing image
    exLarge = imread('exLarge.png');

    %Call vectorizeLineSmart to create a connection list
    svgDataIntermediate = vectorizeLineSmart(exLarge);

    %Call printSVGpoly to convert the data into the SVG format
    printSVGpoly(svgDataIntermediate, exLarge, 'exLargeSmart.svg');


%METHOD 2
%will run slightly quicker but every pixel will retain connectivity

    %Read in a line-drawing image
    exLarge = imread('exLarge.png');

    %Call vectorizeLineDense to create a connection list
    svgDataDense = vectorizeLineDense(exLarge);

    %Call printSVG to convert the data into the SVG format
    printSVG(svgDataDense, 'exLargeDense.svg', exLarge);
    
%METHOD 3
%draws each straight line in 8 connectivity space as a separate line, less
%useful than using polylines and has the same runtime

    %Read in a line-drawing image
    exLarge = imread('exLarge.png');

    %Call vectorizeLineSmart to create a connection list
    [svgDataIntermediate, svgDataSimple, svgDataDense] = vectorizeLineSmart(exLarge);

    %Notice how the size of the simple data is smaller than the dense data
    
    %Call printSVGpoly to convert the data into the SVG format
    printSVG(svgDataSimple, exLarge, 'exLargeSimple.svg');



