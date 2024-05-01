% Görüntüyü yükle
dosya_yolu = 'D:\Computer Engineer Department\6. Yarı Yıl(2023-2024)\Görüntü İşlemenin Temelleri\Odev3_1_Octave\HarryPotterOotP.jpg';
image = imread(dosya_yolu);

% Farklı örnekleme faktörleri
ornekleme_factors = [2, 4, 8, 16, 32];

% Alt grafik sayısı
num_subplots = length(ornekleme_factors);

% Alt grafiklerin oluşturulması
figure;
for i = 1:num_subplots
    ornekleme_factor = ornekleme_factors(i);
    new_image = image(1:ornekleme_factor:end, 1:ornekleme_factor:end, :);
    subplot(2, num_subplots/2, i);
    imshow(new_image);
end

% Orijinal görüntü
subplot(2, num_subplots/2, num_subplots + 1);
imshow(image);
title('Orijinal Görüntü');




