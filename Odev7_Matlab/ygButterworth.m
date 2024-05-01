%%%%%%%%%%%%%%%%%%%%% BUTTERWORTH YÜKSEK GEÇİRGEN FİLTRE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OrjI = imread('cameraman.tif');
%OrjI = rgb2gray(OrjI);
f = double(OrjI);
[N, M] = size(f);

F = fftshift(fft2(f));
[w1, w2] = freqspace([N, M], "meshgrid");
D0_values = [0.1, 0.2, 0.3, 0.5, 0.7];

figure;
subplot(2, 3, 1), imshow(uint8(f)), title('Orijinal Görüntü');

for i = 1:length(D0_values)
    D0 = D0_values(i);
    D = sqrt(w1.^2 + w2.^2);
    H = 1 ./ (1 + 0.414*(D0 ./ D).^(2*1));
    G = H .* F;
    g = round(abs(ifft2(G)));

    % Ölçeklendirme yapılıyor
    Qmax = 255;
    Qmin = 0;
    Imaks = max(g(:));
    Imin = min(g(:));
    beta = (Qmax - Qmin) / (Imaks - Imin);
    Q = round(beta * (g - Imin) + Qmin);

    subplot(2, 3, i + 1), imshow(uint8(Q)), title(['D0=', num2str(D0)]);
end

