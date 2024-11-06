% read ground truth image
img = uigetfile('*.gif');
im = imread(img);
im(im == 255) = 1;
temp = im';
ground_truth = reshape(temp, 1, []);

% read segmentation result image
img2 = uigetfile('*.gif');
im2 = imread(img2);
im2 = uint8(im2);
temp2 = im2';
result = reshape(temp2, 1, []);

%create confusion matrix
confusionMatrix = confusionmat(result,ground_truth);
true_positive = confusionMatrix(4);
true_negative = confusionMatrix(1);
false_positive = confusionMatrix(2);
false_negative = confusionMatrix(3);
total = true_positive + true_negative + false_positive + false_negative;

%calculate the evaluation score
accuracy = (true_positive + true_negative) / total;
specifity = true_negative / (true_negative + false_positive);
sensitivity = true_positive / (true_positive + false_negative);
precision = true_positive / (true_positive + false_positive);