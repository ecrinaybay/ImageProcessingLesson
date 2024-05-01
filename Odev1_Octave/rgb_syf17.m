% Örnek bir RGB görüntü yükleme
dosya_yolu = 'D:\Computer Engineer Department\6. Yarı Yıl(2023-2024)\Görüntü İşlemenin Temelleri\Odev1_Octave\peppers.png'

rgb_image = imread(dosya_yolu);

% Görüntüyü GRB'ye dönüştürme
grb_image = rgb_image(:, :, [2, 1, 3]);
rbg_image = rgb_image(:, :, [1, 3, 2]);
gbr_image = rgb_image(:, :, [2, 3, 1]);


% Görüntüyü gösterme
subplot(2, 2, 1), imshow(rgb_image), title('RGB Görüntü');
subplot(2, 2, 2), imshow(grb_image), title('GRB Görüntü');
subplot(2, 2, 3), imshow(rbg_image), title('RGB Görüntü');
subplot(2, 2, 4), imshow(gbr_image), title('GBR Görüntü');

% Yapay renklendirme GRB - 213
% Yapay renklendirme RBG - 132
% Yapay renklendirme GBR - 231

