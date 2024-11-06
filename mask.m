function final_mask=mask(im)
% thresholding
bw_mask = im2bw(im, 0.13);
figure, imshow(bw_mask);

% shrinking using morphology - erode
d1 = max(sum(bw_mask));
d2 = max(sum(bw_mask, 2));
d = max(d1, d2);
siz = max(5, round(d * .025));
final_mask = imerode(bw_mask, ones(siz));
figure,imshow(final_mask);
figure,imshow(im);
imwrite(final_mask,'mask.bmp');