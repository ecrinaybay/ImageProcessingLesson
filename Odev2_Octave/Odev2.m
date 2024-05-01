function Odev2
    dosya_yolu = 'D:\Computer Engineer Department\6. Yarı Yıl(2023-2024)\Görüntü İşlemenin Temelleri\Görseller\Hafta3resimler\peppers.png';
    image = imread(dosya_yolu);
    hsi_image = rgb2hsi(image);
    imshow(hsi_image);
end

function hsi = rgb2hsi(rgb)
    % Normalleştirme (0-1 aralığına getirme)
    r = rgb(:,:,1);
    g = rgb(:,:,2);
    b = rgb(:,:,3);
    r = double(r) / 255;
    g = double(g) / 255;
    b = double(b) / 255;

    % Renk tonunu (Hue) hesaplama
    pay = 0.5 * ((r - g) + (r - b));
    payda = sqrt((r - g).^2 + (r - b) .* (g - b));
    theta = acos(pay ./ payda);

    H = theta;
    H(b > g) = 2*pi - H(b > g);
    H = H / (2*pi); % Radian cinsinden H değerini normalize etme

    % Doygunluğu (Saturation) hesaplama
    min_rgb = min(min(r, g), b);
    S = 1 - (3 ./ (r + g + b )) .* min_rgb;

    % Işıklılığı (Intensity) hesaplama
    I = (r + g + b) / 3;

    % HSI değerlerini birleştirme
    hsi = cat(3, H, S, I);
end


