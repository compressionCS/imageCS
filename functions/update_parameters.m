function [alpha, x] = update_parameters(a_init, A, AT, y, x, decoder, q, imsize, i, type, folderName)
    fname = strcat(folderName,'/rate_', int2str(q),'_iter_', int2str(i));
    alpha = fminsearch(@(a) obj_fun(a, y, A, AT, x, decoder, q, imsize, type), a_init, ...
                            optimset('TolX',1e-8, 'MaxIter', 10, 'Display', 'off')); 
    if strcmp(type, 'Operator')
          ugrad = x + alpha*AT(y - A(x));
    elseif strcmp(type, 'Number')
          ugrad = x + alpha*AT*(y - A*x);
    end
    x = EnDecode(decoder, ugrad, q, imsize, fname);
end   
 
