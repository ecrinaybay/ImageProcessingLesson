pkg load image % Görüntü işleme paketini yükleme

dosya_yolu = 'D:\Computer Engineer Department\6. Yarı Yıl(2023-2024)\Görüntü İşlemenin Temelleri\Odev1_Octave\peppers.png'
I = imread(dosya_yolu);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
figure,imshow(I),title('Orijinal Görüntü')
Ig = R; figure,imshow(Ig),title('R Bandına ilişkin Görüntü'),
Ig = G; figure,imshow(Ig),title('G Bandına ilişkin Görüntü'),
Ig = B; figure,imshow(Ig),title('B Bandına ilişkin Görüntü')
