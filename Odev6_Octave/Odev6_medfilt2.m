% Görüntüyü yükleme
image = imread('LENNAorijinal.bmp');

% Tuz-biber gürültüsü
noisy_image = imnoise(image, 'salt & pepper', 0.05);

% Medyan filtresi uygulama
filtered_image_noisy = medfilt2(noisy_image, [3 3]);

subplot(1, 3, 1);
imshow(image);
title('Orijinal Görüntü');

subplot(1, 3, 2);
imshow(noisy_image);
title('Tuz-Biber Gürültülü Görüntü');

subplot(1, 3, 3);
imshow(filtered_image_noisy);
title('medfilt2 Medyan Filtresi Uygulanmış Gürüntü');

