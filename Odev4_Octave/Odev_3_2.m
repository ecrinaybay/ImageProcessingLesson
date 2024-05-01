% Renkli görüntüyü yükle
dosya_yolu = 'D:\Computer Engineer Department\6. Yarı Yıl(2023-2024)\Görüntü İşlemenin Temelleri\Odev_3_2_Octave\Ron_HarryPotter.jpg';
renkli_image = imread(dosya_yolu);

image = rgb2gray(renkli_image);

% Kuantize edilecek farklı seviye sayıları
seviye_sayilari = [2, 4, 8, 16, 32, 64, 128, 256];

quantized_images = cell(1, length(seviye_sayilari));

for i = 1:length(seviye_sayilari)
    seviye_sayisi = seviye_sayilari(i);
    aralik = linspace(0, 255, seviye_sayisi+1); % Kuantize edilecek aralıkları oluştur
    quantized_image = zeros(size(image)); % Kuantize edilmiş görüntüyü saklamak için bir dizi oluştur

    for j = 1:seviye_sayisi
        % Her bir aralık için, o aralıkta bulunan piksellerin orta değerini ata
        quantized_image(image >= aralik(j) & image < aralik(j+1)) = (aralik(j) + aralik(j+1)) / 2;
    end

    quantized_images{i} = uint8(quantized_image);
end

figure;
for i = 1:length(seviye_sayilari)
    subplot(2, 4, i);
    imshow(quantized_images{i});
end

