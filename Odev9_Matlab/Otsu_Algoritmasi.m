close all;
clear all;
clc

Iorj = imread('kugu.jpg');
I = rgb2gray(imread('kugu.jpg'));

n = imhist(I);
N = sum(n);
max = 0;

for i = 1:256
    P(i) = n(i)/N;
end

sigma_values = zeros(1, 26);

threshold_values = zeros(1, 26);

for T = 2:10:255
    w0 = sum(P(1:T));
    w1 = sum(P(T+1:256));
    u0 = dot([0:T-1],P(1:T))/w0;
    u1 = dot([T:255],P(T+1:256))/w1;
    sigma = w0 * w1 *((u1-u0)^2);

    index = (T-2)/10 + 1;
    sigma_values(index) = sigma;
    threshold_values(index) = T;

    if sigma > max
        max = sigma;
        threshold = T + 10;
    end
end

bw = im2bw(I, threshold/255);

subplot(2,2,1);imshow(I), title('Gri Ton Görüntü')
subplot(2,2,2);imhist(I), title('Görüntünün Histogramı')
subplot(2,2,3);stairs(threshold_values, sigma_values);title('0-255 Gri Seviyeleri İçin Pikseller Arası Varyans Değişimi');
xlabel('Gri Seviyeler');
ylabel('Varyans')

% Y eksenindeki değerleri belirledim
xticks(0:50:300);

subplot(2,2,4);imshow(bw), title('Eşiklenmiş Görüntü');

