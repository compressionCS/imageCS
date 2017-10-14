image_size = 256;    
ratios = [10];
p.permutaion_type = 'Bernouli';  
p.matrix_type =  'partial_Fourier';  
type = 'Operator';
decoder_type = 'JPEG';  q_min = 10;    q_step = 1;   q_max = 90;

[initial_point, ~]  = get_vector( 'images/im0.png'  , image_size);
err_const.max = 10;   err_const.eps = 0.001;   psnrS = zeros(size(q_min: q_step: q_max));

for f_c = 1:6
    file_name = strcat('images/im',int2str(f_c),'.png');
    [x, xmean] = get_vector( file_name   , image_size);
    n = length(x);
    for i = 1 : length(ratios)
        folderName = strcat('out/F_', decoder_type,'_ratio_', int2str(ratios(i)),'_percent_', file_name);
        mkdir(folderName);
        m = round(n*ratios(i)/100);
        [y, A, AT]  = get_samples(x, m , p);
        x_init = initial_point;
        a_init = 0.01*max(norm(AT(y), 'inf'));
        counter = 0;
        for q  = q_min: q_step: q_max
              [estx, avec,  evec] = pgd_method(a_init, x_init, y, A, AT, image_size, ...
                                           err_const, x, decoder_type, q, type, folderName, f_c, ratios(i));  
               alpha = avec(end);
               counter = counter + 1;
               psnrS(counter) = 20*log10(psnr_eval(estx, x));
               x_init = estx;
               fprintf('---ratio = %d, comp. rate = %d ---> PSNR = %d  (dB)\n\n', ratios(i), q, psnrS(counter));
        end
        fname = strcat('results/F_ratio_', int2str(ratios(i)),'_' ,decoder_type, '_' , 'im0', int2str(f_c),'.mat');
        save(fname, 'psnrS');
    end
end
