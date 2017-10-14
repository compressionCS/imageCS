function [signal, A, AT]  = get_samples(x, m, p)

n = length(x);

switch p.matrix_type
    case 'iid_Gaussian'
        A = randn(m, n);
        A = bsxfun(@times, A, 1./sqrt(sum(A.^2, 1)));
        signal = A*x;
        AT = transpose(A);
    case 'partial_Fourier'
         [rand_freq, rand_oper] = pft_init(m, n, p.permutaion_type);
         PF    = @(z) take_pft(z, rand_freq, rand_oper);         % Partial-Fourier sampling
         PF_T = @(z) take_pft_t(z, n, rand_freq, rand_oper);     % Trans. Partial-Fourier sampling
         signal = PF(x);
         A = PF;
         AT=  PF_T;
    otherwise
        disp('An error occured !!! HELP HELP ...')
end
end