function y = take_pft(x, rand_freq, rand_oper)
% implementation of the transpose of dense FFT-based sampling operator
%   x: original vector
%   rand_freq: a vector with frequency indices choosen uniform at random;
%   rand_oper: randomized operator, such
%        random permutation (scrambling)
%        a Bernoulli vector with 1, -1 entries (flipping)
%   y: sampled vector
n = length(x);
if max(rand_oper) > 1,        % pre-randomizing using permutation vector
    fx = 1/sqrt(n)*fft(x(rand_oper));
elseif max(rand_oper) == 1 % pre-randomizing using Bernoulli vector
    x = x.*rand_oper;
    fx = 1/sqrt(n)*fft(x);
elseif max(rand_oper) == 0
    fx = 1/sqrt(n)*fft(x);
end
y = [sqrt(2)*real(fx(rand_freq)); sqrt(2)*imag(fx(rand_freq))];