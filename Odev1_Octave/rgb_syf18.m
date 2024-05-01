% Örnek bir RGB görüntü yükleme
dosya_yolu = 'D:\Computer Engineer Department\6. Yarı Yıl(2023-2024)\Görüntü İşlemenin Temelleri\Odev1_Octave\peppers.png'
rgb_image = imread(dosya_yolu);

% Kırmızı renkle yapay renklendirme
red_image = zeros(size(rgb_image), 'uint8');
red_image(:, :, 1) = rgb_image(:, :, 1); % Sadece kırmızı kanalı

% Yeşil renkle yapay renklendirme
green_image = zeros(size(rgb_image), 'uint8');
green_image(:, :, 2) = rgb_image(:, :, 2); % Sadece yeşil kanalı

% Mavi renkle yapay renklendirme
blue_image = zeros(size(rgb_image), 'uint8');
blue_image(:, :, 3) = rgb_image(:, :, 3); % Sadece mavi kanalı

% Yapay renklendirilmiş görüntüleri gösterme
subplot(1, 3, 1), imshow(red_image), title('Kırmızı Renk');
subplot(1, 3, 2), imshow(green_image), title('Yeşil Renk');
subplot(1, 3, 3), imshow(blue_image), title('Mavi Renk');

