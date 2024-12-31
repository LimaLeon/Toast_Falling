% Process images named toast_1, toast_2, ..., toast_11
for i = 1:11
    % Reads image
    filename = sprintf('toast_%d.png', i);
    img = imread(filename);

    % Apply the exported segmentation function
    [BW, maskedRGBImage] = createMask(img);

    % Convert the masked RGB image to grayscale
    grayImage = rgb2gray(maskedRGBImage);

    % Apply edge detection on the grayscale image
    edges = edge(grayImage, 'Canny');

    % Save binary Mask (BW) and masked RGB Image
    maskFilename = sprintf('toast_mask_%d.jpg', i);
    imwrite(BW, maskFilename); % Save Binary Mask

    processedFilename = sprintf('processed_toast_%d.png', i);
    imwrite(maskedRGBImage, processedFilename); % Save the masked RGB image

    grayFilename = sprintf('gray_toast_%d.png', i);
    imwrite(grayImage, grayFilename); % Save the grayscale image

    edgeFilename = sprintf('edged_toast_%d.png', i);
    imwrite(edges, edgeFilename); % Save the edges (binary image)

    % Save the Binary Mask (BW) for later use in Python
    maskDataFilename = springf('toast_mask_%d.mat', i);
    save(maskDataFilename, 'BW'); % Save the BW mask

    % Display each step for visualization
    figure;
    subplot(2, 2, 1); imshow(maskedRGBImage); title('Masked RGB Image')
    subplot(2, 2, 2); imshow(grayImage); title('Grayscale Image');
    subplot(2, 2, 3); imshow(edges); title('Edge Detected');
    subplot(2, 2, 4); imshow(BW); title('Binary Mask');
    pause(0.33); % Pause to view each image
end