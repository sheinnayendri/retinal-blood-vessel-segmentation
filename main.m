% read file input
img = uigetfile('*.bmp;*.ppm;*.tif');
im = imread(img);
im = rgb2gray(im);

% masking input image
bw_mask = mask(im);

% default value for segmentation
iuwt_dark = true;
iuwt_inpainting = false;
iuwt_w_levels  = 2:3;
iuwt_w_thresh  = 0.2;
iuwt_px_remove = 0.05;
iuwt_px_fill   = 0.05;

% make wavelet & threshold image
[bw_wavelet, iuwt_dark, iuwt_w_levels, iuwt_w_thresh] = dlg_iuwt(...
                im, bw_mask, iuwt_dark, iuwt_w_levels, iuwt_w_thresh, iuwt_inpainting);
            
figure,imshow(bw_wavelet);

% make segmented
[bw_segmented, iuwt_px_remove, iuwt_px_fill] = dlg_clean_segmented(...
                bw_wavelet, iuwt_px_remove, iuwt_px_fill, bw_mask);

figure,imshow(bw_segmented);
            
            
            