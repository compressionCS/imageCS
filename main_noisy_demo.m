image_size = 512;   
ratios = [10 30 50];
p.permutaion_type = 'Bernouli';
p.matrix_type =  'partial_Fourier';   
type = 'Operator'; 
decoder_type =  'JPG2K';
q_min = 50;    q_step = -1;   q_max = 5;

% decoder_type = 'JPEG';
% q_min = 1;    q_step = 1;   q_max = 50;
[initial_point, ~]    = get_vector( 'images/im0.png'  , image_size);
err_const.max = 1;   err_const.eps = 0.0001;   
psnrS = zeros(size(q_min: q_step: q_max));
snrs = [10, 30];
for j = 1 :length(snrs)
    for f_c = 1:5
        file_name = strcat('ims_st/im',int2str(f_c),'.png');
        [x, xmean] = get_vector( file_name   , image_size);
        n = length(x);
        for i = 1 : length(ratios)
            folderName = strcat('out/F_', decoder_type,'_ratio_', int2str(ratios(i)),'_snr_', int2str(snrs(j)),'_percent_', file_name);
            mkdir(folderName);
            m = round(n*ratios(i)/100);
            [y, A, AT]  = get_samples(x, m , p);
            y = addnoise(y, snrs(j));
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
            fname = strcat('results/F_ratio_', int2str(ratios(i)),'_snr_', int2str(snrs(j)),'_' ,decoder_type, '_' , 'noisyim0', int2str(f_c),'.mat');
            save(fname, 'psnrS');
        end
    end
end
