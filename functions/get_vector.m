function [output, xmean] = get_vector(image_url, im_size)
raw_image = imread(image_url);
raw_image = imresize(raw_image, [im_size, im_size]);
if length(size(raw_image)) ==3
        raw_image = double(rgb2gray(raw_image));
    else
        raw_image = double(raw_image);
end
x = reshape(raw_image, im_size*im_size, 1);
xmean = mean(x);
output = x; %- xmean;
