function output = psnr_eval(ex, x)
mse = norm(x-ex,2)/sqrt(length(x));
%output = max(x)/mse;
output = 255/mse;