clc;clear all;close all;
%% Orjinal Görüntü
Iorj = imread('LENNAorijinal.bmp');
f = double(Iorj);
[N,M] = size(f);

mf = mean(mean(f));        %orijinal görüntünün ortalaması
varf = mean2((f-mf).^2);   %orijinal görüntünün varyansı
F = fftshift(fft2(f));     %Fourier dönüşümü (görüntü)
Pf = (F.*conj(F))/(N*M);   %Görüntünün güç spektrumu

%% Gürültülü Görüntü
SNR = 7;
randn('seed',0);
sigmakare = varf./(10^(0.1*SNR));
w = sqrt(sigmakare).*randn(N,M);

% SNR=7 olan gürültülü görüntü
g_noisy = plus(f,w);

mv = mean(mean(w));       %mean of the noisy image
W = fftshift(fft2(w));    %Fourier transform (image)
Pv = (W.*conj(W))/(N*M);  %Power spectrum of NOISY image

%% Wiener filter transfer function
g = plus(f,w);            %Wiener filter transfer function
H = Pf./(Pf+Pv);
e = g -(mf+mv);
A = fftshift(fft2(e));
Q = A.*H;
p_wiener = round(ifft2(fftshift(Q))+mf); %Wiener filtresi ile filtrelenmiş görüntü

%% Gaussian Filtresi
function g_gaussian = myGaussianLowPassFilter(image, sigma)
    % Fourier dönüşümünü al
    F = fftshift(fft2(image));
    [N, M] = size(F);

    % Görüntünün frekans bileşenlerinin koordinatlarını hesapla
    [w1, w2] = freqspace([N, M], "meshgrid");

    % Filtreleme için Gaussian filtre oluştur (alçak geçiren)
    D = sqrt(w1.^2 + w2.^2);
    H = exp(-((D.^2) ./ (2 * (sqrt(2) * sigma)^2)));

    % Fourier dönüşümüne Gaussian filtre uygula
    G = H .* F;
    g_gaussian = abs(ifft2(ifftshift(G)));
end

g_gaussian = myGaussianLowPassFilter(g_noisy, 0.3);

f_g = f-g;
mf_g = mean2(f_g);
varf_g = mean2((f_g-mf_g).^2);

f_p = f-p_wiener;
mf_p = mean2(f_p);
varf_p = mean2((f_p-mf_p).^2);

f_gaussian = f-g_gaussian;
mf_gaussian = mean2(f_gaussian);
varf_gaussian = mean2((f_gaussian-mf_gaussian).^2);

NMSEfg = 100*(varf_g/varf) %Bozulmuş görüntü NMSE
SNR % Bozulmuş görüntü SNR(dB)

NMSEfp = 100*(varf_p/varf)  %Wiener görüntü NMSE
SNR_Wiener = 10*log10(NMSEfg/NMSEfp) %Wiener SNR(dB) iyleştirme

NMSEfgaussian = 100*(varf_gaussian/varf)  %Gaussian görüntü NMSE
SNR_Gaussian = 10*log10(NMSEfg/NMSEfgaussian) %Gaussian SNR(dB) iyleştirme

%% Görselleri Subplot ile Gösterme
figure;
set(gcf,'Color','White');
set(gcf,'units','normalized','outerposition',[0 0 1 1]);

% Orijinal Görüntü
subplot(2,2,1);
imshow(Iorj);
title('Orijinal Görüntü');

% SNR=7 olan gürültülü görüntü
subplot(2,2,2);
imshow(uint8(g_noisy));
title('SNR=7 ile Gürültülü Görüntü');

% Wiener Filtresi Uygulanmış Görüntü
subplot(2,2,3);
imshow(uint8(p_wiener));
title('Wiener Filtresi');

% Gaussian Filtresi Uygulanmış Görüntü
subplot(2,2,4);
imshow(uint8(g_gaussian));
title('Gaussian Filtresi (s=0.3)');

