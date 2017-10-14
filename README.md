# imageCS

Reference           : "An efficient algorithm for compression-based compressed sensing"

Authors             : S. Beygi, S. Jalali, A. Maleki, U. Mitra

Download            : https://arxiv.org/abs/1704.01992



functions:

    get_samples.m: perform the sampling from the input signal (image) based on Guassian or fourier mixture matrices. Can handle    very large measurement matrices but is very slow.
    
    addnoise.m: adds Gaussian noise, to achive a given SNR value, onto input signal.
    
    PSNR.m: Computes the PSNR of an image x and its estimate x_hat.
   
