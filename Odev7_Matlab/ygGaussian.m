%%%%%%%%%%%%%%%%%%%%% GAUSSIAN YÜKSEK GEÇİRGEN FİLTRE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OrjI = imread('cameraman.tif');
f = double(OrjI);
[N, M] = size(f);

F = fftshift(fft2(f));
[w1, w2] = freqspace([N, M], "meshgrid");
sigma = [0.1, 0.2, 0.3, 0.5, 0.7];

figure;
subplot(2, 3, 1), imshow(uint8(f)), title('Orijinal Görüntü');

for i = 1:length(sigma)
    s = sigma(i);
    D = sqrt(w1.^2 + w2.^2);
    H = 1 - exp(-(D.^2) ./ (2 * (sqrt(2) * s)^2));
    G = H .* F;
    g = abs(ifft2(ifftshift(G)));

    % Ölçeklendirme yapılıyor
    Qmax = 255;
    Qmin = 0;
    Imaks = max(g(:));
    Imin = min(g(:));
    beta = (Qmax - Qmin) / (Imaks - Imin);
    Q = round(beta * (g - Imin) + Qmin);

    subplot(2, 3, i + 1), imshow(uint8(Q)), title(['sigma=', num2str(s)]);
end

