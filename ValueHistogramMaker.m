%This file's purpose is to look through all the images and get the hue
%histograms in order for me to easily get them but also begin creating
%bounds for the hues in the fruit 

Paths = [
        "C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\extras_optional\apples_day.tiff",
        "C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\extras_optional\apples_fluor.tiff",
        "C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\extras_optional\bananas_day.tiff",
        "C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\extras_optional\bananas_fluor.tiff",
        "C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\extras_optional\oranges_day.tiff",
        "C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\extras_optional\oranges_fluor.tiff"
        ];
 
num = size(Paths);

for i = 1:num
    
    img = imread(char(Paths(i))); 
    
    %regex provided by chatgpt
    pattern = '([^\\]+)\.tiff$';
    
    target = regexp(char(Paths(i)), pattern, 'tokens', 'once');
    
    hsvimg = rgb2hsv(img); 
    
    v = hsvimg(:,:,3); 
    
    imhist(v);
    
    if ~isempty(target)
        fruit = target{1};
    
        filename = ['value_histogram_', fruit, '.png'];
    
        saveas(gcf, filename);
        
    else
        disp('String not found.');
    
    end
    
end