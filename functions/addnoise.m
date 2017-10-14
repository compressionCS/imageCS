function yn = addnoise(y, snr)
noise = randn(size(y));
noise = noise/norm(noise,2);
yn = y + 10^(-snr/20)*norm(y,2)*noise;