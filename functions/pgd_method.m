function [x, avec,  evec] = pgd_method(a, x, y, A, AT, imsize, err_const, xo, decoder, q, type, folderName, f_c, ratio)  
evec = [];
avec = [];
%fprintf('-------> Rate value = %d \n', q);
for i = 1 : err_const.max
    [a, x] = update_parameters(a, A, AT, y, x, decoder, q, imsize, i, type, folderName);
    avec = [avec a];
    errv = norm(x-xo, 2)/norm(xo, 2);
    %fprintf('--- iteration = %d, alhpa value =  %d --- \n', i , a);
    evec = [evec errv];
    if errv < err_const.eps
        break
    end
end
save(strcat('alphas/rate_',int2str(q), '_','ratio_',int2str(ratio), '_','image_', int2str(f_c), '.mat') , 'avec');
end
