% Görüntüyü yükleme
Iorj = imread('LENNAorijinal.bmp');

% Görüntüyü normalize etme (0-1 aralığına getirme)
I = im2double(Iorj);
[N, M] = size(I);

h1 = ones(3) / 9;
%h2 = [1 1 1;1 2 1;1 1 1]*(1/10);
%h3 =  [1 2 1;2 4 2;1 2 1]*(1/16);

% Gürültü seviyeleri (dB cinsinden)
SNR_degerleri = [0, 10, 20];

% Filtrelenmiş görüntüleri depolamak için 3B dizi oluşturma
filtrelenmis_goruntuler = zeros([N, M, length(SNR_degerleri)]);

figure;
for i = 1:length(SNR_degerleri)
    % Sinyal Gücü Hesaplama
    PS = sum(sum(I.^2)) / (N * M);

    % Gürültü Gücü Hesaplama
    PN = PS / (10^(SNR_degerleri(i) / 10));

    % Gürültü eklenen görüntüyü oluşturma
    %gurultulu_goruntu = imnoise(I, 'gaussian', 0, sqrt(PN));
    W = sqrt(PN).*randn(N,M);
    gurultulu_goruntu = I + W;

    % Filtrelenmiş görüntü oluşturma
    filtrelenmis_goruntu = imfilter(gurultulu_goruntu, h1);
    %filtrelenmis_goruntu = imfilter(gurultulu_goruntu, h2);
    %filtrelenmis_goruntu = imfilter(gurultulu_goruntu, h3);

    % Filtrelenmiş görüntüyü diziye atama
    filtrelenmis_goruntuler(:,:,i) = filtrelenmis_goruntu;

    % Gürültülü görüntüyü gösterme
    subplot(2, 2, i);
    imshow(gurultulu_goruntu);
    title(sprintf('SNR: %ddB', SNR_degerleri(i)));
end

% Orijinal görüntüyü gösterme
subplot(2, 2, 4);
imshow(Iorj);
title('Orijinal Görüntü');

figure;

for i = 1:length(SNR_degerleri)
    subplot(2,2, i);
    imshow(filtrelenmis_goruntuler(:,:,i));
    title(sprintf('h1 ile Filtrelenmiş %ddB ', SNR_degerleri(i)));
    %title(sprintf('h2 ile Filtrelenmiş %ddB ', SNR_degerleri(i)));
    %title(sprintf('h3 ile Filtrelenmiş %ddB ', SNR_degerleri(i)));
end

% Orijinal görüntüyü gösterme
subplot(2, 2, 4);
imshow(Iorj);
title('Orijinal Görüntü');




