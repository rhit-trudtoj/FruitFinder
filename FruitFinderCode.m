Fruit = ['C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\fruit_tray.tiff',
        'C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\mixed_fruit1.tiff',
        'C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\mixed_fruit2.tiff',
        'C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\mixed_fruit3.tiff'];
    
numFruit = size(Fruit); 

for num = 1:numFruit
    
    img = imread(char(Fruit(num)));
    
    r = img(:,:,1); 
    g = img(:,:,2);
    b = img(:,:,3);
    
    img_hsv = rgb2hsv(img); 
    
    h = img_hsv(:,:,1); 
    s = img_hsv(:,:,2);
    v = img_hsv(:,:,3);
    
    
    
    
end 
    