function [r_freq, r_oper] = pft_init(m, n, ptype)
%specify random  selction vector 
r_freq = randperm(round(n/2)-1)+1;
r_freq = r_freq(1:round(m/2));

%specify the type of random permutation of element of x
if strcmp(ptype, 'permutation')
    r_oper = randperm(n)'; % random permuation 
elseif strcmp(ptype, 'Bernouli')
    r_oper = 2*round(rand(n,1))-1;
elseif  strcmp(ptype, 'nothing')
    r_oper = 0;
end