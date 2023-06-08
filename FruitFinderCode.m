Fruit = [
    "C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\fruit_tray.tiff",
    "C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\mixed_fruit1.tiff",
    "C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\mixed_fruit2.tiff",
    "C:\Users\trudtoj\OneDrive - Rose-Hulman Institute of Technology\IMAGE REC WORKFLOW\FruitFinderProject\FruitFinder\fruit\mixed_fruit3.tiff"
        ];
    
numFruit = size(Fruit); 

for num = 1:numFruit
    
    pattern = '([^\\]+)\.tiff$';
    
    target = regexp(char(Fruit(num)), pattern, 'tokens', 'once');
    
    img = imread(char(Fruit(num)));
    
    r = img(:,:,1); 
    g = img(:,:,2);
    b = img(:,:,3);
    
    img_hsv = rgb2hsv(img); 
    
    h = img_hsv(:,:,1); 
    s = img_hsv(:,:,2);
    v = img_hsv(:,:,3);
    
    reg_mask = ones(size(img(:,:,:)));
    %create the masks
    
    %apple mask
    mask = zeros(size(img_hsv(:,:,1)));
    %redIdx = find((h <= 0.03 | h >= 0.9) & (s >= 0.4) & (v >= 0.02));
    mask(find((h <= 0.03 | h >= 0.9) & (s >= 0.4) & (v >= 0.02))) = 1;
    reg_mask(:,:,1) = mask; 
    
    %orange mask
    mask = zeros(size(img_hsv(:,:,1)));
    %orangeIdx = find((h>=0.03 & h<=0.12) & (s >= 0.4) & (v >= 0.3));
    mask(find((h>=0.03 & h<=0.12) & (s >= 0.4) & (v >= 0.3))) = 1; 
    reg_mask(:,:,2) = mask;
    
    %banana mask
    
    %lot of noise from background for some reason
    mask = zeros(size(img_hsv(:,:,1)));
    %yellowIdx = find((h >= 0.1 & h <= 0.25) & (s >= 0.35) & (v >= 0.55));
    mask(find((h >= 0.1 & h <= 0.25) & (s >= 0.35) & (v >= 0.55))) = 1; 
    reg_mask(:,:,3) = mask;
    
    %save masks
    if ~isempty(target)
        fruit = target{1};
    
        filename = ['fruitFinderMask_', fruit, '.png'];
    
        imwrite(reg_mask, filename); 
        
    else
        disp('String not found.');
    
    end
    
    
end 
    