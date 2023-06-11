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
    redIdx = find((h <= 0.05 | h >= 0.9) & (s >= 0.5) & (v >= 0.045));
    mask(redIdx) = 1;
    reg_mask(:,:,1) = mask; 
    
    %orange mask
    mask = zeros(size(img_hsv(:,:,1)));
    orangeIdx = find((h>=0.03 & h<=0.12) & (s >= 0.4) & (v >= 0.3));
    mask(orangeIdx) = 1; 
    reg_mask(:,:,2) = mask;
    
    %banana mask
    
    %lot of noise from background for some reason
    mask = zeros(size(img_hsv(:,:,1)));
    yellowIdx = find((h >= 0.1 & h <= 0.25) & (s >= 0.5) & (v >= 0.35));
    mask(yellowIdx) = 1; 
    reg_mask(:,:,3) = mask;
    
    %then want to process each mask and do morphological operations and
    %then do 
    %component analysis 
    
    for i = 1:3
%         
%         %morphological operations
          %need to get rid of pixels before operations
          
          temp_mask = reg_mask(:,:,i); 
          
          %get average cluster size and remove those that are <1/3 of the
          %average
          components = bwconncomp(temp_mask); 
          pixels = cellfun(@numel, components.PixelIdxList); 
          avg = mean(pixels);
          remove = find(pixels < avg/3);
          for n = 1:length(remove)
              
              temp_mask(components.PixelIdxList{remove(n)}) = 0;
       
          end
          
          reg_mask(:,:,i) = temp_mask;
          
          %get average cluster size and remove those that are <100
          components = bwconncomp(temp_mask); 
          pixels = cellfun(@numel, components.PixelIdxList); 
          remove = find(pixels < 100);
          for n = 1:length(remove)
              temp_mask(components.PixelIdxList{remove(n)}) = 0; 
          end
          
          reg_mask(:,:,i) = temp_mask;
          
          
          
         se = strel('square', 3);
          
         reg_mask(:,:,i) = imclose(reg_mask(:,:,i), se); 
         reg_mask(:,:,i) = imopen(reg_mask(:,:,i), se); 
         
         
         components = bwconncomp(temp_mask); 
         pixels = cellfun(@numel, components.PixelIdxList); 
         avg = mean(pixels);
         remove = find(pixels < avg/2);
         for n = 1:length(remove)
             temp_mask(components.PixelIdxList{remove(n)}) = 0; 
         end
         
         reg_mask(:,:,i) = temp_mask;
          
         
    end

    %do connected component analysis
    
    figure(num);
    imshowpair(reg_mask, img,'montage'); 
    title('Identifying Mask and the Original Image');
    
    apples = bwlabel(reg_mask(:,:,1));
    data_apples = regionprops('table', apples, 'Centroid', 'Area'); 
    
    oranges = bwlabel(reg_mask(:,:,2));
    data_oranges = regionprops('table', oranges, 'Centroid', 'Area');
    
    bannanas = bwlabel(reg_mask(:,:,3)); 
    data_bannanas = regionprops('table', bannanas, 'Centroid', 'Area');
    
    
    
    %save masks
    if ~isempty(target)
        fruit = target{1};
    
        filename = ['fruitFinderMask_', fruit, '.png'];
    
        imwrite(reg_mask, filename); 
        
    else
        disp('String not found.');
    
    end
    
    
end 
    