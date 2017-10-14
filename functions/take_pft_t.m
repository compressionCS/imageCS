function x = take_pft_t(y, n, rand_freq, rand_oper)
% implementation of the transpose of dense FFT-based sampling operator
%   y: signal vector
%   n: length of original signal
%   rand_freq: a vector with frequency indices choosen uniform at random
%   rand_oper: randomized operator, such
%        random permutation (scrambling)
%        a Bernoulli vector with 1, -1 entries (flipping)
%   x: signal vector with length of n
m = length(y);
x = zeros(n,1);
fx = zeros(n,1);
fx(rand_freq) = sqrt(2)*y(1:round(m/2)) + 1i*sqrt(2)*y(round(m/2)+1:m);
if max(rand_oper) > 1         % random permutation 
    x(rand_oper) = sqrt(n)*real(ifft(fx));
elseif max(rand_oper) == 1    % random Bernoulli
    x = sqrt(n)*real(ifft(fx));
    x = x.* rand_oper;
elseif max(rand_oper) == 0
    x = sqrt(n)*real(ifft(fx));
end
end
