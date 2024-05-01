% Görüntüyü yükleme
Iorj = imread('LENNAorijinal.bmp');

% Görüntüyü normalize etme (0-1 aralığına getirme)
I = im2double(Iorj);
[N, M] = size(I);

%Normalize edlilmeyen filtrerl doğru istenilen sonucu vermiyor
%h1 = ones(3) ./ 9;
%h2 = ones(5) ./ 9;
%h3 = ones(15) ./ 9;

%Normalize filtreler
h1 = ones(3) ./ 9;
h2 = ones(5) ./ 25;
h3 = ones(15) ./ 225;


% Gürültü seviyeleri (dB cinsinden)
SNR_degeri =10;

% Sinyal Gücü Hesaplama
PS = sum(sum(I.^2)) / (N * M);

% Gürültü Gücü Hesaplama
PN = PS / (10^(SNR_degeri / 10)); % PN = PS/10 çıkıyor

% Gürültü eklenen görüntüyü oluşturma
W = sqrt(PN).*randn(N,M);
gurultulu_goruntu = I + W;

%gurultulu_goruntu = imnoise(I, 'gaussian', 0, sqrt(PN));

filtrelenmis_goruntu3 = imfilter(gurultulu_goruntu, h1);
filtrelenmis_goruntu5 = imfilter(gurultulu_goruntu, h2);
filtrelenmis_goruntu15 = imfilter(gurultulu_goruntu, h3);

images = {Iorj, gurultulu_goruntu, filtrelenmis_goruntu3, filtrelenmis_goruntu5, filtrelenmis_goruntu15};


figure;
for i = 1:5
    subplot(2, 3, i);
    imshow(images{i});
    if i == 1
        title('Orijinal Görüntü');
    elseif i == 2
        title('Gürültülü Görüntü');
        elseif i == 3
        title('Normalize 3x3 Filtre');
    elseif i == 4
        title('Normalize 5x5 Filtre');
    else
        title('Normalize 15x15 Filtre');
    end
end



