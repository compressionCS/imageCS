function output = EnDecode(decoder, raw_im, q, imsize, fname)
raw_im = reshape(raw_im, imsize, imsize);
image =  uint8(raw_im);
if strcmp(decoder,'JPEG')
    filename = strcat(fname,'.jpg');
    imwrite(image, filename, 'quality', q);
    img = imread(filename);
elseif strcmp(decoder,'JPG2K')
    filename = strcat(fname,'.jp2');
    imwrite(image, filename, 'CompressionRatio', q);
    img = imread(filename, 'jp2');
end
output = reshape(double(img), imsize*imsize,1);