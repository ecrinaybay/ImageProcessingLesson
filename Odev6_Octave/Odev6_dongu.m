% Görüntüyü yükleme
image = imread('LENNAorijinal.bmp');

% Tuz-biber gürültüsü ekleme
noisy_image = imnoise(image, 'salt & pepper', 0.05);

kernel_size = 3;

[rows, cols] = size(noisy_image);

filtered_image_noisy = zeros(rows, cols, 'uint8');

for i = 1:rows
    for j = 1:cols
        % Kenar pikselleri orijinal olarak bırak
        if i <= kernel_size/2 || i > rows - kernel_size/2 || j <= kernel_size/2 || j > cols - kernel_size/2
            filtered_image_noisy(i, j) = noisy_image(i, j);
        else
            neighborhood = noisy_image(i-floor(kernel_size/2):i+floor(kernel_size/2), j-floor(kernel_size/2):j+floor(kernel_size/2));
            sorted_neighborhood = sort(neighborhood(:));
            median_value = sorted_neighborhood(floor(numel(sorted_neighborhood)/2) + 1);
            filtered_image_noisy(i, j) = median_value;
        end
    end
end

subplot(1, 3, 1);
imshow(image);
title('Orijinal Görüntü');

subplot(1, 3, 2);
imshow(noisy_image);
title('Tuz-Biber Gürültülü Görüntü');

subplot(1, 3, 3);
imshow(filtered_image_noisy);
title('Döngü Bazlı Medyan Filtresi Uygulanmış Gürüntü');

