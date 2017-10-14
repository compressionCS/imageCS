image_size = 512;   
ratios = [50];  % percent sampling ratio 
p.permutaion_type = 'Bernouli'; 
p.matrix_type =  'partial_Fourier';   
type = 'Operator';
decoder_type =  'JPG2K';   
q_min = 90;    q_step = -1;   q_max = 40;
[initial_point, ~]  = get_vector( 'images/im0.png'  , image_size);
err_const.max = 5;   err_const.eps = 0.0001;   psnrS = zeros(size(q_min: q_step: q_max));

for f_c = 5:5
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
                                           err_const, x, decoder_type, q, type, folderName);  
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
