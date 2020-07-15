%IN-PROGRESS
%TODO

function [svgData] = reduceSVG(svgData)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here



%lineDtest  500x564 282,000
%
% 0.014 connections/pixel
%
%0 3862 
%1 2692 1170 30.3%
%2 2375 317  11.8%
%3 2313 62    2.6%
%4 2305 8     0.4%
%
%n 2305 1557 40.3%
%

%{
0 209929
1
2
%}


flag = false;
while flag == false
    size(svgData,2);
    n=1;
    flag = true;
    
    while n <= size(svgData,2)    
        x = svgData(1,n);
        y = svgData(2,n);

        xd = svgData(3,n) - svgData(1,n);
        yd = svgData(4,n) - svgData(2,n);

        for i=1:size(svgData,2)
            if isequal(svgData(:,i),[x+xd;y+yd;x+2*xd;y+2*yd])
                svgData(:,n) = [x;y;x+2*xd;y+2*yd];
                svgData(:,i) = [];
                flag = false;
                break
            end
        end

        n = n+1;
    end
    
end

end

