# line-drawing-to-svg

---

This MATLAB library provides functionality for 1:1 conversion of line drawings into SVG files. The purpose is to convert raster line drawings into vectorized line drawings. The converted files will be identical to the original files and infinitely zoomable.

---

## Table of Contents

- [Example](#Example)
- [Dependencies](#Dependencies)
- [FAQ](#FAQ)
- [Related Projects](#Related_Projects)

---

## Example
Read in a raster line drawing, `exLarge.png`
```MATLAB
im = imread('exLarge.png');
```
Run the function `vectorizeLineSmart.m` on the image to get coordinate lists
```MATLAB
svgDataIntermediate = vectorizeLineSmart(im);
```
Run the function `printSVGpoly.m` to print the data to an SVG file
```MATLAB
printSVGpoly(svgDataIntermediate, im, 'output.svg');
```

PNG (Original) | SVG (Converted)
:---: | :---:
<img src="/exLarge.png" width="500" /> | <img src="/exLargeSVG.svg" width="500" /> 

---

## Dependencies
[Image Processing Toolbox](https://www.mathworks.com/products/image.html)

---

## FAQ

- **Why is this better than other alternatives?**

  - After trying many solutions online, you will find that none are 1:1 conversions. Online solutions are designed around graphic design where a line may be larger than 1 pixel. They use machine learning to quickly convert raster to vector at the cost of some features.

  - This library is optimized for use on 1 pixel wide line drawings. These files might be the result of a skeletonization. Converting the file using this library will 100% preserve the image.

- **How fast are the functions?**

  - The library is currently single-threaded. On an image about 1000x1000 pixels, one can expect the `vectorizeLineSmart.m` function to take upwards of 10-20 seconds. This function's runtime will scale exponentially for images with more lines.

  - Alternatively, the `vectorizeLineDense.m` function can be used which will return the same image, but every pixel will have a connection to adjacent pixels. This will run instantly, but attempting to open the image in a renderer may take time.

- **How is a 1:1 conversion achieved?**

  - The `vectorizeLineSmart.m` function looks at any endpoints or joints in the line drawing. It traces a line from these points until it reaches another endpoint or joint. This process is repeated until all connections have been created.

---

## Related_Projects
https://github.com/karsonkevin2/heatmap-skeletonization

---
